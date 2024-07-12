#if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
#    tmux attach -t default || tmux new -s default
#fi

# for HOME, END in tmux
if [[ -n "$TMUX" ]]; then
    bindkey "^[[H" beginning-of-line
    bindkey "^[[1~" beginning-of-line
    bindkey "^[[F"  end-of-line
    bindkey "^[[4~" end-of-line
fi

# define plugins before initialize oh-my-zsh
plugins=(
  z
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
source $HOME/.general-functions.sh
source $HOME/.zsh-gpg.zsh
source $HOME/.zsh-starship.zsh
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

unsetopt correct_all # disable autocorrent commands

eval "$(zoxide init zsh)"

# Now this command will run each time you start a new shell instance. It creates a series of environment variables, including HOMEBREW_CELLAR="/opt/homebrew/Cellar" and HOMEBREW_REPOSITORY="/opt/homebrew" and several others.
eval "$(/opt/homebrew/bin/brew shellenv)"

eval "$(starship init zsh)"
# changed the z command of zoxide to cd via
eval "$(zoxide init zsh --cmd cd)"

#bindkey '\t' menu-complete

#https://unix.stackexchange.com/questions/433273/changing-cursor-style-based-on-mode-in-both-zsh-and-vim
# set shape cursor for each Enter new prompt to Pipe | '\e[3 q'
# Set cursor style (DECSCUSR), VT520.
# 0  ⇒  blinking block. 1  ⇒  blinking block (default). 2  ⇒  steady block. 3  ⇒  blinking underline. 4  ⇒  steady underline. 5  ⇒  blinking bar, xterm. 6  ⇒  steady bar, xterm.
_fix_cursor() {
   echo -ne '\e[5 q'
}
precmd_functions+=(_fix_cursor)

# Kube autocomplete
source <(kubectl completion zsh)
source <(helm completion zsh)

# Yandex cloud autocomplete
if [ -f '/Users/voale/yandex-cloud/path.bash.inc' ]; then source '/Users/voale/yandex-cloud/path.bash.inc'; fi                      # The next line updates PATH for Yandex Cloud CLI.
if [ -f '/Users/voale/yandex-cloud/completion.zsh.inc' ]; then source '/Users/voale/yandex-cloud/completion.zsh.inc'; fi            # The next line enables shell command completion for yc.

# Vault Hashicorp autocomplete
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/vault vault
