"" ===================== KEYMAP ====================
nnoremap zC zM
nnoremap zO zR
" I hate escape more than anything else
  inoremap jk <Esc>
  inoremap kj <Esc>

  "" this is for vim-tmux-navigator, because I remapped
"" if I don't use that plugin to uncomment lines - "Map ctrl-movement keys to window switching
"nnoremap <silent> {Left-Mapping} :TmuxNavigateLeft<cr>
"nnoremap <silent> {Down-Mapping} :TmuxNavigateDown<cr>
"nnoremap <silent> {Up-Mapping} :TmuxNavigateUp<cr>
"nnoremap <silent> {Right-Mapping} :TmuxNavigateRight<cr>
"nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>
let g:tmux_navigator_no_mappings = 1
"nnoremap <silent> <c-y> :TmuxNavigateLeft<cr>
"nnoremap <silent> <c-u> :TmuxNavigateDown<cr>
"nnoremap <F8> :TmuxNavigateUp<cr>
"nnoremap <silent> <c-o> :TmuxNavigateRight<cr>

nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>


"
"noremap <silent> <c-i> :TmuxNavigateUp<cr>
" noremap <silent> <c-i> :TmuxNavigateUp<cr>

"# smart pane switching with awareness of vim splits

"" emmet you press Ctrl+e and THEN        PRESS             , (comma)
let g:user_emmet_leader_key='<C-e>'
let g:tagalong_verbose = 1
"" ------ only because I'm using Karabiner and CTRL as hotkey
"nnoremap <C-t> <C-u>
"nnoremap <C-g> <C-y>
"" ------

nnoremap <Leader>gg :GFiles .<CR>

"fuzzy search (content in files)
nnoremap <leader>fc :Commits<CR>
"fuzzy search (all files)
nnoremap <leader>ff :Files<CR>
nnoremap <leader>f/ :Files /<CR>
nnoremap <leader>fh :Files ~<CR>
nnoremap <leader>f. :Files ./<CR>
"fuzzy search (content in files)
nnoremap <leader>fa :Ag<CR>
nnoremap <leader>fg :Rg<CR>

nnoremap <Leader>t :BTags<CR>
nnoremap <Leader>T :Tags<CR>

" When in normal mode, press `bb` and it will call vim-clap to show current open buffers which we can switch to. The <CTRL>+V & <CTRL>+H shortcuts to vertical/horizontal split file opening also work.
"nmap <silent> bb :Clap buffers<CR>
nnoremap <leader>bb :Buffers<CR>
"noremap <leader>l :Align
"nnoremap <leader>b :CtrlPBuffer<CR>
"nnoremap <leader>d :NERDTreeToggle<CR>
"nnoremap <leader>f :NERDTreeFind<CR>
"nnoremap <leader>t :CtrlP<CR>
"nnoremap <leader>T :CtrlPClearCache<CR>:CtrlP<CR>
nnoremap <leader>] :TagbarToggle<CR>
" nnoremap <leader><space> :call whitespace#strip_trailing()<CR>
nnoremap <leader>gg :GitGutterToggle<CR>
noremap <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

nmap <leader>te :10sp<CR>:ter<CR>i<CR>
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

"" Using Command + S  to save
"" you need to set keymap in ITerm2 preferences Keys : 'send escape sequence     [17~    '
nnoremap <F6> :w<CR>
inoremap <F6> <C-O>:w<CR><Esc>
nnoremap <F7> u
inoremap <F7> <C-O>u

nnoremap <F4> :UndotreeToggle<cr>

" " Turn off linewise keys. Normally, the `j' and `k' keys move the cursor down one entire line. with line wrapping on, this can cause the cursor to actually skip a few lines on the screen because it's moving from line N to line N+3 in the file. I want this to act more visually -- I want `down' to mean the next line on the screen
nmap j gj
nmap k gk

" " surround by quotes - frequently use cases of vim-surround
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

" Act like D and C
nnoremap Y y$

" VisualSelection string
nnoremap vv V

"" tabs:
nnoremap tn :tabnew<Space>
nnoremap tl :tabnext<CR>
nnoremap th :tabprev<CR>
nnoremap tH :tabfirst<CR>
nnoremap tL :tablast<CR>

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

"" Zoom Resize vim split"
noremap Zz <c-w>_ \| <c-w>\|
noremap Zo <c-w>=
"" simple zoom window plugin zoomvimtab
nnoremap <C-w>z :ZoomWinTabToggle<cr>

nnoremap <c-w>r :so %<cr>

" !!!!!! check  ctrl [
"" jump for back foreward, it must before nnoremap <c-o> <c-w><right>
"nnoremap <leader>j, <C-o>
"nnoremap <leader>j. <C-i>

"Map ctrl-movement keys to window switching
"nnoremap <C-y> <C-w><Left>
"nnoremap <C-u> <C-w><Down>
"nnoremap <C-i> <C-w><Up>
"nnoremap <C-o> <C-w><Right>

"MOVING LINES
" Normal mode
nnoremap <M-j> :m .+1<CR>==
nnoremap <M-k> :m .-2<CR>==

" Visual mode
vnoremap <M-j> :m '>+1<CR>gv=gv
vnoremap <M-k> :m '<-2<CR>gv=gv

"nnoremap <C-a> ggVG<cr>
inoremap <C-a> <C-o>0
inoremap <C-e> <C-o>$


" push window up/down
nnoremap <C-e> 3<C-e>
nnoremap <C-g> 3<C-y>

" cut without yanking
nnoremap <leader>d "_d
xnoremap <leader>d "_d
vnoremap <leader>d "_d

" indent without kill the selection in vmode
"  test
nmap < <<
nmap > >>
vmap < <gv
vmap > >gv
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
"
" Double leader key for toggling visual-line mode
nnoremap <silent> <Leader><Leader> V
vnoremap <Leader><Leader> <Esc>

" Session stuff
nnoremap <leader>ss :call MakeSession()<cr>
nnoremap <leader>sl :call LoadSession()<cr>
" `SPC l s` - save current session
nnoremap <leader>ss :SSave<CR>

" `SPC l l` - list sessions / switch to different project
nnoremap <leader>sl :SClose<CR>
"
"
" Shortcut to open init.vim
nnoremap <leader>ev :vsp $MYVIMRC<CR><Paste>

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

" Reload Vim configg
 "nnoremap <leader>rr :so ~/.config/nvim/init.vim<CR>

 " Delete buffer completely without messing up window layout
nnoremap <leader>qq :bwipeout<CR>
nnoremap <leader>ww :w<cr>

" Copy the relative path of the current file to the clipboard
nmap <Leader>cf :silent !echo -n % \| pbcopy<Enter>

"lazy js. Append ; at the end of the line
nnoremap <Leader>;; m`A;<Esc>``

