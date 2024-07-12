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

" ============================================================================ "
" PLUGINS {{{
" ============================================================================ "
call plug#begin('~/.config/nvim/plugged')

" User interface
Plug 'mhinz/vim-startify'
Plug 'mbbill/undotree'
Plug 'troydm/zoomwintab.vim'
Plug 'christoomey/vim-tmux-navigator'

"" Text editing
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'machakann/vim-highlightedyank'
Plug 'terryma/vim-expand-region'                            " select text in expand region: + _
Plug 'michaeljsmith/vim-indent-object'                      " select indented text: vii, vai, vaI    https://www.seanh.cc/2020/08/08/vim-indent-object/
Plug 'easymotion/vim-easymotion'
Plug 'ntpeters/vim-better-whitespace'

" Colorscheme / statusline / icons
Plug 'projekt0n/github-nvim-theme'
Plug 'nvim-lualine/lualine.nvim'
Plug 'akinsho/bufferline.nvim'

" File explorer
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.3' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" Find
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Terminal
Plug 'akinsho/toggleterm.nvim'

" Static code check
Plug 'editorconfig/editorconfig-vim'

" Git
Plug 'airblade/vim-gitgutter'

" specific files
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'ekalinin/Dockerfile.vim', { 'for': 'Dockerfile' }

" Others
Plug 'ojroques/vim-oscyank', {'branch': 'main'}              " copy text through SSH with OSC52

" LSP and completion
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'

call plug#end()
" }}} Plugins
