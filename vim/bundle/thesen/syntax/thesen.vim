if exists("b:current_syntax")
  finish
endif

syntax case match
syntax spell toplevel
" TODO: optimize
syn sync linebreaks=1
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set embedded LaTex (pandoc extension) highlighting
" Unset current_syntax so the 2nd include will work
"unlet b:current_syntax
syn include @LATEX syntax/tex.vim
" Single Tex command
syn match pandocLatex /\\\w\S/ contains=@LATEX
" Math Tex
syn match pandocLatex /\$.\{-}\S\$/ contains=@LATEX

if !exists("g:pandoc_no_spans") || !g:pandoc_no_spans
syn match pandocPara /\(^\(=\|[-:#%>]\|\[.\{-}\]:\)\@!\(\S.*\)\n\)\(\(^[=-].*\n\)\|\(^[:].*\n\)\)\@!/ contains=pandocEmphasis,pandocStrong,pandocNoFormatted,pandocSuperscript,pandocSubscript,pandocStrikeout,pandocLinkArea,pandocFootnoteID,@Spell,pandocPCite,pandocLatex,zettelNotiz
endif

syn match pandocTitleBlock /\%^\(%.*\n\)\{1,3}$/ skipnl

"""""""""""""""""""""""""""""""""""""""""""""
" Header:
"
syn match pandocAtxHeader /^\s*#\{1,6}.*\n/ contains=pandocEmphasis
syn match pandocSetexHeader /^.\+\n[=]\+$/
syn match pandocSetexHeader /^.\+\n[-]\+$/

"""""""""""""""""""""""""""""""""""""""""""""
" Blockquotes:
"
syn match pandocBlockQuote /^>.*\n\(.*\n\@<!\n\)*/ skipnl

""""""""""""""""""""""""""""""""""""""""""""""
" Code Blocks:
"
syn region pandocCodeBlock   start=/\(\(\d\|\a\|*\).*\n\)\@<!\(^\(\s\{4,}\|\t\+\)\).*\n/ end=/.\(\n^\s*\n\)\@=/

" Delimited Code Blocks:
syn region pandocDelimitedCodeBlock start=/^\z(\~\{3,}\~*\)\( {.\+}\)*/ end=/\z1\~*/ skipnl contains=pandocDelimitedCodeBlockLanguage
syn region pandocDelimitedCodeBlock start=/^\z(\`\{3,}\`*\)\( {.\+}\)*/ end=/\z1\`*/ skipnl contains=pandocDelimitedCodeBlockLanguage
syn region pandocDelimitedCodeBlock start=/^\z(\~\{3,}\~*\)\( {.\+}\)*/ end=/\z1\~*/ skipnl contains=pandocDelimitedCodeBlockLanguage
syn match pandocDelimitedCodeBlockLanguage /{.\+}/ contained containedin=pandocDelimitedCodeBlock
syn match pandocCodePre /<pre>.\{-}<\/pre>/ skipnl
syn match pandocCodePre /<code>.\{-}<\/code>/ skipnl

"""""""""""""""""""""""""""""""""""""""""""""""
" Links:
syn region pandocLinkArea start=/\[.\{-}\]\@<=\(:\|(\|\[\)/ skip=/\(\]\(\[\|(\)\|\]: \)/ end=/\(\(\]\|)\)\|\(^\s*\n\|\%^\)\)/ contains=pandocLinkText,pandocLinkURL,pandocLinkTitle,pandocAutomaticLink,pandocPCite containedin=theseHeading1,theseHeading2,theseHeading3,theseHeading4
syn match pandocLinkText /\[\@<=.\{-}\]\@=/ containedin=pandocLinkArea contained contains=@Spell
" TODO: adapt gruber's regex to match URLs; the current regex is quite limited
syn match pandocLinkURL /https\{0,1}:.\{-}\()\|\s\|\n\)\@=/ containedin=pandocLinkArea contained
syn match pandocAutomaticLink /<\(https\{0,1}.\{-}\|.\{-}@.\{-}\..\{-}\)>/
syn match pandocLinkTextRef /\(\]\(\[\|(\)\)\@<=.\{-}\(\]\|)\)\@=/ containedin=pandocLinkText contained
syn match pandocLinkTitle /".\{-}"/ contained containedin=pandocLinkArea contains=@Spell

"""""""""""""""""""""""""""""""""""""""""""""""
" Definitions:
"
syn match pandocDefinitionBlock /^.*\n\(^\s*\n\)*\s\{0,2}[:~]\(\s\{1,3}\|\t\).*\n\(\(^\s\{4,}\|^\t\).*\n\)*/ skipnl contains=pandocDefinitionBlockTerm,pandocDefinitionBlockMark,pandocLinkArea,pandocEmphasis,pandocStrong,pandocNoFormatted,pandocStrikeout,pandocSubscript,pandocSuperscript,@Spell
syn match pandocDefinitionBlockTerm /^.*\n\(^\s*\n\)*\(\s*[:~]\)\@=/ contained containedin=pandocDefinitionBlock contains=pandocNoFormatted,pandocEmphasis
syn match pandocDefinitionBlockMark /^\s*[:~]/ contained containedin=pandocDefinitionBlock
""""""""""""""""""""""""""""""""""""""""""""""
" Footnotes:
"
syn match pandocFootnoteID /\[\^[^\]]\+\]/ nextgroup=pandocFootnoteDef
"   Inline footnotes
syn region pandocFootnoteDef matchgroup=pandocFootnoteID start=/\^\[/ end=/\]/ contains=pandocLinkArea,pandocLatex,pandocPCite,@Spell skipnl
syn region pandocFootnoteBlock start=/\[\^.\{-}\]:\s*\n*/ end=/^\n^\s\@!/ contains=pandocLinkArea,pandocLatex,pandocPCite,pandocStrong,pandocEmphasis,pandocNoFormatted,pandocSuperscript,pandocSubscript,pandocStrikeout,@Spell skipnl
syn match pandocFootnoteID /\[\^.\{-}\]/ contained containedin=pandocFootnoteBlock

