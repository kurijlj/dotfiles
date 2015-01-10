" Vim syntax file
" Language:     Notes
" Filenames:    *.notes
" Maintainer:   Ljubomir Kurij  <kurijlj@gmail.com>
" URL:          
" Last Change:  2010 Sep 28
"               2010 Sep 28 - initial version

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Titles
syn region notesTitle1  start="^[0-9]\+\. " end="$" keepend
syn region notesTitle2  start="^[0-9]\+\.[0-9]\+\. " end="$" keepend
syn region notesNote  start="^NOTE: " end="$" keepend
syn region notesTodo  start="^TODO: " end="$" keepend
syn match  notesComment /^# .*/
syn match  notesCmdline /^\t\(#\|\$\) .*/

" Synchronization
syn sync minlines=50
syn sync maxlines=500

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
"hi def link notesTitle1  Title
hi def notesTitle1  term=underline,bold cterm=underline,bold gui=underline,bold guifg=indianred
hi def link notesTitle2  NonText
hi def link notesNote    ModeMsg
hi def link notesTodo    Todo
hi def link notesComment Comment
hi def notesCmdline term=italic cterm=italic gui=italic guifg=yellowgreen

let b:current_syntax = "notes"

" vim: ts=8
