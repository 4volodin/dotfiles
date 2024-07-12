
" ============================================================================ "
" FZF {{{
" ============================================================================ "
function! s:find_git_root()
    return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction
command! ProjectFiles execute 'Files' s:find_git_root()
nmap <leader>fp :ProjectFiles<CR>
nmap <leader>mm :Maps<CR>

command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

 command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --glob=\!{.git,.idea,node_modules,vendor,tags} --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
command! -bang -nargs=* Find
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!node_modules/" --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1,
  \   <bang>0)

command! -bang -nargs=* PRg
  \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'dir': system('git rev-parse --show-toplevel 2> /dev/null')[:-2]}, <bang>0)

" only use FZF shortcuts in non diff-mode
if !&diff
    nnoremap <M-p> :Files<Cr>
    nnoremap <M-g> :Rg<Cr>
endif

" Likewise, Files command with preview window
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

let g:rg_command = '
  \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
  \ -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf}"
  \ -g "!{.git,node_modules,vendor}/*" '
command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)

" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

  " use bottom positioned 20% height bottom split
  "let g:fzf_layout = { 'down': '~50%' }
" }}} FZF

" ============================================================================ "
" vim-which-key {{{
" ============================================================================ "
let g:mapleader = "\<Space>"
nnoremap <silent> <leader>kk :<c-u>WhichKey '<Space>'<cr>
" }}} vim-which-key

" ============================================================================ "
" iamcco markdown-preview {{{
" ============================================================================ "
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 0
" }}} makrdown-preview

" ============================================================================ "
" Startify {{{
" ============================================================================ "
let g:signify_sign_delete = '-'

let g:startify_change_to_dir = 1
let g:startify_files_number           = 8
" Update session automatically as you exit vim
let g:startify_session_persistence    = 1

" Simplify the startify list to just recent files and sessions
let g:startify_lists = [
\ { 'type': 'sessions',  'header': ['   Saved sessions'] },
\ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
"\ { 'type': 'dir',       'header': ['   Recent files'] },
\ { 'type': 'files',     'header': ['   Files']            },
\ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
\ ]
let g:startify_bookmarks = [
            \ { 'i': '~/.config/nvim/init.vim' },
            \ { 'z': '~/.zshrc' },
            \ '~/Code',
            \ ]
let g:startify_change_to_vcs_root = 1
let g:rooter_patterns = ['tags', '.git', '.git/']

 let g:startify_custom_header = []
"     \ map(split(system('fortune ~/.config/nvim/fortunes/ | cowsay -W 90 -f small.cow'), '\n'), '"   ". v:val') + ['','']
"
" }}}  Startify

" ============================================================================ "
" White strip space {{{
" ============================================================================ "
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
nmap <leader>y :StripWhitespace<CR>
" }}} White strip space

" ============================================================================ "
" Tmux navigator {{{
" ============================================================================ "
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
" }}} tmux navigator

" ============================================================================ "
" ZoomWintabToggle {{{
" ============================================================================ "
"" simple zoom window plugin zoomvimtab
nnoremap <C-w>z :ZoomWinTabToggle<cr>
" }}} ZoomWinTabToggle

" ============================================================================ "
" Easy motion {{{
" ============================================================================ "
map <leader>e <Plug>(easymotion-f)
map <leader>E <Plug>(easymotion-s)
" }}} easy motion

" ============================================================================ "
" ToggleTerm {{{
" ============================================================================ "
tnoremap <C-j> <C-\><C-n><C-W><C-J>
tnoremap <C-k> <C-\><C-n><C-W><C-K>
tnoremap <C-l> <C-\><C-n><C-W><C-L>
tnoremap <C-h> <C-\><C-n><C-W><C-H>
augroup vimrc
  autocmd TermOpen * :DisableWhitespace
augroup END

lua << EOF
require('toggleterm').setup({
  open_mapping = '<C-g>',
  direction = 'horizontal',
  shade_terminals = true
})
EOF
" }}} ToggleTerm

" ============================================================================ "
" Nvim Tree {{{
" ============================================================================ "
lua << EOF
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

require("nvim-tree").setup()

vim.keymap.set('n', '<C-\\>', '<cmd>NvimTreeFindFile!<cr>')
vim.keymap.set('n', ',,', '<cmd>NvimTreeToggle<cr>')
-- autoclose
vim.api.nvim_create_autocmd({"QuitPre"}, {
    callback = function() vim.cmd("NvimTreeClose") end,
})
EOF
" }}} Nvim Tree

" ============================================================================ "
" LSP completion {{{
" ============================================================================ "
lua << EOF
local luasnip = require 'luasnip'
-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      },
      ['<Tab>'] = function(fallback)
        if vim.fn.pumvisible() == 1 then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
        elseif luasnip.expand_or_jumpable() then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
        else
          fallback()
        end
      end,
      ['<S-Tab>'] = function(fallback)
        if vim.fn.pumvisible() == 1 then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
        elseif luasnip.jumpable(-1) then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
        else
          fallback()
        end
      end,
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      -- { name = 'vsnip' }, -- For vsnip users.
      { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    }),
  })
EOF
" }}} Autocompete LSP

" ============================================================================ "
" LSP {{{
" ============================================================================ "
lua << EOF
local lspconfig = require('lspconfig')
lspconfig.pyright.setup {}
lspconfig.yamlls.setup{
    settings = {
        yaml = {
          schemas = {
            kubernetes = {
              "cronjob.y*ml",
              "deployment.y*ml",
              "service.y*ml",
            }
          },
        },
    },
}
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
--  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
--  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
--  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
--  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
--  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
--  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
--  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
--  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
--  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
--  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
--  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
--  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
--  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
--  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
--  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
--  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
--  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

EOF
" }}} LSP

" Telescope bindings
nnoremap ,f <cmd>Telescope find_files<cr>
nnoremap ,g <cmd>Telescope live_grep<cr>
" Telescope fzf plugin
lua << EOF
require('telescope').load_extension('fzf')
EOF
