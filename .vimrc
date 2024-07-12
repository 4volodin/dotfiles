let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

" ============================================================================ "
" ===                               PLUGINS                                === "
" ============================================================================ "
" check whether vim-plug is installed and install it if necessary
let plugpath = expand('<sfile>:p:h'). '/.vim/autoload/plug.vim'
if !filereadable(plugpath)
    if executable('curl')
        let plugurl = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        call system('curl -fLo ' . shellescape(plugpath) . ' --create-dirs ' . plugurl)
        if v:shell_error
            echom "Error downloading vim-plug. Please install it manually.\n"
            exit
        endif
    else
        echom "vim-plug not installed. Please install it manually or install curl.\n"
        exit
    endif
endif

call plug#begin('~/.vim/plugged')

" list Plugins

Plug 'ojroques/vim-oscyank', {'branch': 'main'}              " copy text through SSH with OSC52

call plug#end()
" ============================================================================ "

" ============================================================================ "
" ===                               GENERAL                                === "
" ============================================================================ "
let mapleader=" "
syntax on
scriptencoding utf-8
set autoread
set clipboard=unnamedplus                   " Yank and paste with the system clipboard, unnamesplus for ssh Yank(copy)
set number relativenumber
set expandtab                               " Insert spaces when TAB is pressed.
set softtabstop=2                           " Change number of spaces that a <Tab> counts for during editing ops
set shiftwidth=2                            " Indentation amount for < and > commands.
set smartindent                             " auto indentation for new line after press enter

filetype plugin indent on                   " formating using = key in visual mode


" ============================================================================ "

" ============================================================================ "
" ===                               MAPPING                                === "
" ============================================================================ "

" copy through ssh
nmap <leader>y <Plug>OSCYankOperator
nmap <leader>yy <leader>y_
vmap <leader>y <Plug>OSCYankVisual
autocmd TextYankPost *
    \ if v:event.operator is 'y' && v:event.regname is '+' |
    \ execute 'OSCYankRegister +' |
    \ endif

" copy
nnoremap vv V
nnoremap V v$
" save
nnoremap <F6> :w<CR>
inoremap <F6> <C-O>:w<CR><Esc>

"" ------------------- ENCODING
"Invisible character colors symbol ↲ ↵ ¬.
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59
set listchars=tab:▸\ ,eol:↵,space:·,nbsp:␣,trail:•,extends:>,precedes:<
nmap <leader>lc :set list!<cr>
nmap <leader>lu :e ++ff=unix<cr>
nmap <leader>ld :e ++ff=dos<cr>
nmap <leader> :%s/\r//g<cr>
"" -------------------
" ============================================================================ "



" ============================================================================ "
" ===                               FIXIES                                === "
" ============================================================================ "
"
" {{{ =====================================================
" Change the cursor between Normal and Insert modes in Vim
" (https://stackoverflow.com/questions/6488683/how-to-change-the-cursor-between-normal-and-insert-modes-in-vim)

" reset the cursor on start (for older versions of vim, usually not required)
augroup myCmds
au!
autocmd VimEnter * silent !echo -ne "\e[2 q"
augroup END

let &t_SI.="\e[5 q" "SI = режим вставки
let &t_SR.="\e[3 q" "SR = режим замены
let &t_EI.="\e[1 q" "EI = нормальный режим

" there was a delay when hitting ESC to exit insert mode back to normal mode and show the block as cursor again. So to fix it I found this
set ttimeout   """Понижаем задержку ввода escape последовательностей
set ttimeoutlen=1
set ttyfast
" }}} =====================================================

" {{{ =====================================================
"" open file in last the cursor position
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   execute "normal! g`\"" |
    \ endif
" }}} =====================================================