" simple notes bindings using fzf wrapper
nnoremap <silent> <Leader>n :call fzf#run(fzf#wrap({'source': 'rg --files ~/notes', 'options': '--header="[notes:search]" --preview="cat {}"'}))<Cr>
nnoremap <silent> <Leader>nd :call fzf#run(fzf#wrap({'source': 'rg --files ~/notes', 'options': '--header="[notes:delete]" --preview="cat {}"', 'sink': function('<SID>DeleteNote')}))<Cr>


" {{{{{{{{{{{{{{{{{{         Delete  back & foreward
" Ctrl O in insert mode will allow you to run a single normal mode command and
" automatically return back to insert mode
"imap <C-;> <C-O>lxi
"imap <C-;> <Esc>wdiwi
"inoremap <C-d> <Esc>xi
imap <C-d> <C-O>x
imap <C-Bs> <Backspace>
"imap <M-;> <Del>
"imap <M-/> <Backspace>
"delete backward<- word by word
imap <M-/> <C-O>cb
" delete Forward->  Word By Word
imap <M-;> <C-O>cw
"imap <C-d> <Esc>wdiwi
" delete Forward ->  to  END string
"inoremap <C-Del> <C-O><S-c>
"}}}}}}}}}}}}}}}}}}

" Create file under cursor
map <leader>gf :e <cfile><cr>

"set timeoutlen=500
"nnoremap <silent> <leader>      :<c-a>WhichKey '<Space>'<CR>
"nnoremap <silent> <localleader> :<c-a>WhichKey  ','<CR>
"nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

nnoremap <C-X> :bdelete<CR>

" "
" Allows you to save files you opened without write permissions via sudo
" if you did not open the file with the correct permissions (sudo perhaps),
" you can issue this command and it will force save the file as like it
" was opened with sudo
cmap w!! w !sudo tee > /dev/null %
"cmap w!! w !sudo tee %    "first edition

" === vim-jsdoc shortcuts ==="
" Generate jsdoc for function under cursor
nmap <leader>z :JsDoc<CR>

" Delete current visual selection and dump in black hole buffer before pasting
" Used when you want to paste over something without it getting copied to
" Vim's default buffer
vnoremap <leader>p "_dP
xnoremap p pgvy

nnoremap <Leader>fu :CtrlPFunky<Cr>
" narrow the list down with a word under cursor
nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>

" {{{ ------- INTEGRATED TERMINAL
"" Integrated Terminal FIRST EDITION
" open new split panes to right and below
set splitright
set splitbelow
" turn terminal to normal mode with escape
tnoremap <S-Esc> <C-\><C-n>

tnoremap <C-j> <C-\><C-n><C-W><C-J>
tnoremap <C-k> <C-\><C-n><C-W><C-K>
tnoremap <C-l> <C-\><C-n><C-W><C-L>
tnoremap <C-h> <C-\><C-n><C-W><C-H>

"" toggle terminal
let g:term_buf = 0
let g:term_win = 0
let g:height = 12
function! TermToggle()
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . g:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        "set notermguicolors
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction
  " toggle terminal on/off
nmap <A-0> :call TermToggle()<cr>
imap <A-0> <esc>:call TermToggle()<cr>
tmap <A-0> <c-\><c-n>:call TermToggle()<cr>
" }}} --------Integrated Terminal

  "" {{{ -------Visual Selection
"" Visual mode pressing * or # searches for the current selection
"" Super useful! From an idea by Michael Naumann
"vnoremap <silent> * :<C-u>call general#VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
"vnoremap <silent> # :<C-u>call general#VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>
"" }}} -------visual selection

" === vim-better-whitespace === "
"   <leader>y - Automatically remove trailing whitespace
nmap <leader>y :StripWhitespace<CR>

"=== Search shorcuts === "
"   <leader>h - Find and replace
"   <leader>/ - Claer highlighted search terms while preserving history
map <leader>h :%s///<left><left>
nmap <silent> // :nohlsearch<CR>
"nmap <silent> <leader>/ :nohlsearch<CR>

" === Easy-motion shortcuts ==="
"   <leader>w - Easy-motion highlights first word letters bi-directionally
map <leader>ew <Plug>(easymotion-bd-w)
" Move to line
map <Leader>er <Plug>(easymotion-bd-jk)
map <Leader>el <Plug>(easymotion-overwin-line)
vmap <Leader>el <Plug>(easymotion-overwin-line)


"" ------------------- Encodings
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

"" -------------------
