export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

export HOST_UID=$(id -u) # for Docker compose on mac
export ANSIBLE_NOCOWS="1" # disable Cow in Ansible output
export PYTHONUNBUFFERED=1
export NVIM_TUI_ENABLE_TRUE_COLOR=1 # Enabled true color support for terminals

export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/MacGPG2/bin:$PATH
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";

#export PATH=/usr/local/opt/python/libexec/bin:$PATH PATHS
#export PATH="/usr/local/opt/python@2/libexec/bin:$PATH"
#export PATH=/usr/local/opt/mysql-client/bin:$PATH
#export PATH=/usr/local/mysql/bin:/usr/local/mysql/support-files:$PATH
#export PATH=$(brew --prefix openvpn)/sbin:$PATH

VISUAL=nvim; export VISUAL EDITOR=nvim;  export EDITOR

# DISABLE_AUTO_UPDATE="true"   # Uncomment the following line to disable bi-weekly auto-update checks.
export UPDATE_ZSH_DAYS=13      # Uncomment the following line to change how often to auto-update (in days).
ENABLE_CORRECTION="true"       # Uncomment the following line to enable command auto-correction.
COMPLETION_WAITING_DOTS="true" # Uncomment the following line to display red dots whilst waiting for completion.
# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"
# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"


# ====================================================================
# History
# ====================================================================
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"; # Make some commands not show up in history
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=$HISTSIZE
export HISTFILESIZE=$HISTSIZE;
export HISTCONTROL=ignoredups;
# ====================================================================

# ====================================================================
# FZF
# ====================================================================
#bindkey '^r' fzf-history-widget
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob=\!{.git,.idea,node_modules,vendor,tags} --glob="*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf}" 2> /dev/null'
#export FZF_DEFAULT_COMMAND='fd  --type f --follow --hidden --color=always --exclude .git'
#export FZF_DEFAULT_COMMAND='fd -H -t f . $HOME'
#export FZF_ALT_C_COMMAND='fd  --follow --hidden --exclude .git | fzf +m'

# Use ctrl+o to open selected file(s) in VS Code
export FZF_DEFAULT_OPTS="
    --tabstop 2 \
    --extended \
    --ansi \
    --reverse \
    --cycle \
    --multi \
    --bind 'ctrl-o:execute(code {})+abort' \
    --bind ctrl-f:page-down,ctrl-b:page-up \
    --bind ctrl-s:toggle-sort \
    --bind ?:toggle-preview \
    --bind \"ctrl-y:execute-silent(ruby -e 'puts ARGV' {+} | pbcopy)+abort\" \
    --bind 'alt-e:execute($EDITOR {} >/dev/tty </dev/tty)' \
    --preview-window right:60% \
    --bind ctrl-k:preview-up,ctrl-j:preview-down
"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :50 {}'"

export FZF_ALT_C_COMMAND='fd -H -t d . $HOME'
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -100'"

export FZF_CTRL_R_OPTS="
    --preview 'echo {}'
    --preview-window 'down:2:wrap'
    --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
    --header 'Press CTRL-Y to copy command into clipboard'
    --exact
    --expect=ctrl-x
    --border
    "

export VIM_FZF_LOG=$(git config --get alias.l 2>/dev/null | awk '{$1=""; print $0;}' | tr -d '\r')
#  FZF ===============================

# BEGIN ANSIBLE MANAGED BLOCK
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
# END ANSIBLE MANAGED BLOCK
