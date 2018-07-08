" Vim support file to detect file types
"
" Maintainer:	Ljubomir Kurij <kurijlj@gmail.com>
" Last Change:	2018 Jul 07

" Listen very carefully, I will say this only once
if exists("did_load_filetypes")
	finish
endif

augroup filetypedetect
	au! BufRead,BufNewFile .conkyrc		setfiletype conkyrc
	au! BufRead,BufNewFile *.mortran	setfiletype mortran
augroup END