""""""""""""""""""""""""""""""""""""""""""""""
" Citations:
" parenthetical citations
syn match pandocPCite /\[-\{0,1}@.\{-}\]/ contains=pandocEmphasis,pandocStrong,pandocLatex,@Spell
" syn match pandocPCite /\[\w.\{-}\s-\?.\{-}\]/ contains=pandocEmphasis,pandocStrong
" in-text citations without location
syn match pandocPCite /@\%[\w\-]*/
" in-text citations with location
syn match pandocPCite /@\w*\s\[.\{-}\]/

""""""""""""""""""""""""""""""""""""""""""""""
" Tables: TODO
"
"""""""""""""""""""""""""""""""""""""""""""""""
"if !exists("g:pandoc_no_spans") || !g:pandoc_no_spans
" Text Styles:
" TODO: make the matches allow for items spanning several lines

" Strong:
"
" Using underscores
syn match pandocStrong /\(__\)\([^_ ]\|[^_]\( [^_]\)\+\)\+\1/ contained contains=@Spell skipnl
" Using Asterisks
syn match pandocStrong /\(\*\*\)\([^\* ]\|[^\*]\( [^\*]\)\+\)\+\1/ contained contains=@Spell skipnl
"""""""""""""""""""""""""""""""""""""""
" Emphasis:
"
"Using underscores
syn match pandocEmphasis /\(_\)\([^_ ]\|[^_]\( [^_]\)\+\)\+\1/ contained contains=@Spell skipnl
"Using Asterisks
syn match pandocEmphasis /\(\*\)\([^\* ]\|[^\*]\( [^\*]\)\+\)\+\1/ contained contains=@Spell skipnl
"""""""""""""""""""""""""""""""""""""""
" Inline Code:

" Using single back ticks
syn region pandocNoFormatted start=/`/ end=/`\|^\s*$/ contained
" Using double back ticks
syn region pandocNoFormatted start=/``[^`]*/ end=/``\|^\s*$/ contained

"endif

" Subscripts:
syn match pandocSubscript /\~\([^\~\\ ]\|\(\\ \)\)\+\~/ contains=@Spell

"""""""""""""""""""""""""""""""""""""""
" Superscript:
syn match pandocSuperscript /\^\([^\^\\ ]\|\(\\ \)\)\+\^/ contains=@Spell

