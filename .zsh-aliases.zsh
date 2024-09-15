# Very Useful aliases!!!!
# analog 'tree' command
# alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
alias gitdot="$(which git) --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME"

alias dotfiles="$(which git) --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME"
alias libfiles="$(which git) --git-dir=$HOME/.libfiles.git/ --work-tree=$HOME"
alias pullall="find . -maxdepth 3 -name .git -type d | rev | cut -c 6- | rev | xargs -I {} git -C {} pull"
alias multipull="find . -mindepth 1 -maxdepth 1 -type d -print -exec git -C {} pull \;"

alias intel="env /usr/bin/arch -x86_64 /bin/zsh --login"
alias arm="env /usr/bin/arch -arm64 /bin/zsh --login"

alias java-arm="export JAVA_HOME=`/usr/libexec/java_home --arch arm64`; java -version"
alias java-intel="export JAVA_HOME=`/usr/libexec/java_home --arch x86_64`; java -version"

# Generate a secure password and copy it to clipboard
alias rand='LC_ALL=C tr -dc "[:alnum:]" < /dev/urandom | head -c 20 | pbcopy'
alias pass='openssl rand -base64 32 | pbcopy'

# terraform
alias tf='terraform'

# vault
alias va='vault'

# k8s
alias k='kubectl'
alias kga='kubectl get all'

# Получить текущий контекст
alias kgc='kubectl config current-context'
# Список всех контекстов
alias klc='kubectl config get-contexts -o name | sed "s/^/  /; /$(kgc)/s/ /*/"'
# Изменить текущий контекст analog for `alias kctx='kubectx'`
alias kc='kubectl config use-context "$(klc | fzf -e | sed "s/^..//")"'


# Получить текущее пространство имен
alias kgn='kubectl config get-contexts --no-headers "$(kgc)" | awk "{print $5}" | sed "s/^$/default/"'
# Список всех пространств имен
alias kln='kubectl get ns -o name | sed "s|^.*\/|  |; /$(kgn)/s/ /*/"'
# Изменить текущее пространство имен, analog for `alias kns='kubens'`
alias kns='kubectl config set-context --current --namespace "$(kln | fzf -e | sed "s/^..//")"'

alias kstatus="{
  clear &&
  echo -e \"\n=== Kubernetes Status ===\n\" &&
  kubectl get --raw '/healthz?verbose' &&
  kubectl version &&
  kubectl get nodes &&
  kubectl cluster-info
} | grep -E 'Ready|ok|passed|running'"

# browser-sync config
# Get the current local IP address
export SERVER_IP=`hostname`

alias -g G='| grep -i'  # for use ls -l G do

alias cdls="cd && ls"
alias frm="fzf | xargs rm -v"
alias rep=project_wide_replace

alias tmuxattach='tmux attach -t $(tmux ls | fzf)'
alias tkill="for s in \$(tmux list-sessions | awk '{print \$1}' | rg ':' -r '' | fzf); do tmux kill-session -t \$s; done;"


alias ff='fzf --print0 -e | xargs -0 -r code'
alias ft="rg --vimgrep --color ansi --no-heading  --ignore-case --no-ignore --hidden --follow -g '!{.git,.idea,node_modules,vendor,tags}/*' --line-number \"$1\"  | \
  fzf --ansi --print0 \
    --no-multi --delimiter=: \
    --preview \"bat --color=always --line-range {2}: {1}\" \
    | cut -d : -f 1-3 | xargs -r -I {} code -g {} \
    "
## output  file without comments
alias viewg="grep '^[^#;/*]'"
alias views="sed -e '/^#/d'"

alias getgpg="gpg --armor --export 4volodin | pbcopy"
alias getssh="ssh-add -L | grep 'cardno' | pbcopy"


alias chmod755='find . -type d -exec chmod 0755 {} \;'
alias chmod644='find . -type f -exec chmod 0644 {} \;'

alias d='dirs -v | head -10'
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

alias npmlist="npm list -g --depth 0"
alias refresh="cd $(pwd)"  # for refresh DIR , because if I opened DIR and then I will move the DIR then I see old files in DIR
alias ref="cd $(pwd)"  # reload current DIR, because if I open DIR and will move the DIR -> I see old files in DIR

alias ll="ls -la"
alias la='ls -la'
alias ls='ls -GFh'
#alias ls="exa -lahF"
#alias lls='exa -al --color=always --group-directories-first' # my preferred listing
#alias la='exa -a --color=always --group-directories-first' #all files and dirs
#alias ll="exa -l --color=always --group-directories-first" #long format
#alias lt='exa -aT --color=always --group-directories-first' #tree listing
#alias lss="colorls -lA --sd"

alias cp='cp -i'                              # confirm copy
alias df='df -h'
alias grep='grep --colour=auto'

alias ducks='du -chsh * | sort -rn | head -11'
alias wea='curl wttr.in'
alias vtop="vtop --theme=wizard"
alias ports="lsof -Pn | grep LISTEN"

# it will launch ranger and dtop you in the last visited folder when you exit
alias ran='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'
alias rang='source ranger'

alias vi='nvim'
alias nv="$(which nvim)"
alias vi="$(which nvim)"
alias pstorm='open -a PhpStorm'
alias pstorm2='open -a /Applications/PhpStorm.app "`pwd`"'
alias code-disable='code --disable-extensions'

alias vfm="vicd"

alias edge='/Applications/Microsoft\ Edge\ Beta.app/Contents/MacOS/Microsoft\ Edge\ Beta.app --remote-debugging-port=2015'
alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --remote-debugging-port=9222'i
alias excel='open -a /Applications/Microsoft\ Excel.app/Contents/MacOS/Microsoft\ Excel'

