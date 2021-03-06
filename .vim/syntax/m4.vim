""
"" m4.vim for vim-syntax in /home/lrde/lrde-2008/sigoure
""
"" Made by SIGOURE Benoit
"" Login   <sigoure@epita.fr>
""
"" Started on  Sun Mar 12 15:20:30 2006 SIGOURE Benoit
"" Last update Sat Aug  5 11:12:20 2006 SIGOURE Benoit
""

" Vim syntax file
" Language:		M4
" Maintainer:	Claudio Fleiner
" URL:			http://www.fleiner.com/vim/syntax/m4.vim
" Last Change:	2001 Apr 26

" This file will highlight user function calls if they use only
" capital letters and have at least one argument (i.e. the '('
" must be there). Let me know if this is a problem.

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
  finish
endif
" we define it here so that included files can test for it
  let main_syntax='m4'
endif

" define the m4 syntax
syn match  m4Variable contained "\$\+[A-Za-z_]\w*"
syn match  m4Variable contained "\$\+[0-9]\+"
syn match  m4Special  contained "$[@*#]"
syn match  m4Comment  "dnl\>.*" contains=SpellErrors
syn match  m4Constants "\(\<m4_\)\=__file__"
syn match  m4Constants "\(\<m4_\)\=__line__"
syn keyword m4Constants divnum sysval m4_divnum m4_sysval
syn region m4Paren    matchgroup=m4Delimiter start="(" end=")" contained contains=@m4Top
syn region m4Command  matchgroup=m4Type  start="\<\(m4_\)\=\(define\|defn\|pushdef\)(" end=")" contains=@m4Top
syn region m4Command  matchgroup=m4Preproc   start="\<\(m4_\)\=\(include\|sinclude\)("he=e-1 end=")" contains=@m4Top
syn region m4Command  matchgroup=m4Statement start="\<\(m4_\)\=\(syscmd\|esyscmd\|ifdef\|ifelse\|ifval\|indir\|builtin\|shift\|errprint\|m4exit\|changecom\|changequote\|changeword\|m4wrap\|debugfile\|divert\|undivert\|pattern_allow\|pattern_forbid\|foreach\)("he=e-1 end=")" contains=@m4Top
syn region m4Command  matchgroup=m4builtin start="\<\(m4_\)\=\(len\|index\|regexp\|substr\|translit\|patsubst\|format\|incr\|decr\|eval\|maketemp\)("he=e-1 end=")" contains=@m4Top
syn keyword m4Statement divert undivert
syn region m4Command  matchgroup=m4Type      start="\<\(m4_\)\=\(undefine\|popdef\)("he=e-1 end=")" contains=@m4Top
"syn region m4String   start=+'+ end=+'+ contained contains=@m4Top,@m4StringContents,SpellErrors
"syn region m4String   start=+"+ skip=+\\"+ end=+"+ contained contains=@m4Top,@m4StringContents,SpellErrors
"syn region m4String   start=+`+ skip=+\\`+ end=+`+ contained contains=@m4Top,@m4StringContents,SpellErrors
syn cluster m4Top     contains=m4Comment,m4Constants,m4Special,m4Variable,m4String,m4Paren,m4Command,m4Statement,m4Function,m4Quoted,m4QuoteDelim,m4ShellCond

syn cluster	m4CommentGroup	contains=m4Todo,@Spell
syn keyword	m4Todo			TODO FIXME XXX contained
syn match	m4Comment		"#.*$" contains=@m4CommentGroup
syn region	m4Function		matchgroup=m4Type start="\<[_A-Z][_A-Z0-9]*("he=e-1 end=")" contains=@m4Top transparent
syn match   m4QuoteDelim	"[()\[\];,]"
syn region  m4Quoted		start=+\[+ end=+]+ contains=@m4Top,m4AutoConfCV
syn match	m4AutoConfCV	"\w\+_cv_\w\+" contained
syn keyword	m4ShellCond		if then elif else fi test for in do done case esac echo while until continue break

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_my_m4_syn_inits")
  if version < 508
    let did_my_m4_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  HiLink m4Delimiter Delimiter
  HiLink m4Comment   Comment
  HiLink m4Command   Special
  HiLink m4Function  Ignore
  HiLink m4Keyword   Keyword
  HiLink m4Special   Special
  HiLink m4String    String
  HiLink m4Statement Statement
  HiLink m4Preproc   PreProc
  HiLink m4Type      Type
  HiLink m4Special   Special
  HiLink m4Variable  Constant
  HiLink m4Constants Constant
  HiLink m4Builtin   Statement
"  HiLink m4Quoted    Constant
  HiLink m4QuoteDelim Delimiter
  HiLink m4AutoConfCV Macro 
  HiLink m4ShellCond  Conditional
  HiLink m4Todo       Todo
  delcommand HiLink
endif

let b:current_syntax = "m4"

if main_syntax == 'm4'
  unlet main_syntax
endif

" vim: ts=4
