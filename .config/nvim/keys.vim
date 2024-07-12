" Reload Vim configg
nnoremap <c-w>R :so %<cr>

"" Turn off linewise keys. Normally, the `j' and `k' keys move the cursor down one entire line. with line wrapping on, this can cause the cursor to actually skip a few lines on the screen because it's moving from line N to line N+3 in the file. I want this to act more visually -- I want `down' to mean the next line on the screen
nmap j gj
nmap k gk

"" Using Command + S  to save
"" you need to set keymap in ITerm2 preferences Keys : 'send escape sequence     [17~    '
nnoremap <F6> :w<CR>
inoremap <F6> <C-O>:w<CR><Esc>

" Act like D and C
nnoremap Y y$
nnoremap V v$

" VisualSelection string
nnoremap vv V

" cut without yanking
nnoremap <leader>d "_d
xnoremap <leader>d "_d
vnoremap <leader>d "_d

" After block yank and paste, move cursor to the end of operated text and don't override register
vnoremap y y`]
vnoremap p "_dP`]
nnoremap p p`]
" Delete current visual selection and dump in black hole buffer before pasting
" Used when you want to paste over something without it getting copied to Vim's default buffer
vnoremap <leader>p "_dP
xnoremap p pgvy

" Don't yank to default register when changing something
nnoremap c "xc
xnoremap c "xc

" Make the dot command work as expected in visual mode (via
" https://www.reddit.com/r/vim/comments/3y2mgt/do_you_have_any_minor_customizationsmappings_that/cya0x04)
vnoremap . :norm.<CR>

" Center screen when jumping to next match
nnoremap n nzz
nnoremap N Nzz
vnoremap n nzz
vnoremap N Nzz

"" Turn off recording
map q <Nop>

" Search / Find
nnoremap / /
nnoremap ,/ :%s///<left><left>
nnoremap g/ :action FindInPath<cr>
nnoremap <silent> <leader>/ :nohlsearch<CR>

nnoremap <leader>ff :Files<CR>
nnoremap <leader>f/ :Files /<CR>
nnoremap <leader>fh :Files ~<CR>
nnoremap <leader>f. :Files ./<CR>
nnoremap <leader>fg :Rg<CR>
nnoremap <Leader>t  :BTags<CR>
nnoremap <Leader>T  :Tags<CR>
nnoremap <leader>bb :Buffers<CR>
nnoremap <leader>gc :Commits<CR>
nnoremap <Leader>gf :GFiles .<CR>
nnoremap <leader>gg :GitGutterToggle<CR>

" ============================================================================ "
" Resize buffers {{{
" ============================================================================ "
" resize current buffer by +/- 5
" Make Arrowkey do something usefull, resize the viewports accordingly and
" it also forces us to use the default Vim movement keys HJKL
nnoremap <Left> :vertical resize -5<CR>
nnoremap <Right> :vertical resize +5<CR>
nnoremap <Up> :resize -5<CR>
nnoremap <Down> :resize +5<CR>
nnoremap <M-y> :vertical resize -5<CR>
nnoremap <M-o> :vertical resize +5<CR>
nnoremap <M-i> :resize -5<CR>
nnoremap <M-u> :resize +5<CR>
" }}} Resize buffers

" ============================================================================ "
" Tabs {{{
" ============================================================================ "
nnoremap tn :tabnew<Space>
nnoremap tl :tabnext<CR>
nnoremap th :tabprev<CR>
nnoremap tH :tabfirst<CR>
nnoremap tL :tablast<CR>
" Switching tabs quickly
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>
" }}} Tabs

" ============================================================================ "
" Moving lines Up/Down {{{
" ============================================================================ "
nnoremap <M-j> :m .+1<CR>==
nnoremap <M-k> :m .-2<CR>==
vnoremap <M-j> :m '>+1<CR>gv=gv
vnoremap <M-k> :m '<-2<CR>gv=gv
" }}}

" ============================================================================ "
" Surround {{{
" ============================================================================ "
map <leader>" ysiw"
map <leader>' ysiw'
map <leader>[ ysiw[
map <leader>] ysiw]
map <leader>{ ysiw{
map <leader>} ysiw}
vmap <leader>" S"
vmap <leader>' S'
vmap <leader>[ S[
vmap <leader>] S]
vmap <leader>{ S{
vmap <leader>} S}
" }}} Surround

" ============================================================================ "
" Indention {{{
" ============================================================================ "
nmap < <<
nmap > >>
vmap < <gv
vmap > >gv
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
" }}} Indention

" ============================================================================ "
" Encoding {{{
" ============================================================================ "
"Invisible character colors symbol ↲ ↵ ¬.
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59
set listchars=tab:▸\ ,eol:↵,space:·,nbsp:␣,trail:•,extends:>,precedes:<
nmap <leader>lc :set list!<cr>
nmap <leader>lu :e ++ff=unix<cr>
nmap <leader>ld :e ++ff=dos<cr>
nmap <leader> :%s/\r//g<cr>

"<F7> EOL format (dos <CR><NL>,unix <NL>,mac <CR>)
set  wildmenu
set  wcm=<Tab>
menu EOL.unix :set fileformat=unix<CR>
menu EOL.dos  :set fileformat=dos<CR>
menu EOL.mac  :set fileformat=mac<CR>
map  <F10> :emenu EOL.<Tab>

"<F8> Change encoding
set wildmenu
set wcm=<Tab>
menu Encoding.utf-8   :e ++enc=utf-8    <CR>
menu Encoding.koi8-r  :e ++enc=koi8-r   <CR>
menu Encoding.cp1251  :e ++enc=cp1251   <CR>
menu Encoding.cp866   :e ++enc=cp866    <CR>
map <F8> :emenu Encoding.<Tab>

"<Shift+F8> Convert file encoding
set  wildmenu
set  wcm=<Tab>
menu FEnc.cp1251    :set fenc=cp1251<CR>
menu FEnc.koi8-r    :set fenc=koi8-r<CR>
menu FEnc.cp866     :set fenc=ibm866<CR>
menu FEnc.utf-8     :set fenc=utf-8<CR>
menu FEnc.ucs-2le   :set fenc=ucs-2le<CR>
map  <S-F8> :emenu FEnc.<Tab>
" }}} ENCODING

