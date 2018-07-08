" Vim syntax file
" Language:	Mortran3
" Last Change:	2018 July 8
" Maintainer:	Ljubomir Kurij (kurijlj AT gmail.com)

if exists("b:current_syntax")
  finish
endif


" A bunch of useful Mortran keywords
syn keyword	mortranCallStatement	call
syn keyword	mortranStatement	REPLACE WITH OUTPUT CALL STOP END SUBROUTINE RETURN
syn keyword	mortranType		COMIN
syn match       mortranImplicitNone     "$IMPLICIT-NONE"
syn match       mortranIntegerType      "$INTEGER"
syn match       mortranRealType         "$REAL"
syn match       mortranStringType       "$S"
syn keyword	mortranType		CHARACTER
syn keyword	mortranConditional	IF ELSE ELSEIF
syn keyword	mortranRepeat		WHILE FOR DO

syn match mortranComment    "\".*\""
syn match mortranLabel      ":.*:"
syn match mortranString     "'.\{-}'"
"syn region cBlock           start="{" end="}" contains=ALLBUT,mortranComment,mortranLabel,mortranString fold
"syn region cBlock           start="\[" end="\]" fold transparent

"Numbers of various sorts
" Integers
syn match mortranNumber	display "\<\d\+\(_\a\w*\)\=\>"
" floating point number, without a decimal point
syn match mortranFloatNoDec	display	"\<\d\+[deq][-+]\=\d\+\(_\a\w*\)\=\>"
" floating point number, starting with a decimal point
syn match mortranFloatIniDec	display	"\.\d\+\([deq][-+]\=\d\+\)\=\(_\a\w*\)\=\>"
" floating point number, no digits after decimal
syn match mortranFloatEndDec	display	"\<\d\+\.\([deq][-+]\=\d\+\)\=\(_\a\w*\)\=\>"
" floating point number, D or Q exponents
syn match mortranFloatDExp	display	"\<\d\+\.\d\+\([dq][-+]\=\d\+\)\=\(_\a\w*\)\=\>"
" floating point number
syn match mortranFloat	display	"\<\d\+\.\d\+\(e[-+]\=\d\+\)\=\(_\a\w*\)\=\>"
" Numbers in formats
syn match mortranFormatSpec	display	"\<F\d\+\.\d\+\>"
syn match mortranFormatSpec	display	"\<T\d\+\>"
syn match mortranFormatSpec	display	"\<I\d\+\>"

hi def link mortranComment	    Comment
hi def link mortranLabel	    Todo
hi def link mortranString           String
hi def link mortranNumber           Number
hi def link mortranFloat            Float
hi def link mortranFloatNoDec       mortranFloat
hi def link mortranFloatIniDec      mortranFloat
hi def link mortranFloatEndDec      mortranFloat
hi def link mortranFloatDExp        mortranFloat
hi def link mortranFormatSpec       Identifier
hi def link mortranKeyword	    Keyword
hi def link mortranCallStatement    mortranKeyword
hi def link mortranStatement	    mortranKeyword
hi def link mortranType		    Type
hi def link mortranImplicitNone     mortranType
hi def link mortranIntegerType      mortranType
hi def link mortranRealType         mortranType
hi def link mortranStringType       mortranType
hi def link mortranConditional	    mortranKeyword
hi def link mortranRepeat	    mortranKeyword
