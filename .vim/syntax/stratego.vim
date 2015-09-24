" Vim syntax file
" Language:	Stratego Syntax
" Maintainer:	Shishir Ramam <sramam +at+ yahoo.com>
" Last Change:  2004 April 15
" Filenames:	*.str *.r
" URL:		

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
	if b:current_syntax != "stratego"
	    syntax clear
		unlet b:current_syntax
	else 
		finish
	endif
endif

setlocal iskeyword=a-z,A-Z,48-57,_,-,=,128-167,224-235

" Need to clean up and accurately identify strategies from agruments that
" might not be strategies. 
"
" syntax region  strTag start="^[\ \t]*[a-zA-Z\'\.\-\_][a-zA-Z0-9\'\.\-\_]*" end="\=" skipwhite
"syntax region  strStrategyName start="^[\ \t]*[a-zA-Z\'\.\-\_][a-zA-Z0-9\'\.\-\_]*" skip="[^=$]" end="="
syntax keyword strVisibility	exports hiddens definition imports module external
syntax keyword strBlocks	constructors strategies rules signature 
syntax keyword strConditional	where if then else switch case otherwise
syntax match   strConditional	+?+
syntax keyword strKeywords	end in let not one overlays override prim script some sorts stratego test thread
syntax match   strKeywords      "#" "@"
syntax match   strFail		"\<\(fail\|false\)\>"
syntax match   strId		"\<\(id\|true\)\>"
syntax keyword strWildcard	_
syntax keyword strTraversals    all try repeat map filter Tl topdown bottomup alltd downup innermost oncetd oncebu
syntax keyword strCommon	debug say main
syntax keyword strRec		rec

syntax match   strSpecialCall	"\<\(bagof\|once\)-\(\w\|-\)\+"

syntax keyword strProduction	->
syntax match strProduction	"=>\?"

" FIXME: the following rules match too many things. Also /r1\r2/ is buggy.
"syntax region  strForkFix 	start="/" end="\\\*\="
" FIXME: the follwing region introduces a bug with anonymous lambda
" productions: / strategy /
"syntax region  strForkFix	start="\\" end="/\*\="

syntax match   strScopedRuleList "\<\(\w.\w\|\w\|-\| \|,\)\+:" contained
syntax region  strScopedDR	start="{|" end="|}" contains=strScopedRuleList,@strAll

syntax match   strCompositions	"<+\|+>"

syntax keyword strTodo		contained TODO FIXME XXX NOTE[S]
" strCommentGroup allows adding matches for special things in comments
syntax cluster	strCommentGroup	contains=strTodo

syntax region strCmt1		start="\\literate" end="\\begin{code}" 
syntax region strCmt2		start="\\end{code}" end="\\begin{code}" 
syntax region strCmtLine	start="//" skip="\\$" end="$" contains=@strCommentGroup,@Spell
syntax region strCmtBlock	start="/\*" skip="\\$" end="\*/" keepend contains=@strCommentGroup,@Spell

syntax region strString		start=+L\="+ skip=+\\\\\|\\"+ end=+"+ contains=@Spell
syntax match strApply		"<\(\w\|-\)\+>"
syntax cluster strAll		contains=strVisibility,strBlocks,strConditional,strKeywords,strFail,strId,strWildcard,strTraversals,strRec,strSpecialCall,strProduction,strForkFix,strScopedDR,strCompositions,strCommentGroup,strCmtBlock,strCmtLine,strString,strApply

"syntax match strStrategyName /[a-zA-Z\'\.\-\_][a-zA-Z0-9\'\.\-\_]*/ contains=ALLBUT,strVisibility,strBlocks,strConditional,strKeywords

syn sync fromstart

if !exists("did_r_syn_inits")
   let did_r_syn_inits = 1

   hi link strVisibility	Type
   hi link strBlocks 		UnderLined
   hi link strKeywords		Keyword
   hi link strConditional	Conditional
   "hi link strTag		Type
   hi link strCmt1		Comment
   hi link strCmt2		Comment
   hi link strCmtLine		Comment
   hi link strCmtBlock		Comment
   "hi link strStrategyName	Special
   hi link strProduction	PreProc
   hi link strTodo		Todo
   hi link strCompositions	Operator
   hi link strFail		Special
   hi link strId		Typedef
   hi link strWildcard		Identifier
   hi link strForkFix		PreProc
   hi link strTraversals	Operator
   hi link strRec		Typedef
   hi link strSpecialCall	Special
   hi link strString		String
   hi link strScopedRuleList	StorageClass
   hi link strApply		Statement
   hi link strCommon		Typedef
endif

let b:current_syntax = "stratego"

