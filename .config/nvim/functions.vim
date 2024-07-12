" ============================================================================ "
" ChangeBackground {{{
" ============================================================================ "
" ChangeBackground changes the background mode based on macOS's `Appearance`
" setting. We also refresh the statusline colors to reflect the new mode.
function! ChangeBackground()
    if system("defaults read -g AppleInterfaceStyle") =~ '^Dark'
        set background=dark   " for the dark version of the theme
        colorscheme github_dark
    else
        set background=light  " for the light version of the theme
        colorscheme github_light
    endif
    "if &background ==? 'dark'
        "set background=light
        "":silent :!tmux set-environment THEME 'light'
        ""execute "silent !tmux source-file " . shellescape(expand('~/.tmux/themes/github_light.tmux'))
        "colorscheme github_light
    "else
        "set background=dark
        "":silent :!tmux set-environment THEME 'dark'
        ""execute "silent !tmux source-file " . shellescape(expand('~/.tmux/themes/github_dark.tmux'))
        "colorscheme github_dimmed
    "endif
endfunction
" initialize the colorscheme for the first run
call ChangeBackground()
" change the color scheme if we receive a SigUSR1
" autocmd SigUSR1 * call ChangeBackground()
" }}} ChangeBackground

" ============================================================================ "
" Remove trailing whitespaces, Indent and Strip white {{{
" ============================================================================ "
fun! s:StripWS()
  if (&ft =~ 'vader') | return | endif
  highlight ws ctermbg=red guibg=red
  match ws /\s\+$/
  %s/\s\+$//e
endfun

fun! s:IndentSize(n)
  let &ts=a:n
  let &sw=a:n
  let &sts=a:n
  set expandtab
endfun
augroup Files
  au!
  "au BufWritePre *                call s:StripWS()     " remove trailing whitespace before saving buffer
  "au FileType javascript,jsx,json call s:IndentSize(2) " 4 space indents for JS/JSX/JSON
  au FileType markdown,php     call s:IndentSize(4) " 4 space indents for markdown and python
  au FileType help                nmap <buffer> q :q<Cr>
augroup END
" }}} ----- Indent and Strip white

" ============================================================================ "
" DiffOrig {{{
" ============================================================================ "
" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not define already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
  \ | wincmd p | diffthis
endif
" }}}

" ============================================================================ "
" VisualSelection (map */# ) {{{
" ============================================================================ "

function! CmdLine(str)
  exe "menu Foo.Bar :" . a:str
  emenu Foo.Bar
  unmenu Foo
endfunction
function! VisualSelection(direction, extra_filter) range
  let l:saved_reg = @"
  execute "normal! vgvy"
  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")
  if a:direction == 'b'
  execute "normal ?" . l:pattern . "^M"
  elseif a:direction == 'gv'
  call CmdLine("Ack \"" . l:pattern . "\" " )
  elseif a:direction == 'replace'
  call CmdLine("%s" . '/'. l:pattern . '/')
  elseif a:direction == 'f'
  execute "normal /" . l:pattern . "^M"
  endif
  let @/ = l:pattern
  let @" = l:saved_reg
endfunction
"" Visual mode pressing * or # searches for the current selection. Super useful! From an idea by Michael Naumann
"vnoremap <silent> * :<C-u>call general#VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
"vnoremap <silent> # :<C-u>call general#VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>
" }}} VisualSelection

" ============================================================================ "
" Goto Jump {{{
" ============================================================================ "
function! GotoJump()
  jumps
  let j = input("Please select your jump: ")
  if j != ''
    let pattern = '\v\c^\+'
    if j =~ pattern
      let j = substitute(j, pattern, '', 'g')
      execute "normal " . j . "\<c-i>"
    else
      execute "normal " . j . "\<c-o>"
    endif
  endif
endfunction
nmap <leader>jj :call GotoJump()<cr>
"" }}} goto jump

" ============================================================================ "
" Close Buffer without close Window {{{
" ============================================================================ "
function! <SID>BufcloseCloseIt()
  let l:currentBufNum = bufnr("%")
  let l:alternateBufNum = bufnr("#")
  if buflisted(l:alternateBufNum)
  buffer #
  else
  bnext
  endif
  if bufnr("%") == l:currentBufNum
  new
  endif
  if buflisted(l:currentBufNum)
  execute("bdelete! ".l:currentBufNum)
  endif
endfunction
command! Bclose call <SID>BufcloseCloseIt()             " Don't close window, when deleting a buffer
map <leader>bc :Bclose<cr>                              " Close the current buffer

 " Delete buffer completely without messing up window layout
nnoremap <leader>bw :bwipeout<CR>
nnoremap <leader>ww :w<cr>
" }}} Close Buffer

" ============================================================================ "
" MakeSession {{{
" ============================================================================ "
set ssop-=options       " do not store options (vimrc) in a session
"" Make and load method to save session per dir
function! MakeSession()
    let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
    if (filewritable(b:sessiondir) != 2)
        exe 'silent !mkdir -p ' b:sessiondir
        redraw!
    endif
    let b:filename = b:sessiondir . '/session.vim'
    exe "mksession! " . b:filename
endfunction
function! LoadSession()
    let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
    let b:sessionfile = b:sessiondir . "/session.vim"
    if (filereadable(b:sessionfile))
        exe 'source ' b:sessionfile
    else
        echo "No session loaded."
    endif

endfunction
"" Controls the open/close Vim functions
"augroup vimSessions
    "autocmd!
    "" Adding automatons for when entering or leaving Vim
    "au VimEnter * nested :call LoadSession()
   "au VimLeave * :call MakeSession()
"augroup END
nnoremap <leader>ss :call MakeSession()<cr>
nnoremap <leader>sl :call LoadSession()<cr>
nnoremap <leader>ss :SSave<CR>                      " save current session
nnoremap <leader>sl :SClose<CR>                     " list sessions / switch to different project
"
" }}} make session
"
" {{{ Disable Helm diagnostics error in yaml
command! -nargs=0 DisableHelmDiagnostics call DisableHelmDiagnostics()
function! DisableHelmDiagnostics()
    :lua vim.diagnostic.disable()
endfunction
" }}}
