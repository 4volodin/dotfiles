" =============================================================================
" Colorscheme {{{
" =============================================================================

set t_Co=256
" checks if your terminal has 24-bit color support(TrueColor)
if has("termguicolors")
  set termguicolors                     "termguicolors берет цветовую палитру из эмулятора терминала.
  hi LineNr ctermbg=NONE guibg=NONE
  " set Vim-specific sequences for RGB colors
  if exists('$TMUX')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  endif
endif


lua << EOF
require('lualine').setup {
  options = {
    theme = 'auto'
  }
}
EOF

lua << EOF
require("bufferline").setup{}
EOF

nnoremap <silent><Tab> :BufferLineCycleNext<CR>
nnoremap <silent><S-Tab> :BufferLineCyclePrev<CR>
" }}} colorscheme
