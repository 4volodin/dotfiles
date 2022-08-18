

colorls() {
  for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}; done
}

truecol() {
  curl -s https://raw.githubusercontent.com/JohnMorales/dotfiles/master/colors/24-bit-color.sh | bash
	#source ~/test/truecolor.sh
}
truecolor() {
awk -v term_cols="${width:-$(tput cols || echo 80)}" 'BEGIN{
    s="/\\";
    for (colnum = 0; colnum<term_cols; colnum++) {
        r = 255-(colnum*255/term_cols);
        g = (colnum*510/term_cols);
        b = (colnum*255/term_cols);
        if (g>255) g = 510-g;
        printf "\033[48;2;%d;%d;%dm", r,g,b;
        printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
        printf "%s\033[0m", substr(s,colnum%2+1,1);
    }
    printf "\n";
}'
}

fdiff() {
  preview="git diff $@ --color=always -- {-1}"
  git diff $@ --name-only | fzf -m --ansi --preview $preview
}
# git log browser with FZF
fglog() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}



_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf "$@" --preview 'tree -C {} | head -200' ;;
    *)            fzf "$@" ;;
  esac
}

# Распаковка архивов
# example: extract file
extract () {
   if [ -f $1 ] ; then
   case $1 in
   *.tar.bz2)   tar xjf $1        ;;
   *.tar.gz)    tar xzf $1     ;;
   *.bz2)       bunzip2 $1       ;;
   *.rar)       unrar x $1     ;;
   *.gz)        gunzip $1     ;;
   *.tar)       tar xf $1        ;;
   *.tbz2)      tar xjf $1      ;;
   *.tbz)       tar -xjvf $1    ;;
   *.tgz)       tar xzf $1       ;;
   *.zip)       unzip $1     ;;
   *.Z)         uncompress $1  ;;
   *.7z)        7z x $1    ;;
   *)          echo "I don't know how to extract '$1'..." ;;
   esac
   else
   echo "'$1' is not a valid file"
   fi
}
# Запаковать архив
# example: pk tar file
pk () {
   if [ $1 ] ; then
   case $1 in
   tbz)       tar cjvf $2.tar.bz2 $2      ;;
   tgz)       tar czvf $2.tar.gz  $2       ;;
   tar)      tar cpvf $2.tar  $2       ;;
   bz2)    bzip $2 ;;
   gz)        gzip -c -9 -n $2 > $2.gz ;;
   zip)       zip -r $2.zip $2   ;;
   7z)        7z a $2.7z $2    ;;
   *)         echo "'$1' cannot be packed via pk()" ;;
   esac
   else
   echo "'$1' is not a valid file"
   fi
}
# tm - create new tmux session, or switch to existing one. Works from within tmux too. (@bag-man)
# `tm` will allow you to select your tmux session via fzf.
# `tm irc` will attach to the irc session (if it exists), else it will create it.

# ftmux - help you choose tmux sessions
tm() {
    if [[ ! -n $TMUX ]]; then
        # get the IDs
        ID="`tmux list-sessions`"
        if [[ -z "$ID" ]]; then
            tmux new-session
        fi
        create_new_session="Create New Session"
        ID="$ID\n${create_new_session}:"
        ID="`echo $ID | fzf | cut -d: -f1`"
        if [[ "$ID" = "${create_new_session}" ]]; then
            tmux new-session
        elif [[ -n "$ID" ]]; then
            printf '\033]777;tabbedx;set_tab_name;%s\007' "$ID"
            tmux attach-session -t "$ID"
        else
            :  # Start terminal normally
        fi
    fi
}
ftmux () {
  [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
  if [ $1 ]; then
    tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) &&  tmux $change -t "$session" || echo "No sessions found."
}

tmuxx () {
  TARGET_DIR=$(pwd)
  TARGET_NAME=$(basename "$TARGET_DIR")
  LISTSESSIONS=$(tmux list-sessions)
  if grep -q "$TARGET_NAME" <<< "$LISTSESSIONS"; then
    echo "It's there"
    tmux attach-session -t "$TARGET_NAME"
  else
      TARGET_NAME=$(echo $TARGET_NAME | sed 's/\./-/g' )
      tmux new-session -d -s "$TARGET_NAME" -c "$TARGET_DIR"
      if [ $1 ] ; then
          case $1 in
              2)
                  tmux split-window -h -t $SESSION:0.0
                  ;;
              3)
                  tmux split-window -h -t $TARGET_NAME:0.0
                  tmux split-window -v -t $TARGET_NAME:0.1
                  tmux send-keys -t $SESSION:0.0 "cd $TARGET_DIR " Enter
                  tmux send-keys -t $SESSION:0.1 "cd $TARGET_DIR && ls -la" Enter
                  ;;
              4)
                  tmux split-window -h -t $TARGET_NAME:0.0
                  tmux split-window -v -t $TARGET_NAME:0.1
                  tmux split-window -v -t $TARGET_NAME:0.2
                  ;;
              *)
                  cat << EOF
                  tm 2 - 2 panel
                  tm 3 - 3 panel
