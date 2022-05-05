" From https://github.com/rescript-lang/vim-rescript/blob/master/syntax/rescript.vim
if exists("b:current_syntax")
  finish
endif

" See https://github.com/rescript-lang/vim-rescript/issues/14
syntax sync minlines=600

" Boolean
syntax keyword rescriptBoolean true false

" Keywords
syntax keyword rescriptKeyword let rec type external mutable lazy private of with
syntax keyword rescriptKeyword try catch exception assert
syntax keyword rescriptConditional if else switch when
syntax keyword rescriptKeyword and as open include module in constraint import export
syntax keyword rescriptRepeat for to downto while

" Types
syntax keyword rescriptType bool int float char string unit
syntax keyword rescriptType list array option ref exn format

" Operators
syntax keyword rescriptOperator mod land lor lxor lsl lsr asr
syntax keyword rescriptOperator or

syntax match rescriptOperator "\v\="

syntax match rescriptOperator "\v\*"
syntax match rescriptOperator "\v/"
syntax match rescriptOperator "\v\+"
syntax match rescriptOperator "\v-"

syntax match rescriptOperator "\v\*\."
syntax match rescriptOperator "\v/\."
syntax match rescriptOperator "\v\+\."
syntax match rescriptOperator "\v-\."

syntax match rescriptOperator "\v\<"
syntax match rescriptOperator "\v\<\="
syntax match rescriptOperator "\v\>"
syntax match rescriptOperator "\v\>\="

syntax match rescriptOperator "\v\@"

syntax match rescriptOperator "\v\!"
syntax match rescriptOperator "\v\|"
syntax match rescriptOperator "\v\&"

" Refs
syntax match rescriptOperator "\v\:\="

" Arrows / Pirescript
syntax match rescriptArrowPipe "\v\=\>"
syntax match rescriptArrowPipe "\v\-\>"
syntax match rescriptArrowPipe "\v\|\>"
syntax match rescriptArrowPipe "\v\@\@"

" Comment
syntax region rescriptSingleLineComment start="//" end="$" contains=rescriptTodo,@Spell
syntax region rescriptMultiLineComment start="/\*\s*" end="\*/" contains=@Spell,rescriptTodo,rescriptMultiLineComment

syntax keyword rescriptTodo contained TODO FIXME XXX NOTE

" Char
syntax match rescriptChar "\v'\\.'|'.'"

syntax match rescriptNumber "-\=\<\d\(_\|\d\)*[l|L|n]\?\>"
syntax match rescriptNumber "-\=\<0[x|X]\(\x\|_\)\+[l|L|n]\?\>"
syntax match rescriptNumber "-\=\<0[o|O]\(\o\|_\)\+[l|L|n]\?\>"
syntax match rescriptNumber "-\=\<0[b|B]\([01]\|_\)\+[l|L|n]\?\>"
syntax match rescriptFloat "-\=\<\d\(_\|\d\)*\.\?\(_\|\d\)*\([eE][-+]\=\d\(_\|\d\)*\)\=\>"

" Module / Constructor
syntax match rescriptModuleOrVariant "\v<[A-Z][A-Za-z0-9_'$]*"
syntax match rescriptModuleChain "\v<[A-Z][A-Za-z0-9_'$]*\."

" Attribute
syntax match rescriptAttribute "\v\@([a-zA-z][A-Za-z0-9_']*)(\.([a-zA-z])[A-Za-z0-9_']*)*"

" String
syntax match rescriptUnicodeChar "\v\\u[A-Fa-f0-9]\{4}" contained
syntax match rescriptStringEscapeSeq "\v\\[\\"ntbrf]" contained
syntax match rescriptInterpolatedStringEscapeSeq "\v\\[\\`ntbrf]" contained

syntax region rescriptString start="\v\"" end="\v\"" contains=rescriptStringEscapeSeq,rescriptUnicodeChar

" Interpolation
syntax match rescriptInterpolationVariable "\v\$[a-z_][A-Za-z0-0_'$]*" contained
syntax region rescriptInterpolationBlock matchgroup=rescriptInterpolationDelimiters start="\v\$\{" end="\v\}" contained contains=TOP
syntax region rescriptString start="\v`" end="\v`" contains=rescriptInterpolationBlock,rescriptInterpolatedStringEscapeSeq
syntax region rescriptString start="\v[a-z]`" end="\v`" contains=rescriptInterpolationBlock,rescriptInterpolationVariable,rescriptInterpolatedStringEscapeSeq

" Polymorphic variants
syntax match rescriptPolyVariant "\v#[A-za-z][A-Za-z0-9_'$]*"
syntax match rescriptPolyVariant "\v#[0-9]+"
syntax match rescriptPolyVariant "\v#\".*\""
syntax match rescriptPolyVariant "\v#\\\".*\""

hi def link rescriptBoolean Boolean
hi def link rescriptKeyword Keyword
hi def link rescriptConditional Conditional
hi def link rescriptRepat Repeat
hi def link rescriptType Type
hi def link rescriptOperator Operator
hi def link rescriptArrowPipe Operator
hi def link rescriptSingleLineComment Comment
hi def link rescriptMultiLineComment Comment
hi def link rescriptTodo TODO
hi def link rescriptChar Character
hi def link rescriptNumber Number
hi def link rescriptFloat Float
hi def link rescriptModuleOrVariant rescriptTSConstant
hi def link rescriptPolyVariant Function
hi def link rescriptModuleChain Macro
hi def link rescriptUnicodeChar Character
hi def link rescriptStringEscapeSeq Character
hi def link rescriptInterpolatedStringEscapeSeq Character
hi def link rescriptString String
hi def link rescriptInterpolationDelimiters Macro
hi def link rescriptInterpolationVariable Macro
hi def link rescriptAttribute PreProc

let b:current_syntax = "rescript"
