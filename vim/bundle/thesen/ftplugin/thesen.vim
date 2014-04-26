
setlocal foldexpr=thesen#MarkdownLevel()
setlocal foldmethod=expr
setlocal foldlevelstart=2
setlocal nofoldenable

setlocal noexpandtab
setlocal ts=4
setlocal sw=4

setlocal nowrap

set statusline+=%{thesen#SyntaxItem()}
set laststatus=2

function! thesen#SyntaxItem()
  return synIDattr(synID(line("."),col("."),1),"name")
endfunction

" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
setlocal iskeyword+=:
setlocal iskeyword+=-

