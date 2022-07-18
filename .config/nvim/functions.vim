"" {{{ Switch theme VIM,tmux,iterm2
function! Theme_swap()
    if &background ==? 'dark'
        set background=light
        :silent :!tmux set-environment THEME 'light'
        execute "silent !tmux source-file " . shellescape(expand('~/.tmux/themes/github_light.tmux'))
        silent !osascript -e 'tell app "System Events" to keystroke "w" using {shift down, option down, control down}'
        colorscheme github_light
        ":silent :!export ITERM_PROFILE="light"
    else
        set background=dark
        :silent :!tmux set-environment THEME 'dark'
        execute "silent !tmux source-file " . shellescape(expand('~/.tmux/themes/github_dark.tmux'))
        silent !osascript -e 'tell app "System Events" to keystroke "s" using {shift down, option down, control down}'
        colorscheme github_dimmed
        ":silent :!export ITERM_PROFILE="dark"
    endif
endfunction
command! ThemeSwap call Theme_swap()
""}}}

function! SetColorScheme()
    if $TMUX != ''
        "" check if tmux colorsheme is light or dark, and pick for vim accordingly
        if system('tmux show-environment THEME')[0:9] == 'THEME=dark'
            colorscheme github_dark
            :silent :!tmux set-environment THEME 'dark'
            ""set background=dark
            ""silent !osascript -e 'tell app "System Events" to keystroke "s" using {shift down, option down, control down}'
        else
            colorscheme github_light
            :silent :!tmux set-environment THEME 'light'
            ""set background=light
            ""silent !osascript -e 'tell app "System Events" to keystroke "s" using {shift down, option down, control down}'
        endif
    else
        if $ITERM_PROFILE == 'light'
            set background=light
            colorscheme github_light
        endif
        if $ITERM_PROFILE == 'dark'
            set background=dark
            colorscheme github_dimmed
        endif
    endif
endfunction
call SetColorScheme()

command! ThemeSwapFULL call Toggle_Light_Dark_Colorscheme()
function! Toggle_Light_Dark_Colorscheme()
        if system('tmux show-environment THEME')[0:9] == 'THEME=dark'
            :silent :!tmux set-environment THEME 'light'
            :silent :!tmux source-file ~/.tmux/themes/github_light.tmux
                silent !osascript -e 'tell app "System Events" to keystroke "w" using {shift down, option down, control down}'
        else
            :silent :!tmux set-environment THEME 'dark'
            :silent :!tmux source-file ~/.tmux/themes/github_dark.tmux
            silent !osascript -e 'tell app "System Events" to keystroke "s" using {shift down, option down, control down}'
        endif
    :call SetColorScheme()
endfunction

" {{{ ----- Indent and Strip white
  fun! s:StripWS()
    if (&ft =~ 'vader') | return | endif
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
    au BufWritePre *                call s:StripWS()     " remove trailing whitespace before saving buffer
    "au FileType javascript,jsx,json call s:IndentSize(2) " 4 space indents for JS/JSX/JSON
    au FileType markdown,php,python     call s:IndentSize(4) " 4 space indents for markdown and python
    au FileType help                nmap <buffer> q :q<Cr>
  augroup END
" }}} ----- Indent and Strip white


" {{{ ----- Cscope
" Invoke command. 'g' is for call graph, kinda.
nnoremap <silent> <Leader>gc :call Cscope('3', expand('<cword>'))<CR>
function! Cscope(option, query)
  let color = '{ x = $1; $1 = ""; z = $3; $3 = ""; printf "\033[34m%s\033[0m:\033[31m%s\033[0m\011\033[37m%s\033[0m\n", x,z,$0; }'
  let opts = {
  \ 'source':  "cscope -dL" . a:option . " " . a:query . " | awk '" . color . "'",
  \ 'options': ['--ansi', '--prompt', '> ',
  \             '--multi', '--bind', 'alt-a:select-all,alt-d:deselect-all',
  \             '--color', 'fg:188,fg+:222,bg+:#3a3a3a,hl+:104'],
  \ 'down': '40%'
  \ }
  function! opts.sink(lines)
    let data = split(a:lines)
    let file = split(data[0], ":")
    execute 'e ' . '+' . file[1] . ' ' . file[0]
  endfunction
  call fzf#run(opts)
endfunction
"}}} ----- Cscope

"{{{{{{{{{{{{------------VisualSelection-----------
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
"}}}}}}}}}}}}}}}------------------------------------

"" {{{ ----------- Goto Jump
nmap <leader>jj :call GotoJump()<cr>

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
"" }}}----------- goto jump

"" {{{ ----------- buf close close it , Close Buffer without close Window
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
""}}}


"" {{{ -----------Returns true if paste mode is enabled
function! HasPaste()
  if &paste
  return 'PASTE MODE  '
  en
  return ''
endfunction

"}}}}---------returns true if paste mode is enabled


" {{{-------------------- MakeSession--------------------
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
" }}}--------------------MAKESession--------------------

function! JSFolds()
    " Option 1: // and no space and hashes:
        "if getline(v:lnum) =~ '^//#'
    " Option 2: // and 1 space and hashes:
        "if getline(v:lnum) =~ '^//\+ #'
    " Option 3: spaces/tabs/nothing  and // and 1 space and hashes:
    if getline(v:lnum) =~ '^\s*//\+ #'
    " Option 4: anything and // and 1 space and hashes:
    " DANEGROUS! Potential conflict with code. E.g. print("// # Title");
    " if getline(v:lnum) =~ '//\+ #'

        " Number of hashs # in line that success previous condition (if)
        " determine the fold level
       let repeatHash = len(matchstr(getline(v:lnum), '#\+'))
       return ">" . repeatHash
    endif
    return "="
endfunction
