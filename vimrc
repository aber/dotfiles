"
" -------------> URLs <--------------------
" http://vim.wikia.com/wiki/Xterm256_color_names_for_console_Vim
" http://vim.wikia.com/wiki/256_colors_in_vim
" http://vim.wikia.com/wiki/Configuring_the_cursor 
" http://mislav.uniqpath.com/2011/12/vim-revisited/
" https://github.com/mislav/vimfiles
" http://vimcasts.org/episodes/synchronizing-plugins-with-git-submodules-and-pathogen/
"
" -------------> Notizen <--------------------
" map ,l :w\|lessc % %:r<br>
" %:r ohne ext, %:p absoluter pfad, %:h head/verzeichnis
" :scriptnames
" ab, ib ()
" aB, iB {}
" at, it tags
" a", i" "
" f, t, ; ,
" :A
" C-o back in jumplist
" C-t back in taglist, C-] search tag
"
" Tabline config
" http://vim.1045645.n5.nabble.com/Custom-tabline-Non-gui-vim-td1190544.html
"
" <cfile> oder <C-r><C-f> file under cursor
"
" open all c files in a tab each
" :args *.c | tab all
"
" -------------> Themes <--------------------
" desert256, inkpot, 256-grayvim, or gardener.
" desert, pablo, peachpuff, torte, zellner
" solarized
"
" colors orange: 166
" --------------------------------------------

" To disable a plugin, add it's bundle name to the following list
let g:pathogen_disabled = ['atp', 'vim-latex', 'latex-box']
" for some reason the csscolor plugin is very slow when run on the terminal
" but not in GVim, so disable it if no GUI is running
if !has('gui_running')
  call add(g:pathogen_disabled, 'csscolor')
endif
runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

set nocompatible                " choose no compatibility with legacy vi
syntax enable                   " syntax highlighting, enable keeps hi, on overrules
"syntax on
set encoding=utf-8
set showcmd                     " display incomplete commands
filetype plugin indent on       " load file type plugins + indentation

"" Whitespace
set wrap                      " don't wrap lines
set tabstop=2 shiftwidth=2      " a tab is two spaces (or set this to 4)
set expandtab                   " use spaces, not tabs (optional)
set backspace=indent,eol,start  " backspace through everything in insert mode
set textwidth=0
set linebreak                   " break at end of words

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

" %%% leader %%%
let mapleader = ","
let g:mapleader = ","
let maplocalleader = "_"
let g:maplocalleader = "_"

" %%% display %%%

" Use the same symbols as TextMate for tabstops and EOLs
set number
set list
set listchars=tab:▸\ ,eol:¬,trail:·    " help listchars
set cursorline

" set fcs?
set fillchars+=fold:\ 
set fillchars+=vert:\ 

" syntastic
let g:syntastic_javascript_checker = "jshint"

" %%% key mappings %%%

nnoremap <leader><leader> <c-^>
" toggle hlsearch
"nnoremap <silent> <Esc><Esc> :set hlsearch!<CR>

" open the file under the cursor in new tab
map <leader>gf :tabe <cfile><cr>

" vimcasts #26 http://vimcasts.org/episodes/bubbling-text/
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" Visually select the text that was last edited/pasted
nmap gV `[v`]

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>
nmap <leader>n :set number!<CR>
nmap <leader>w :set wrap!<CR>
nmap <leader>p :set paste!<CR>

" Toggles
nmap <F5> :set list! number!<CR>
nmap <F6> :set wrap!<CR>
nmap <F7> :NERDTreeToggle<CR>
nmap <F8> :TagbarToggle<CR>
nnoremap <space> za

" Syntastic
" :Error, :SyntasticToggleMode

