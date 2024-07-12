" ============================================================================ "
" {{{ GENERAL
" ============================================================================ "
syntax on

set autoread                                        " Automatically re-read file if a change was detected outside of vim

set nobomb                                                                       " utf-8 without BOM
scriptencoding utf-8
set encoding=utf-8 fileformat=unix fileformats=unix,dos                          " ensure we always use this encoding for every file
set fileencodings=utf-8 "",cp1251,koi8-r,ibm866                                  " auto chousing encoding
set termencoding=utf-8
":e ++enc=utf-8                                                                     " open buffer in utf-8 encoding
"set fileencoding=cp-1251                                                           " set and change encoding for current buffer for save buffer to file on a disk

let g:mapleader="\<Space>"
set mouse-=a                                "" enable mouse for vim split

set showmatch                               " Show matching brackets when text indicator is over them
set matchtime=2                             " How many tenths of a second to blink when matching brackets
set clipboard=unnamedplus                   " Yank and paste with the system clipboard, unnamesplus for ssh Yank(copy)

set showcmd                                 "" show last command
set cmdheight=1                             " Better display for messages

set shortmess+=c                            " don't give ,ins-completion-menu, messages.
set signcolumn=yes                          " always show signcolumns

" === TAB/Space settings === "
set expandtab                               " Insert spaces when TAB is pressed.
set tabstop=2                               " Change number of spaces that a <Tab> counts for during editing ops
set shiftwidth=2                            " Indentation amount for < and > commands.
set smartindent                              " auto indentation for new line after press enter
autocmd BufRead,BufNewFile *.make,Makefile setlocal noexpandtab
" autocmd FileType make set noexpandtab shiftwidth=4 softtabstop=0

"" Speed up Vim to x100 espessially for ssh
"set nocursorline " Don't highlight current cursor line and cursor column
set nocursorcolumn                                  " Don't highlight current cursor line and cursor column
set ttyfast
set lazyredraw
set updatetime=300                                  " Smaller updatetime for CursorHold & CursorHoldI
set synmaxcol=256                                   " UTF = x2
syntax sync minlines=256
set regexpengine=1
set hidden                                          " Hides buffers instead of closing them and store buffers in memory ,  this speeds up buffer switching to x25
set confirm                                         "" Confirm when buffer closes
set switchbuf=useopen                               "" Reusing buffer

set number relativenumber                           " Enable line numbers
set noruler                                         " Shows up in preview window when airline is disabled if not

" === Completion Settings === "
set shortmess+=c                                    " Don't give completion messages like 'match 1 of 2' " or 'The only match'
set formatoptions+=j                                " Delete comment character when joining commented lines

" === Search === "
set incsearch
set ignorecase                                      " ignore case when searching
set smartcase                                       " if the search string has an upper case letter in it, the search will be case sensitive

set fillchars+=vert:.                               " Change vertical split character to be a space (essentially hide it)

set splitbelow                                      " Set preview window to appear at bottom
set splitright

set noshowmode                                      " Don't dispay mode in command line (airilne already shows it)
" }}} GENERAL

filetype plugin indent on                           " formating using = key in visual mode

" ============================================================================ "
" General windows commands {{{
" ============================================================================ "
augroup Windows
  au!
  au FocusGained,VimEnter,WinEnter,BufWinEnter * :checktime           " reload file if it has changed on disk
  au VimResized * wincmd =                                            " auto resize splits on resize
augroup END

" Make sure Vim returns to the same line when you reopen a file.
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   execute "normal! g`\"" |
    \ endif

" }}} General windows commands

" ============================================================================ "
" FOLD {{{
" ============================================================================ "
set foldenable
set foldmethod=manual                                         "" zf -create fold for manual mode, zM,zR[(un)foldAll] zd -unfold

set foldlevelstart=10                                         " Fold only long blocks of code.
set foldnestmax=10                                            " Folds can be nested, this ensures max 10 nested folds.

autocmd FileType vim setlocal foldmethod=marker
autocmd FileType py setlocal foldmethod=indent
autocmd FileType yml setlocal foldmethod=indent
autocmd FileType yaml setlocal foldmethod=indent

""https://www.vimfromscratch.com/articles/vim-folding/
autocmd FileType javascript setlocal foldmethod=expr
autocmd FileType javascript setlocal foldexpr=JSFolds()

function! JSFolds()
  let thisline = getline(v:lnum)
  if thisline =~? '\v^\s*$'
    return '-1'
  endif

  if thisline =~ '^import.*$'
    return 1
  else
    return indent(v:lnum) / &shiftwidth
  endif
endfunction
" }}} FOLD

" ============================================================================ "
" {{{ UNDO / BACKUP
" ============================================================================ "
" Keep undo history across sessions, by storing in file. Only works all the time.  when you exit Vim your edit history is saved so you can open the file again 2 days later and undo the changes.
" Edit history is an important part of your context so I think once you get used to it you couldn’t use any other editor without this feature.
if has('persistent_undo')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
  set undolevels=3000
  set undoreload=10000
endif

set backupdir=~/.local/share/nvim/backup " Don't put backups in current dir
set backup
set noswapfile
" }}} UNDO / BACKUP