EOF
                  exit
                  ;;
          esac
      fi

       tmux attach-session -t "$TARGET_NAME"
       tmux switchc -t "$TARGET_NAME"
    fi
}

## switch between light and dark themes
function theme() {
    if [[ -n "$TMUX" ]]; then
        if [[ ! $(tmux show-environment | grep THEME) =~ 'THEME=light'  ]] ; then
            tmux set-environment THEME light
            tmux source-file ~/.tmux/themes/github_light.tmux
            export ITERM_PROFILE="light"
             osascript -e 'tell app "System Events" to keystroke "w" using {shift down, option down, control down}'
        else
            tmux set-environment THEME dark
            tmux source-file ~/.tmux/themes/github_dark.tmux
            export ITERM_PROFILE="dark"
             osascript -e 'tell app "System Events" to keystroke "s" using {shift down, option down, control down}'
        fi
    else
        if [[ $ITERM_PROFILE != light ]]; then
            export ITERM_PROFILE="light"
             osascript -e 'tell app "System Events" to keystroke "w" using {shift down, option down, control down}'
        else
            export ITERM_PROFILE="dark"
             osascript -e 'tell app "System Events" to keystroke "s" using {shift down, option down, control down}'
        fi
    fi
}
# Add a `r` function to zsh that opens ranger either at the given directory or
# at the one autojump suggests
lfj () {
  if [ "$1" != "" ]; then
    if [ -d "$1" ]; then
      lf "$1"
    else
      lf "$(autojump $1)"
    fi
  else
    lf
  fi
	return $?
}
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}
bindkey -s '^o' '^ulfcd\n'

## {{{-------------------- nginx--------------------
function nginxcreate() {
    wget https://gist.githubusercontent.com/kevindees/4e3508357ef46676f7635c545e4fd017/raw/f2c2f2716605e4b22a437058e2a7ebf5f8b775b9/nginx-server-template.conf -O /usr/local/etc/nginx/servers/$1.conf

    sed -i '' "s:{{host}}:$1:" /usr/local/etc/nginx/servers/$1.conf

    if [ "$2" ]; then
        sed  -i '' "s:{{root}}:$2:" /usr/local/etc/nginx/servers/$1.conf
    else
        sed  -i '' "s:{{root}}:$HOME/Sites/$1:" /usr/local/etc/nginx/servers/$1.conf
    fi

    nginxaddssl $1

    nginxrestart

    nvim /usr/local/etc/nginx/servers/$1.conf
 }

 function nginxaddssl() {
     openssl req \
        -x509 -sha256 -nodes -newkey rsa:2048 -days 3650 \
        -subj "/CN=$1" \
        -reqexts SAN \
        -extensions SAN \
        -config <(cat /System/Library/OpenSSL/openssl.cnf; printf "[SAN]\nsubjectAltName=DNS:$1") \
        -keyout /usr/local/etc/nginx/ssl/$1.key \
        -out /usr/local/etc/nginx/ssl/$1.crt

    sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain /usr/local/etc/nginx/ssl/$1.crt
 }

 function nginxedit() {
     nvim /usr/local/etc/nginx/servers/$1
 }

 function nginxlist() {
     ll /usr/local/etc/nginx/servers/
 }
## }}}--------------------nginx--------------------

## {{{--------------------php--------------------

# Make switching versions easy
function phpv() {
    brew unlink php
    brew link --overwrite --force "php@$1"
}
## }}}

## {{{--------------dump databases from Docker (dumpdb _dbname=hostname)
function dumpdb() {
    DATA=`date +"%Y-%m-%d_%H-%M"`
    docker exec $(docker ps | awk '{print $NF}' | grep mysql | grep "$1") \
        mysqldump -uroot --password=root "$1" > "$DATA"-backup-"$1".sql
}
function dumpdbgz() {
    DATA=`date +"%Y-%m-%d_%H-%M"`
    docker exec $(docker ps | awk '{print $NF}' | grep mysql | grep "$1") sh -c \
        "mysqldump -uroot --password=root $1" \
        | gzip > "$DATA"-backup-"$1".sql.gz
}

#}}}