" %%% status line %%%
set laststatus=1
set statusline=
"set statusline+=%7*\[%n]                                  "buffernr
"set statusline+=%1*\ %<%F\                                "File+path
"set statusline+=%2*\ %y\                                  "FileType
"set statusline+=%3*\ %{''.(&fenc!=''?&fenc:&enc).''}      "Encoding
"set statusline+=%3*\ %{(&bomb?\",BOM\":\"\")}\            "Encoding2
"set statusline+=%4*\ %{&ff}\                              "FileFormat (dos/unix..) 
"set statusline+=%5*\ %{&spelllang}\%{HighlightSearch()}\  "Spellanguage & Highlight on?
"set statusline+=%8*\ %=\ row:%l/%L\ (%03p%%)\             "Rownumber/total (%)
"set statusline+=%9*\ col:%03c\                            "Colnr
"set statusline+=%0*\ \ %m%r%w\ %P\ \                      "Modified? Readonly? Top/bot.
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}

function! HighlightSearch()
  if &hls
    return 'H'
  else
    return ''
  endif
endfunction


" %%% colors %%%
" cterm=reverse,underline,bold
set t_Co=256

" Normal
hi Normal               ctermbg=NONE    ctermfg=15
" Comment
hi Comment              ctermbg=NONE    ctermfg=240
" Number
hi LineNr               ctermbg=NONE    ctermfg=238
" Folds
hi Folded               ctermbg=233     ctermfg=242  cterm=NONE
hi FoldColumn           ctermbg=NONE    ctermfg=238  cterm=bold
" TabLine
hi TabLine              ctermbg=234    ctermfg=245    cterm=NONE
hi TabLineMod           ctermbg=234    ctermfg=99     cterm=NONE
hi TabLineSel           ctermbg=99     ctermfg=234    cterm=NONE
hi TabLineSelMod        ctermbg=99     ctermfg=232    cterm=bold
hi TabLineFill          ctermbg=NONE   ctermfg=245    cterm=NONE
" CursorLine
hi CursorLine           ctermbg=234    ctermfg=NONE   cterm=NONE
hi CursorColumn         ctermbg=234    ctermfg=NONE
hi CursorLineNr         ctermbg=234    ctermfg=99
" StatusLine
" when StatusLine == StatusLineNC fill characters (^) appear in active
hi StatusLine           ctermbg=233    ctermfg=240    cterm=NONE
hi StatusLineNC         ctermbg=233    ctermfg=236   cterm=NONE
" Search 3,11
hi IncSearch            ctermbg=11     ctermfg=0
hi Search               ctermbg=11     ctermfg=0
" NonText e.g. eol chars
hi NonText              ctermbg=NONE   ctermfg=238
" Split
hi VertSplit            ctermbg=233    ctermfg=238    cterm=NONE
" Error
hi Error                ctermbg=237    ctermfg=1      cterm=bold term=bold
hi ErrorMsg             ctermbg=NONE   ctermfg=1      cterm=NONE term=NONE
" Visual
hi Visual               ctermbg=236    ctermfg=NONE
hi VisualNOS            ctermbg=236    ctermfg=NONE
" Tab Completion
hi Pmenu                ctermbg=237    ctermfg=15
hi PmenuSel             ctermbg=7      ctermfg=1
" CtrlP
hi CtrlPMatch           ctermbg=11     ctermfg=0      cterm=reverse
" Signs
" for e.g. syntastic
hi SignColumn           ctermbg=237
hi SpellBad             ctermbg=1
" Parenthesis match
hi MatchParen           ctermbg=99     ctermfg=0 
" Diff
hi DiffAdd              ctermbg=28
hi DiffDelete           ctermbg=161
hi DiffChange           ctermbg=23
hi DiffText             ctermbg=130

" User colors
hi User1        ctermfg=253 ctermbg=238 cterm=NONE
hi User2        ctermfg=253 ctermbg=237 cterm=NONE
hi User3        ctermfg=253 ctermbg=237 cterm=NONE
hi User4        ctermfg=253 ctermbg=237 cterm=NONE
hi User5        ctermfg=253 ctermbg=236 cterm=NONE
hi User7        ctermfg=253 ctermbg=236 cterm=NONE
hi User8        ctermfg=253 ctermbg=236 cterm=NONE
hi User9        ctermfg=253 ctermbg=236 cterm=NONE
hi User0        ctermfg=253 ctermbg=125 cterm=NONE

