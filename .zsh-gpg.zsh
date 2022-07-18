#-----------GPG--------------------------
#GPG_TTY is needed in case if you don’t want to use pinentry program from GPGSuite, and must show password dialog in your current active tty
export GPG_TTY=$(tty)

# {{{{{{-
# USE IT ONLY not use gpg-agent-symlink-ssh-auth-socket.plist !!!!!!
# on modern systems, gpgconf --list-dirs agent-ssh-socket will automatically set SSH_AUTH_SOCK to the corrent value and is better hard set old systems SSH_AUTH_SOCK="$HOME/.gnupg/S.gpg-agent.ssh"
#export SSH_AUTH_SOCK=$(/usr/local/bin/gpgconf --list-dirs agent-ssh-socket)
# or for GPGSuite
#export SSH_AUTH_SOCK=$(/usr/local/MacGPG2/bin/gpgconf --list-dirs agent-ssh-socket)
# or for old systems
#export SSH_AUTH_SOCK="$HOME/.gnupg/S.gpg-agent.ssh"
export GPG_TTY SSH_AUTH_SOCK
# }}}}}}

# Check  GPG agent and SSH_AUTH_SOCK
#$ echo $SSH_AUTH_SOCK
#$ ls -la $SSH_AUTH_SOCK
#$ gpgconf --list-dirs agent-ssh-socket
#$ launchctl list | grep gpg-agent

# I have launch agent for this conf to start agent as daemon
#gpgconf --launch gpg-agent

#if ! pgrep gpg-agent &> /dev/null; then
#echo "gpg-agent not running"
#/usr/local/MacGPG2/bin/gpg-agent --homedir /Users/voale/.gnupg --daemon
#fi

#--------------GPG-----------------------
# https://calbryant.uk/blog/how-to-get-the-best-out-of-your-yubikey-with-gpg/#gpg-agent-forwarding
function gssh {
    echo "Preparing host for forwarded GPG agent..." >&2

    # prepare remote for agent forwarding, get socket
    # Remove the socket in this pre-command as an alternative to requiring
    # StreamLocalBindUnlink to be set on the remote SSH server.
    # Find the path of the agent socket remotely to avoid manual configuration
    # client side. The location of the socket varies per version of GPG,
    # username, and host OS.
    remote_socket=$(cat <<'EOF' | command ssh -T "$@" bash
        set -e
        socket=$(gpgconf --list-dirs | grep agent-socket | cut -f 2 -d :)
        # killing agent works over socket, which might be dangling, so time it out.
        timeout -k 2 1 gpgconf --kill gpg-agent || true
        test -S $socket && rm $socket
        echo $socket
EOF
)
    if [ ! $? -eq 0 ]; then
        echo "Problem with remote GPG. use ssh -A $@ for ssh with agent forwarding only." >&2
        return
    fi

    if [ "$SSH_CONNECTION" ]; then
        # agent on this host is forwarded, allow chaining
        local_socket=$(gpgconf --list-dirs | grep agent-socket | cut -f 2 -d :)
    else
        # agent on this host is running locally, use special remote socket
        local_socket=$(gpgconf --list-dirs | grep agent-extra-socket | cut -f 2 -d :)
    fi

    if [ ! -S $local_socket ]; then
        echo "Could not find suitable local GPG agent socket" 2>&1
        return
    fi

    echo "Connecting..." >&2
    ssh -A -R $remote_socket:$local_socket "$@"
}

function _tmux_update_env {
    # tmux must be running
    [ "$TMUX" ] || return

    # update current shell to parent tmux shell (useful for new SSH connections, x forwarding, etc)
    eval $(tmux show-environment -s | grep 'DISPLAY\|SSH_CONNECTION\|SSH_AUTH_SOCK')
}

function _update_agents {
    # take over SSH keychain (with gpg-agent soon) but only on local machine, not remote ssh machine
    # keychain used in a non-invasive way where it's up to you to add your keys to the agent.
    if [ ! "$SSH_CONNECTION" ] && which gpg-connect-agent &>/dev/null; then
        export SSH_AUTH_SOCK=$(gpgconf --list-dirs | grep agent-ssh-socket | cut -f 2 -d :)
        # start GPG agent, and update TTY. For the former only, omit updatestartuptty
        # ssh-agent protocol can't tell gpg-agent/pinentry what tty to use, so tell it
        # if GPG agent has locked up or there is a stale remote agent, remove
        # the stale socket and possible local agent.
        if ! timeout -k 2 1 gpg-connect-agent updatestartuptty /bye > /dev/null; then
            echo "Removing stale GPG agent"
            socket=$(gpgconf --list-dirs | grep agent-socket | cut -f 2 -d :)
            test -S $socket && rm $socket
            killall -KILL gpg-agent 2> /dev/null
            # try again
            timeout -k 2 1 gpg-connect-agent updatestartuptty /bye > /dev/null
        fi
    fi
}

function preexec() {
    _tmux_update_env
    _update_agents
}
