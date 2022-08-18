[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# otherwise I get error gpg: signing failed: Inappropriate ioctl for device
export GPG_TTY=$(tty)

# Prefer US English and use UTF-8.
export LANG='en_US.UTF-8';
export LC_ALL='en_US.UTF-8';

export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
#bind -x '"\C-n": vim $(fzf);'

VISUAL=nvim; export VISUAL EDITOR=nvim; export EDITOR

#export VISUAL='code -w'
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
export LANG=en_US

# needed for tmux colors
export TERM="screen-256color"
#
# Make some commands not show up in history
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help";
# Larger bash history (default is 500)
export HISTSIZE=32768;
export HISTFILESIZE=$HISTSIZE;
export HISTCONTROL=ignoredups;
export HISTTIMEFORMAT="%d/%m/%y %T "
####################################################################################################
#################################### Alias Definitions #############################################
####################################################################################################

# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.

if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

# `Docker` Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.docker_aliases, instead of adding them here directly.

if [ -f ~/.docker_aliases ]; then
    source ~/.docker_aliases
fi

# `Docker` Function definitions.
# You may want to put all your additions into a separate file like
# ~/.docker_functions, instead of adding them here directly.

if [ -f ~/.docker_functions ]; then
    source ~/.docker_functions
fi

# functions definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_functions, instead of adding them here directly.

if [ -f ~/.bash_functions ]; then
    source ~/.bash_functions
fi

# argcomplete - Bash tab completion for argparse
# See: https://github.com/kislyuk/argcomplete
if [ -f ~/.python-argcomplete.sh ]; then
    source ~/.python-argcomplete.sh
fi

####################################################################################################
#################################### Input edits and Key-bindings ###################################
####################################################################################################

if [[ $- == *i* ]]; then
    # Disable ctrl-s and ctrl-q
    stty -ixon

    bind '"\e[A": history-search-backward'
    bind '"\e[B": history-search-forward'
    bind '"\e[1;5C": forward-word'
    bind '"\e[1;5D": backward-word'
    bind '"\e[5C": forward-word'
    bind '"\e[5D": backward-word'
    bind '"\e\e[C": forward-word'
    bind '"\e\e[D": backward-word'
    # Flip through autocompletion matches with Shift-Tab.
    bind '"\e[Z": menu-complete'

    # List all matches in case multiple possible completions are possible
    bind 'set show-all-if-ambiguous on'
    # Make Tab autocomplete regardless of filename case
    bind 'set completion-ignore-case on'
    # Allow UTF-8 input and output, instead of showing stuff like $'\0123\0456'
    bind 'set input-meta on'
    bind 'set output-meta on'
    bind 'set convert-meta off'
    # Be more intelligent when auto-completing by also looking at the text after
    # the cursor.
    bind 'set skip-completed-text on'
    # Immediately add a trailing slash when autocompleting symlinks to directories
    bind 'set mark-symlinked-directories on'
    # Show all autocomplete results at once
    bind 'set page-completions off'
    # If there are more than 200 possible completions for a word, ask to show them all
    bind 'set completion-query-items 200'
fi

####################################################################################################
################################### SHell Options ##################################################
####################################################################################################
# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob
# Append to the Bash history file, rather than overwriting it
shopt -s histappend
# Save all lines of a multiple-line command in the same history entry.
shopt -s cmdhist
# Autocorrect typos in path names when using `cd`
shopt -s cdspell
# Allows me to cd into a dir by just typing the dir name
shopt -s autocd
# append to the history file, don't overwrite it
shopt -s histappend
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar
# Includes file names beginning with a '.' in the results of path name globbing.
shopt -s dotglob

#source ~/.bash_profile

#PATH="usr/local/bin:bin:/usr/bin:/sbin:/usr/sbin"
#export PATH

#PS1="\u@\h: "
#PS1='\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] '

#PS1="\[\033[1;33;1;32m\]\u@\h:\[\033[1;31m\]\w$ \[\033[0m\]\[\033[0m\]"
#PS1="\[\e[0;31m\]\u\[\e[m\] \[\e[1;34m\]\w[\e[m\] \[\e[1;32m\]\$\[\e[m\]"
#PS1="\[\033[1;33;1;32m\]\u@\h:\[\033[1;31m\]\w$ \[\033[0m\]\[\033[0m\]"


__git_status_info() {
    STATUS=$(git status 2>/dev/null |
    awk '
    /^On branch / {printf($3)}
    /^Changes not staged / {printf("|?Changes unstaged!")}
    /^Changes to be committed/ {printf("|*Uncommitted changes!")}
    /^Your branch is ahead of/ {printf("|^Push changes!")}
    ')
    if [ -n "${STATUS}" ]; then
        echo -ne " (${STATUS}) [Last updated: $(git show -1 --stat | grep ^Date | cut -f4- -d' ')]"
    fi
}
__git_status() {
    STATUS=$(git status 2>/dev/null |
    awk '
    /^On branch / {printf($3)}
    /^You are currently rebasing/ {printf("rebasing %s", $6)}
    /^Initial commit/ {printf(" (init)")}
    /^Untracked files/ {printf("|+")}
    /^Changes not staged / {printf("|?")}
    /^Changes to be committed/ {printf("|*")}
    /^Your branch is ahead of/ {printf("|^")}
    ')
    if [ -n "$STATUS" ]; then
        echo -ne " (${STATUS}) [Last updated: $(git show -1 --stat | grep ^Date | cut -f4- -d' ')]"
    fi
}
#__disk_space=$(/bin/df --output=pcent /home | tail -1)
_ip_add=$(ip addr | grep -w inet | awk '{if (NR==2) {$0=$2; gsub(/\//," "); print $1;}}')
#__ps1_startline="\[\033[0;32m\]\[\033[0m\033[0;38m\]\u\[\033[0;36m\]@\[\033[0;36m\]\h on ${_ip_add}:\w\[\033[0;32m\] \[\033[0;34m\] [disk:${__disk_space}] \[\033[0;32m\]"
__ps1_startline="\[\033[0;32m\]\[\033[0m\033[0;38m\]\u\[\033[0;36m\]@\[\033[0;36m\]\h on ${_ip_add}:\w\[\033[0;32m\] \[\033[0;34m\] [disk:${__disk_space}] \[\033[0;32m\]"


__ps1_endline="\[\033[0;32m\]└─\[\033[0m\033[0;31m\] [\D{%F %T}] \$\[\033[0m\033[0;32m\] >>>\[\033[0m\] "
# If id command returns zero, you got root access.

if [ $(id -u) -eq 0 ];
then # you are root, set red colour prompt
  #PS1="\\[$(tput setaf 1)\\]\\u@\\h:\\w #\\[$(tput sgr0)\\]"
  export PS1="${__ps1_startline}\n\$(__git_status_info)\n${__ps1_endline}"
else # normal
  export PS1='\[\033[07;33;01m\]\n\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(__git_status)\$ '
  #PS1='$(printf "%*s\r%s" $(( COLUMNS-1 )) "[$(git branch 2>/dev/null | grep '^*' | sed s/..//)] $(date +%H:%M:%S)" "heipei@wavefront:$PWD$ ")'

fi

# ------------
IP_ADD=`ip addr | grep -w inet | awk '{if (NR==2) {$0=$2; gsub(/\//," "); print $1;}}'`

#_MEM=$(free -m | awk '{if (NR==2){printf "%s/%sMB (%.2f%%) ", $3,$2,$3*100/$2} }')
 #_DISK_USAGE=$(df -h | awk '$NF=="/"{printf "%d/%dGB (%s)\n", $3,$2,$5}')                                                                         _CPU_LOAD=$(top -bn1 | grep load | awk '{printf "%.2f\n", $(NF-2)}')

printf "${LIGHTGREEN}Hello, ${USER}@${IP_ADD}\n"
echo "Memory: " $_MEM
echo "Disk Usage: " $_DISK_USAGE
printf "CPU_load: ${_CPU_LOAD} \n"

printf "Today is, $(date)\n";
printf "Sysinfo: $(uptime)\n"
#printf "\n$(fortune | cowsay)${NC}\n"



#export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"


## pyenv configs
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

## comparing your current branch to master
# fdiff master...
## comparing the changes between two commits
# fdiff 4c674950..6d88a7bfd8
fdiff() {
  preview="git diff $@ --color=always -- {-1}"
  git diff $@ --name-only | fzf -m --ansi --preview $preview
}


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#eval "$(starship init bash)"
