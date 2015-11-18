SoftPencil
MBEClose
let g:auto_save = 1
set nonumber
set spell

let b:current_syntax = "book"
syn match characterNames /\(Mr. Wilson\|Cormac\|The boy\|Earl\|Wilson\|Holden\|Anderson\|The elder anderson\|Kathy\|Gene\|Coleman\)\('s\)\?[ .,;?!]/
syn match concepts /\(MacGuffin\|Verum Novum\|VN\|safe house\)'\?s\?[ .,;?!]/
hi def link characterNames Type
hi def link concepts Statement

autocmd FileType md set ft=book
