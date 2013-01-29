"
" -------------> URLs <--------------------
" http://vim.wikia.com/wiki/Xterm256_color_names_for_console_Vim
" http://vim.wikia.com/wiki/256_colors_in_vim
" http://vim.wikia.com/wiki/Configuring_the_cursor 
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
"
" --------------------------------------------

" %%% leader %%%
let mapleader = ","
let g:mapleader = ","

" %%% text input %%%

set textwidth=0
set wrap

" %%% key mappings %%%

" open the file under the cursor in new tab
map <leader>gf :tabe <cfile><cr>

" %%% status line %%%
set laststatus=1
set statusline=

" %%% colors %%%
" cterm=reverse,underline,bold
set t_Co=256

" Number
hi LineNr               ctermbg=NONE    ctermfg=238
" Folds
hi Folded               ctermbg=233     ctermfg=242  cterm=NONE
hi FoldColumn           ctermbg=NONE    ctermfg=238  cterm=bold
set fillchars+=fold:\ 
" TabLine
hi TabLine              ctermbg=234    ctermfg=245    cterm=NONE
hi TabLineSel           ctermbg=99     ctermfg=237    cterm=NONE
hi TabLineFill          ctermbg=NONE   ctermfg=245    cterm=NONE
" CursorLine
hi CursorLine           ctermbg=234    ctermfg=NONE   cterm=NONE
hi CursorColumn         ctermbg=234    ctermfg=NONE
hi CursorLineNr         ctermbg=234    ctermfg=99
" StatusLine
hi StatusLine           ctermbg=233    ctermfg=240    cterm=NONE
hi StatusLineNC         ctermbg=233    ctermfg=240    cterm=NONE
" Search 3,11
hi IncSearch            ctermbg=11     ctermfg=0
hi Search               ctermbg=11     ctermfg=0
" hi NoneText
" Split
set fillchars+=vert:\ 
hi VertSplit            ctermbg=233    ctermfg=238    cterm=NONE
" Error
hi Error                ctermbg=NONE   ctermfg=1      cterm=bold term=bold
hi ErrorMsg             ctermbg=NONE   ctermfg=1      cterm=NONE term=NONE
" Visual
hi Visual               ctermbg=237    ctermfg=NONE
hi VisualNOS            ctermbg=237    ctermfg=NONE
" Tab Completion
hi Pmenu                ctermbg=7      ctermfg=8
hi PmenuSel             ctermbg=5      ctermfg=15

" %%% Cursor %%%

if has ("autocmd")
  au InsertEnter * set nocul
  au InsertLeave * set cul
  "autocmd VimEnter,VimLeave * silent !tmux set status
endif

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
function! MarkdownFoldText()
  return getline(v:foldstart).getline(v:foldstart+1)
endfunction

function! SimpleFoldText()
  return getline(v:foldstart)
endfunction

function! MarkdownFoldText()
  let foldsize = (v:foldend-v:foldstart)
  return '--- '.getline(v:foldstart).' ('.foldsize.' lines)'
endfunction

set foldtext=SimpleFoldText()

if has("autocmd")
  au BufNewFile,BufRead *.md set foldtext=MarkdownFoldText()

  au BufNewFile,BufRead *.notizen.md setlocal foldmethod=expr
  au BufNewFile,BufRead *.notizen.md setlocal foldexpr=NotizenFolds()
  au BufNewFile,BufRead *.notizen.md setlocal foldtext=MarkdownFoldText()
  au BufNewFile,BufRead *.notizen.md setlocal nocursorline

  au BufNewFile,BufRead *.roh.md syn region  zettelNotiz   start="\[" end="\]" oneline
  au BufNewFile,BufRead *.roh.md hi zettelNotiz ctermbg=Yellow ctermfg=Black
  au BufNewFile,BufRead *.roh.md set tw=0 wrap
  au BufNewFile,BufRead *.roh.md nmap ,p :!pandoc -f markdown -t latex -o %:p:h/draft.pdf --toc --template=%:p:h/template.tex -V documentclass=scrartcl -V font-size=12pt %  && zathura %:p:h/draft.pdf<cr>
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
             let s .= (i == t ? '%1*' : '%2*')
             "let s .= ' '
             "let s .= i . ':'
             "let s .= winnr . '/' . tabpagewinnr(i,'$')
             "let s .= ' %*'
             let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
             let file = bufname(buflist[winnr - 1])
             " see :h filename-modifiers
             let file = fnamemodify(file, ':p:t')
             if file == ''
                 let file = '[No Name]'
             endif
             let s .= ' '.i.':'
             let s .= file
             let s .= (i == t ? '%m' : '')
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

