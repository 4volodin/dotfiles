" ============================================================================ "
" ===                               PLUGINS                                === "
" ============================================================================ "
" check whether vim-plug is installed and install it if necessary
let plugpath = expand('<sfile>:p:h'). '/autoload/plug.vim'
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

call plug#begin('~/.config/nvim/plugged')


Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }

Plug 'ntpeters/vim-better-whitespace'               " Trailing whitespace highlighting & automatic fixing

"Plug 'wakatime/vim-wakatime'
Plug 'rizzatti/dash.vim'
"Plug 'tpope/vim-sensible'
"
""Plugin for SQL databases
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'

Plug 'ekalinin/Dockerfile.vim', { 'for': 'Dockerfile' }
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

Plug 'easymotion/vim-easymotion'                            " Improved motion in Vim

Plug 'terryma/vim-expand-region'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'troydm/zoomwintab.vim'

Plug 'tpope/vim-repeat'
Plug 'michaeljsmith/vim-indent-object'

Plug 'scrooloose/nerdcommenter'                             "Plug 'tpope/vim-commentary'
"Plug 'puremourning/vimspector'                                  " debugger


Plug 'mbbill/undotree'                                          " Undotree gives you a tree view with the buffer changes where you can navigate through them.
Plug 'machakann/vim-highlightedyank'                            " highlight yanked text

"Plug 'wellle/tmux-complete.vim'

" PlugInstall and PlugUpdate will clone fzf in ~/.fzf and run the install script
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'haya14busa/incsearch.vim'
"Plug 'Shougo/denite.nvim'                                      " Denite - Fuzzy finding, buffer management

Plug 'honza/vim-snippets'
Plug 'editorconfig/editorconfig-vim'

" Tags
Plug 'ludovicchabant/vim-gutentags'
Plug 'liuchengxu/vista.vim'


" === Git Plugins === "
Plug 'mhinz/vim-signify'                                " Enable git changes to be shown in sign column
Plug 'tpope/vim-fugitive'
Plug 'rbong/vim-flog'
"Plug 'airblade/vim-gitgutter'
Plug 'rhysd/git-messenger.vim'
Plug 'jreybert/vimagit'

Plug 'AndrewRadev/tagalong.vim'
Plug 'Shougo/echodoc.vim'                                   " Print function signatures in echo area

" === Javascript Plugins === "
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'heavenshell/vim-jsdoc'                                " Generate JSDoc commands based on function signature

" === Syntax Highlighting === "
Plug 'sheerun/vim-polyglot'
Plug 'othree/javascript-libraries-syntax.vim'                           " Syntax highlighting for javascript libraries

" === File navigation ===
Plug 'ptzz/lf.vim'                                          " Use lf.vim and vim-floaterm together
Plug 'voldikss/vim-floaterm'
Plug 'christoomey/vim-tmux-navigator'                       " Tmux/Neovim movement integration - performance is bad
Plug 'rbgrouleff/bclose.vim'
" interesting file navigator in modal window
"Plug 'liuchengxu/vim-clap'

" Projects
Plug 'mhinz/vim-startify'                           " project
Plug 'airblade/vim-rooter' "for startify in there is .git or tags file or smth I'll add

" Colorscheme / statusline / icons
Plug 'projekt0n/github-nvim-theme'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'nvim-lualine/lualine.nvim'
Plug 'akinsho/bufferline.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ryanoasis/vim-devicons'

Plug 'justinmk/vim-sneak'                           " if enable it plugin -> stop working 's' in visual mode for Surrounding Plugin
Plug 'tpope/vim-surround'
Plug 'machakann/vim-sandwich'
"Plug 'terryma/vim-multiple-cursors'

" display the hexadecimal colors - useful for css and color config
"Plug 'ap/vim-css-color'

call plug#end()