alias soundreload='sudo killall coreaudiod'
alias zconf='nvim $HOME/.zshrc'
alias torconf='nvim /opt/homebrew/etc/tor/torrc'
alias flushdns="sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder && echo macOS DNS Cache Reset"
alias dnsreload="sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder && echo macOS DNS Cache Reset"
alias bindreload='sudo named-checkconf /usr/local/etc/bind/named.conf && sudo brew services restart bind && flushdns'
alias dnsmasqreload="dnsmasq --test && sudo brew services restart dnsmasq && flushdns"
alias torreload='brew services restart tor'
alias zerotierstop='sudo launchctl unload /Library/LaunchDaemons/com.zerotier.one.plist'
alias zerotierstart='sudo launchctl load /Library/LaunchDaemons/com.zerotier.one.plist'
alias zreload="exec zsh && echo 'ZSH reloaded'"
alias tmuxreload='tmux source-file ~/.tmux.conf'
alias gpgreload='gpg-connect-agent killagent /bye; gpg-connect-agent updatestartuptty /bye; gpg-connect-agent /bye'
alias yubiswitch='gpg-connect-agent "scd serialno" "learn --force" /bye'
alias yabaireload='yabai --restart-service'
alias skhdreload='skhd --restart-service'
alias livereload="browser-sync start --server --files '*.css, *.html, *.js'"
alias livereloadproxy="browser-sync start --proxy 'myproject.dev' --files '*.css, *.html, *.php, *.js'"
# The command alias to start the browser-sync server access the server inside my private network and test the webpage on several devices.
alias livereload2="browser-sync start --server --files . --no-notify --host $SERVER_IP --port 9000"
alias nginxreload="nginx -t && sudo nginx -s reload"
alias nginxrestart="sudo nginx -s stop && sudo nginx"
alias nginxservers="cd /usr/local/etc/nginx/servers"

# Alias old versions
alias php72="/usr/local/Cellar/php@7.2/7.2.34_4/bin/php"
alias php74="/usr/local/Cellar/php@7.4/7.4.21_1/bin/php"
# The latest version of php in be located under the "php" folder not an "@" folder.
alias php80="/usr/local/Cellar/php/8.0.8_1/bin/php"

alias mongod="$(which mongod) — -dbpath ~/mongodb/data/db"
alias mongo="$(which mongo)"
alias mongorun='brew services run mongodb-community' # start - will start mongodb automatically when you login into your macbook, run- only run
alias mongostatus='brew services list'
alias mongostop='brew services stop mongodb-community'

alias brewclean='brew cleanup -s && rm -rf `brew --cache`'
alias xcodecliupgrade='sudo rm -rf /Library/Developer/CommandLineTools && sudo xcode-select --install'
# Update, upgrade all and cleanup
alias brewupgrade='brew update && brew upgrade && brew cu --all --yes --cleanup && mas upgrade && brew doctor; brew missing; brewclean'
# Dump all taps, apps, casks and mac apps into ~/Brewfile
alias brewdump='brew bundle dump --force --describe --file=~/Brewfile'

alias digatekeeper='sudo spctl --master-disable'
alias engatekeeper='sudo spctl --master-enable'

alias setproxy='export http_proxy=socks5://127.0.0.1:9050'  # 'curl ifconfig.me' if it shows your proxy IP and it means that your are success
alias unsetproxy='unset http_proxy'

# in Firefox set only the SOCKS host, port (HTTP Proxy must be disabled)
alias redirect='ssh -D 127.0.0.1:9050 -N voale@traefik'

alias history='fc -il 1'

#alias git='LC_ALL=en_US git'
alias g='git'
alias gs='git status '
alias gss='git status -s'
alias gll='git ll'
alias gla='git la'
alias ga='git add '
alias gb='git branch '
alias gc='git commit '
alias gd='git diff'
alias ggo='git checkout '
alias gk='gitk --all&'
alias gx='gitx --all'
 alias lg="log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --branche"
alias got='git '
alias get='git '
# Delete all remote tracking Git branches where the upstream branch has been deleted
alias gitprune="git fetch --prune && git branch -vv | grep 'origin/.*: gone]' | awk '{print \$1}' | xargs git branch -d"

#will automatically fix tracking for my branch.
alias trackme='git branch --set-upstream-to=origin/$(git symbolic-ref --short HEAD)'

# I sometimes get a bit lazy at checking main for changes before submitting any prs, so again I made a quick shell alias that will rebase main into my branch before I open a pr.
alias rebasemain='git pull origin main --rebase'

# URL-encode strings
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'
#
# Merge PDF files # Usage: `mergepdf -o output.pdf input{1,2,3}.pdf`
alias mergepdf='/System/Library/Automator/Combine\ PDF\ Pages.action/Contents/Resources/join.py'

# Empty the Trash on all mounted volumes and the main HDD. # Also, clear Apple’s System Logs to improve shell startup speed. # Finally, clear download history from quarantine. https://mths.be/bum
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"


# recursively rename photos, videos in current dir and subdirs using Exif metadata (CreateDate)
# https://exiftool.org/filename.html
# https://danielhoherd.com/tech-notes/exiftool/
# https://www.joelotz.com/blog/2022/bulk-rename-photos-to-date-taken-with-exiftool.html
alias renameExif='exiftool -d "%Y-%m-%d__%H%M%S" "-fileName<${CreateDate;}%-c.%e" -r ./'
alias renameTestExif='exiftool -d "%Y-%m-%d__%H%M%S" "-testName<${CreateDate;}%-c.%e" -r ./'
