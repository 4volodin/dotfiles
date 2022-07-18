syntax on

set nobomb
set encoding=utf-8 fileformat=unix fileformats=unix,dos                          " ensure we always use this encoding for every file
set fileencodings=utf-8 "",cp1251,koi8-r,ibm866                                  " auto chousing encoding
set termencoding=utf-8
":e ++enc=utf-8                                                                     " open buffer in utf-8 encoding
"set fileencoding=cp-1251                                                           " set and change encoding for current buffer for save buffer to file on a disk

let g:mapleader="\<Space>"
set  mouse-=a                               "" enable mouse for vim split

set showmatch                             " Show matching brackets when text indicator is over them
set matchtime=2                           " How many tenths of a second to blink when matching brackets
set showcmd                              "" show last command
set clipboard=unnamedplus                   " Yank and paste with the system clipboard, unnamesplus for ssh Yank(copy)
set cmdheight=3                             " Better display for messages

set shortmess+=c                            " don't give |ins-completion-menu| messages.
set signcolumn=yes                          " always show signcolumns
" === TAB/Space settings === "
set expandtab                               " Insert spaces when TAB is pressed.
set softtabstop=2                           " Change number of spaces that a <Tab> counts for during editing ops
set shiftwidth=2                            " Indentation amount for < and > commands.

"" Speed up Vim to x100 espessially for ssh
"set nocursorline " Don't highlight current cursor line and cursor column
set nocursorcolumn                          " Don't highlight current cursor line and cursor column
set ttyfast
set lazyredraw
set updatetime=300                          " Smaller updatetime for CursorHold & CursorHoldI
set synmaxcol=256                           " UTF = x2
syntax sync minlines=256
set regexpengine=1
set hidden                                  " Hides buffers instead of closing them and store buffers in memory ,  this speeds up buffer switching to x25
set confirm                                 "" Confirm when buffer closes
set switchbuf=useopen                       "" Reusing buffer


set autoread                                        " Automatically re-read file if a change was detected outside of vim
set number relativenumber                           " Enable line numbers
" Disable line/column number in status line
set noruler                                 " Shows up in preview window when airline is disabled if not
set cmdheight=1                             " Only one line for command line

" === Completion Settings === "
set shortmess+=c                            " Don't give completion messages like 'match 1 of 2' " or 'The only match'

" for Sensible plugin
set formatoptions+=j " Delete comment character when joining commented lines

" === Search === "
set incsearch
set ignorecase                                      " ignore case when searching
set smartcase                                       " if the search string has an upper case letter in it, the search will be case sensitive

set fillchars+=vert:.                               " Change vertical split character to be a space (essentially hide it)

set splitbelow                                      " Set preview window to appear at bottom
set splitright

" Don't dispay mode in command line (airilne already shows it)
set noshowmode

"-- FOLDING --
set foldenable
set foldmethod=manual "" zf -create fold for manual mode, zd -unfold
set foldmethod=marker
"set foldmethod=indent " Folding based on indentation.
set foldlevelstart=10 " Fold only long blocks of code.
set foldnestmax=10 " Folds can be nested, this ensures max 10 nested folds.
autocmd FileType vim setlocal foldmethod=marker
autocmd FileType py setlocal foldmethod=indent
""https://www.vimfromscratch.com/articles/vim-folding/
autocmd FileType javascript setlocal foldmethod=expr
autocmd FileType javascript setlocal foldexpr=JSFolds()

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file. Only works all the time.  when you exit Vim your edit history is saved so you can open the file again 2 days later and undo the changes.
"Edit history is an important part of your context so I think once you get used to it you couldn’t use any other editor without this feature.
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
