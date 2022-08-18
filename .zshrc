
# define plugins before initialize oh-my-zsh
plugins=(
  git
  docker
  autoupdate
  colored-man-pages
  fzf-tab
  zsh-completions
  zsh-autosuggestions
  zsh-syntax-highlighting
)
source $HOME/.zsh-env.zsh
source $HOME/.zsh-aliases.zsh
source $HOME/.zsh-common-functions.zsh
source $HOME/.zsh-functions.zsh
source $HOME/.zsh-gpg.zsh
source $HOME/.oh-my-zsh/oh-my-zsh.sh
source $HOME/.asdf/asdf.sh
source $HOME/.asdf/completions/asdf.bash

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh               #  To accept useful key bindings and fuzzy completion

# every time we load .zshrc, ditch duplicate path entries
typeset -U PATH fpath

# https://gist.github.com/raftheunis87/607682946d0ef041ce1ad28c37456b7d
# activate completion system first if you are not using something like oh-my-zsh
# enable autocompletion for plugin zsh-completions using $fpath
autoload -U compinit && compinit
# Cache completion if nothing changed - faster startup time
typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
  compinit -i
else
  compinit -C -i
fi

# Enhanced form of menu completion called `menu selection'
#zmodload -i zsh/complist

# Options
# https://www.viget.com/articles/zsh-config-productivity-plugins-for-mac-oss-default-shell/
setopt auto_cd # cd by typing directory name if it's not a command
setopt auto_list # automatically list choices on ambiguous completion
setopt auto_menu # automatically use menu completion
setopt always_to_end # move cursor to end if word had one match
setopt hist_ignore_all_dups # remove older duplicate entries from history
setopt hist_reduce_blanks # remove superfluous blanks from history items
setopt inc_append_history # save history entries as soon as they are entered
setopt share_history # share history between different instances
setopt interactive_comments # allow comments in interactive shells
# Опции истории команд
setopt extended_history #Добавляет в историю время выполнения команды.
setopt HIST_REDUCE_BLANKS ## Удалять из файл истории пустые строки
setopt HIST_NO_STORE # команды «history» и «fc» в историю заноситься не будут
setopt NOTIFY #Сообщать при изменении статуса фонового задания

unsetopt correct_all # disable autocorrent commands

eval "$(zoxide init zsh)"

# Now this command will run each time you start a new shell instance. It creates a series of environment variables, including HOMEBREW_CELLAR="/opt/homebrew/Cellar" and HOMEBREW_REPOSITORY="/opt/homebrew" and several others.
eval "$(/opt/homebrew/bin/brew shellenv)"

eval "$(starship init zsh)"

#bindkey '\t' menu-complete

