" Vim support file to detect file types
"
" Maintainer:	Ljubomir Kurij <kurijlj@gmail.com>
" Last Change:	2010 Sep 28

" Listen very carefully, I will say this only once
if exists("did_load_filetypes")
	finish
endif

augroup filetypedetect
	au! BufRead,BufNewFile *.notes		setfiletype notes
	au! BufRead,BufNewFile *.pcl		setfiletype pythoncodelog
augroup END
