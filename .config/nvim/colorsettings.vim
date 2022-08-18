" =============================================================================
" SET THE GUI COLOR SCHEME
" =============================================================================

set t_Co=256
" checks if your terminal has 24-bit color support(TrueColor)
if has("termguicolors")
  set termguicolors
  hi LineNr ctermbg=NONE guibg=NONE
  " set Vim-specific sequences for RGB colors
  if exists('$TMUX')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  endif
endif

" NOTE: Configuration needs to be set BEFORE loading the color scheme with `colorscheme` command
let g:github_function_style = "italic"
let g:github_sidebars = ["qf", "vista_kind", "terminal", "packer"]

" Change the "hint" color to the "orange" color, and make the "error" color bright red
let g:github_colors = {
  \ 'hint': 'orange',
  \ 'error': '#ff0000'
\ }

"colorscheme  onedark
"colorscheme github_dimmed
colorscheme github_light

lua << EOF
require('lualine').setup {
  options = {
    theme = 'github_light', -- or "auto"
    -- ... your lualine config
  }
}
EOF

lua << EOF
require("bufferline").setup{}
EOF
nnoremap <silent><Tab> :BufferLineCycleNext<CR>
nnoremap <silent><S-Tab> :BufferLineCyclePrev<CR>


" Call method on window enter
augroup WindowManagement
  autocmd!
  autocmd WinEnter * call Handle_Win_Enter()
augroup END

" Change highlight group of preview window when open
function! Handle_Win_Enter()
  if &previewwindow
    setlocal winhighlight=Normal:MarkdownError
  endif
endfunction

