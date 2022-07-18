" Autocommands {{{
augroup Windows
  au!
  "au BufEnter,WinEnter,WinNew,VimResized *,*.*
  "      \ let &scrolloff=getwininfo(win_getid())[0]['height']/2      " keep cursor centered
  "au FocusGained,VimEnter,WinEnter,BufWinEnter * setlocal cursorline " enable cursorline in focussed buffer
  au FocusGained,VimEnter,WinEnter,BufWinEnter * :checktime          " reload file if it has changed on disk
  "au WinLeave,FocusLost * setlocal nocursorline                      " disable cursorline when leaving buffer
  au VimResized * wincmd =                                           " auto resize splits on resize
augroup END

" При открытии файла курсор будет находиться в 1-й колонке 1-й строки. К счастью, файл viminfo запоминает метки.
" Метка '' содержит позицию в буфере при выходе из него.Читайте это так:
" Если метка '' содержит номер строки больше, чем 1, и не больше, чем номер последней строки в файле, то перепрыгнуть к ней.
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   execute "normal! g`\"" |
    \ endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not define already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
  \ | wincmd p | diffthis
endif

"{{{ -------------- Close Buffer without close Window
" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
" Close the current buffer
map <leader>bc :Bclose<cr>
""}}} ------------bug close close it
d