" %%% Cursor %%%

if has ("autocmd")
  au InsertEnter * hi CursorLine ctermbg=NONE | hi CursorLineNr ctermbg=NONE
  au InsertLeave * hi CursorLine ctermbg=234  | hi CursorLineNr ctermbg=234
  "autocmd VimEnter,VimLeave * silent !tmux set status
endif

" fold until the next empty line
function! FirstSecondFolds()
  if v:lnum == 1
    return "0"
  endif
  let thisline = getline(v:lnum)
  let prevline = getline(v:lnum-1)
  let nextline = getline(v:lnum+1)
  if (match(thisline, '^/\* ====') >= 0 && match(thisline, '.') >= 0)
    return ">1"
  elseif (match(thisline, '^$') >= 0 && match(nextline, '^/\* ====') >= 0)
    return "0"
  elseif (match(thisline, '^/\* ====') >= 0)
    return "0"
  elseif (match(thisline, '^/\* ----') >= 0)
    return ">2"
  else
    return "="
  endif
endfunction

" fold until the next empty line
function! NotizenFolds()
  if v:lnum == 1
    return ">1"
  endif
  let thisline = getline(v:lnum)
  let prevline = getline(v:lnum-1)
  if (match(prevline, '^$') >= 0 && match(thisline, '.') >= 0)
    return ">1"
"  elseif (match(thisline, '^$') >= 0)
"    return "0"
  else
    return "="
  endif
endfunction

" set the folded line text
"function! MarkdownFoldText()
"  return getline(v:foldstart).getline(v:foldstart+1)
"endfunction

function! FirstSecondFoldText()
  let thisline = getline(v:foldstart)
  let nextline = getline(v:foldstart+1)
  let nextlinestripped = substitute(nextline, '^\s*\(.\{-}\)\s*$', '\1', '')
  if (match(thisline, '^/\* ====') >= 0)
    let fill = 80 - 22 - strlen(nextlinestripped)
    return '/* ==========| '.nextlinestripped.' |'.repeat('=',fill).'== */'
  elseif (match(thisline, '^/\* ----') >= 0)
    return thisline
  endif
endfunction

function! SimpleFoldText()
  return getline(v:foldstart)
endfunction

function! MarkdownFoldText()
  let foldsize = (v:foldend-v:foldstart)
  let charcount = 0
  for i in range(v:foldstart, v:foldend)
    let charcount += strlen(getline(i))
  endfor
  " Linux Libertine 12pt --> ~93chars, ~34lines
  " volle Zeilen (ohne Absätze, Restzeilen) ohne Überschrift
  " bei ca 4 Absätze / Seite --> -2lines
  " bei ca 2 Überschriften (je 2 Zeilen) / Seite --> -3lines
  " TODO h1 zu ganzen Seiten aufrunden
  let lines = charcount / 93.0
  let pagecount = lines / 29.0
  let pagecount = pagecount * 4
  let pagecount = floor(pagecount)
  let pagecount = pagecount / 4.0
  let pagecount += 0.25
  "return '--- '.getline(v:foldstart).' ('.foldsize.' lines)'
  let spaces = 60 - strwidth(getline(v:foldstart))
  return strpart(getline(v:foldstart), 0, 60).repeat(' ',spaces).' ('.printf("%5.2f", pagecount).' Seiten)'
endfunction

set foldtext=SimpleFoldText()