"""""""""""""""""""""""""""""""""""""""
" Strikeout:
syn match pandocStrikeout /\~\~[^\~ ]\([^\~]\|\~ \)*\~\~/ contains=@Spell

"""""""""""""""""""""""""""""""""""""""""""""""
" List Items:
"
" TODO: support roman numerals
syn match pandocListItem /^\s*\([*+-]\|\((*\d\+[.)]\+\)\|\((*\l[.)]\+\)\)\s\+/he=e-1 nextgroup=pandocPara
syn match pandocListItem /^\s*(*\u[.)]\+\s\{2,}/he=e-1 nextgroup=pandocPara
syn match pandocListItem /^\s*(*[#][.)]\+\s\{1,}/he=e-1 nextgroup=pandocPara
syn match pandocListItem /^\s*(*@.\{-}[.)]\+\s\{1,}/he=e-1 nextgroup=pandocPara

"""""""""""""""""""""""""""""""""""""""""""""""
" Horizontal Rules:
"
" 3 or more * on a line
syn match pandocHRule /\s\{0,3}\(-\s*\)\{3,}\n/
" 3 or more - on a line
syn match pandocHRule /\s\{0,3}\(\*\s*\)\{3,}\n/

"""""""""""""""""""""""""""""""""""""""""""""""
syn match pandocNewLine /\(  \|\\\)$/

"""""""""""""""""""""""""""""""""""""""""""""""
hi link pandocTitleBlock Directory
hi link pandocAtxHeader Title
hi link pandocSetexHeader Title

hi link pandocBlockQuote Comment
hi link pandocCodeBlock String
hi link pandocDelimitedCodeBlock String
hi link pandocDelimitedCodeBlockLanguage Comment
hi link pandocCodePre String
hi link pandocListItem Operator

hi link pandocLinkArea		Type
hi link pandocLinkText		Type
hi link pandocLinkURL	Underlined
hi link pandocLinkTextRef Underlined
hi link pandocLinkTitle Identifier
hi link pandocAutomaticLink Underlined

hi link pandocDefinitionBlockTerm Identifier
hi link pandocDefinitionBlockMark Operator

hi link pandocFootnoteID		Type
hi link pandocFootnoteDef		Comment
hi link pandocFootnoteBlock	Comment

hi link pandocPCite Label

hi link pandocHRule		Underlined

hi pandocEmphasis gui=italic cterm=italic
hi pandocStrong gui=bold cterm=bold
hi link pandocNoFormatted String
hi link pandocSubscript Special
hi link pandocSuperscript Special
hi link pandocStrikeout Special

hi link pandocNewLine Error

syn region  zettelNotiz   start="\[\[" end="\]\]" conceal
hi zettelNotiz ctermbg=238 ctermfg=226

syn match theseKeyword_THESE /\t\{1,\}\zsTHESE/  containedin=theseHeading1,theseHeading2,theseHeading3,theseHeading4,theseHeading5,theseHeading6
syn match theseKeyword_ARGUMENT /\t\{1,\}\zsARGUMENT/  containedin=theseHeading1,theseHeading2,theseHeading3,theseHeading4,theseHeading5,theseHeading6
syn match theseKeyword_FRAGE /\t\{1,\}\zsFRAGE/  containedin=theseHeading1,theseHeading2,theseHeading3,theseHeading4,theseHeading5,theseHeading6
syn match theseKeyword_MODAL /\t\{1,\}\zsMODAL/  containedin=theseHeading1,theseHeading2,theseHeading3,theseHeading4,theseHeading5,theseHeading6
syn match theseKeyword_STUETZE /\t\{1,\}\zsSTUETZE/  containedin=theseHeading1,theseHeading2,theseHeading3,theseHeading4,theseHeading5,theseHeading6
syn match theseKeyword_ANALYSE /\t\{1,\}\zsANALYSE/  containedin=theseHeading1,theseHeading2,theseHeading3,theseHeading4,theseHeading5,theseHeading6
hi theseKeyword_THESE    ctermfg=black ctermbg=cyan  cterm=bold
hi theseKeyword_ARGUMENT ctermfg=green  cterm=bold
hi theseKeyword_FRAGE    ctermfg=yellow cterm=bold
hi theseKeyword_MODAL    ctermfg=magenta  cterm=bold
hi theseKeyword_STUETZE  ctermfg=blue  cterm=bold
hi theseKeyword_ANALYSE  ctermfg=blue  cterm=bold

syn match theseHeading1 /^\t\{1\}.*/ contains=pandocLinkArea
syn match theseHeading2 /^\t\{2\}.*/ contains=pandocLinkArea
syn match theseHeading3 /^\t\{3\}.*/ contains=pandocLinkArea
syn match theseHeading4 /^\t\{4\}.*/ contains=pandocLinkArea
syn match theseHeading5 /^\t\{5\}.*/ contains=pandocLinkArea
syn match theseHeading6 /^\t\{6\}.*/ contains=pandocLinkArea
hi theseHeading1 ctermfg=white  cterm=bold
hi theseHeading2 ctermfg=DarkCyan
hi theseHeading3 ctermfg=DarkYellow
hi theseHeading4 ctermfg=white
hi theseHeading5 ctermfg=white
hi theseHeading6 ctermfg=white

syn match theseDescription /^\t\{0,\} \{1,\}.*/
hi theseDescription ctermfg=gray

let b:current_syntax = "zettel"
