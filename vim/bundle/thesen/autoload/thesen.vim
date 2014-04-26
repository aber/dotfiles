"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folding:
"
" Taken from
" http://stackoverflow.com/questions/3828606/vim-markdown-folding/4677454#4677454
"
function! thesen#MarkdownLevel()
  if getline(v:lnum) =~ '^#\+ .*$'
    return ">1"
  endif
  if getline(v:lnum) =~ '^[^-=].\+$' && getline(v:lnum+1) =~ '^=\+$'
    return ">1"
  endif
  if getline(v:lnum) =~ '^[^-=].\+$' && getline(v:lnum+1) =~ '^-\+$'
    return ">2"
  endif
  return "="
endfunction
