# tm - create new tmux session, or switch to existing one. Works from within tmux too. (@bag-man)
# `tm` will allow you to select your tmux session via fzf.
# `tm irc` will attach to the irc session (if it exists), else it will create it.
tm() {
    DIR=$(pwd)
    NAME=$(basename "$DIR")

    [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
    if [ $1 ]; then
      tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1" \; split-window -h -p 30 -c $DIR \; select-pane -L); return
    fi
    if [[ ! -n $TMUX ]]; then
        # get the IDs
        ID="`tmux list-sessions`"
        if [[ -z "$ID" ]]; then
            printf "New Session: "
            read -r SESS
            tmux new-session -s $SESS -c $DIR \; split-window -h -p 35 -c $DIR \; select-pane -L
        fi
        create_new_session="Create New Session"
        ID="$ID\n${create_new_session}:"
        ID="`echo -e "$ID" | fzf | cut -d: -f1`"
        if [[ "$ID" = "${create_new_session}" ]]; then
            printf "New Session: "
            read -r SESS
            tmux new-session -s $SESS -c $DIR \; split-window -h -p 35 -c $DIR \; select-pane -L
            #tmux attach-session -t $SESS
        elif [[ -n "$ID" ]]; then
            printf '\033]777;tabbedx;set_tab_name;%s\007' "$ID"
            tmux attach-session -t "$ID"
        else
            :  # Start terminal normally
        fi
    fi
}