if has("autocmd")
  " Syntax of these languages is fussy over tabs Vs spaces
  autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

  " Treat .rss files as XML
  autocmd BufNewFile,BufRead *.rss setfiletype xml
  autocmd BufNewFile,BufRead *.inc setfiletype php
  autocmd BufNewFile,BufRead *.install setfiletype php
  autocmd BufNewFile,BufRead *.module setfiletype php
  autocmd BufNewFile,BufRead *.less setfiletype css
  autocmd BufNewFile,BufRead *.scss setfiletype css
  autocmd BufNewFile,BufRead *.sass setfiletype css

  " Customisations based on house-style (arbitrary)
  autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType php setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab

  au BufNewFile,BufRead *.md set foldtext=MarkdownFoldText()

  au BufNewFile,BufRead *.notizen.md setlocal foldmethod=expr
  au BufNewFile,BufRead *.notizen.md setlocal foldexpr=NotizenFolds()
  au BufNewFile,BufRead *.notizen.md setlocal foldtext=MarkdownFoldText()
  au BufNewFile,BufRead *.notizen.md setlocal nocursorline

  au BufNewFile,BufRead *.roh.md syn region  zettelNotiz   start="\[" end="\]" oneline conceal
  au BufNewFile,BufRead *.roh.md hi zettelNotiz ctermbg=Yellow ctermfg=Black
  au BufNewFile,BufRead *.roh.md setlocal tw=0 wrap nolist linebreak wrapmargin=0
  au BufNewFile,BufRead *.roh.md nnoremap <buffer> <leader>p :!pandoc -f markdown -t latex -o %:p:h/draft.pdf --latex-engine=xelatex --template=%:p:h/template.tex --toc -V documentclass=scrartcl -V lang=ngerman -V fontsize=12pt -H %:p:h/include-header.tex % && zathura %:p:h/draft.pdf<cr>
endif

" -----------> Tabline <-------------

if exists("+guioptions")
        set go-=a go-=e go+=tc
        " remove a no autoselect to * register
        " remove e always use text-style tabs
        " add    t include tearoff menu items if possible
        " add    c avoid popup dialogs for small choices
endif

" define our text-style tabline
" this is adapted (with some enhancements) from the example
" at :help setting-tabline
if exists("+showtabline")
     function! MyTabLine()
         let s = ''
         let t = tabpagenr()
         let i = 1
         while i <= tabpagenr('$')
             let buflist = tabpagebuflist(i)
             let winnr = tabpagewinnr(i)
             let s .= '%' . i . 'T'
             "let s .= (i == t ? '%1*' : '%2*')
             "let s .= ' '
             "let s .= i . ':'
             "let s .= winnr . '/' . tabpagewinnr(i,'$')
             "let s .= ' %*'
             if getbufvar(buflist[winnr - 1], "&mod")
               let s .= (i == t ? '%#TabLineSelMod#' : '%#TabLineMod#')
               let s .= ' '.i.'*'
             else
               let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
               let s .= ' '.i.' '
             endif
             let file = bufname(buflist[winnr - 1])
             " see :h filename-modifiers
             let file = fnamemodify(file, ':p:t')
             if file == ''
                 let file = 'NoNa'
             endif
             let s .= file
             "let s .= (i == t ? '%m' : '')
             let s .= ' '
             let i = i + 1
         endwhile
         let s .= '%T%#TabLineFill#%='
         " let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
         return s
     endfunction
     set stal=1 "2
     set tabline=%!MyTabLine()
"   map     <F10>    :tabnext<CR>
"   map!    <F10>    <C-O>:tabnext<CR>
"   map     <S-F10>  :tabprev<CR>
"   map!    <S-F10>  <C-O>:tabprev<CR>
endif 

"autocmd VimEnter,VimLeave * silent !tmux set status

" LaTeX-Suite
" http://vim-latex.sourceforge.net/documentation/latex-suite/

" Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
set iskeyword+=:

" pause LaTeX-Suite Macros
" also on b: level, or as setting
let g:Imap_FreezeImap = 0

" Smart Key Mappings
" Outline Window bei Completion
" Completion von ref, cite
" quickfix window bei errors
" Compilation

" set an undo point before deleting with C-w or C-u
" then undo will work, no input is lost
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>
