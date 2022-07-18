scriptencoding utf-8

source ~/.config/nvim/plugins.vim
source ~/.config/nvim/colorsettings.vim
source ~/.config/nvim/general.vim
source ~/.config/nvim/functions.vim
source ~/.config/nvim/keys.vim
source ~/.config/nvim/commands.vim
source ~/.config/nvim/plugins_config.vim

let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

" =============================================================================
" CHECK OS
" =============================================================================

if has('unix')
  let s:uname = system("uname")
  if s:uname == "Darwin\n"
    " Do Mac stuff here
    set guifont=JetBrains_Mono:h16\ Nerd\ Font\ Mono\:h11
    set rtp+=~/.zinit/plugins/junegunn---fzf
  else
    set guifont=JetBrains_Mono:h16\ Nerd\ Font\ Mono\ 8
    set rtp+=~/.zinit/plugins/junegunn---fzf
  endif
elseif has('win32') || has('win64')
  behave mswin
  set guifont=JetBrains_Mono:h16\Hack\:9
  au GUIEnter * simalt ~n
endif
" ===================================================================

