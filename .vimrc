" An vimrc file.
"
" Maintainer:	Ljubomir Kurij <kurijlj@gmail.com>
" Last change:	2013 Mar 23
"

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
" Added by Ljubomir Kurij on 2013 Mar 23.
"
set ignorecase		" do case insensitive searching
set smartcase		" except on included upper-case charcters

" Don't use Ex mode, use Q for formatting
map Q gq

" In many terminal emulators the mouse works just fine, thus enable it.
set mouse=a

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
"command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
"	 	\ | wincmd p | diffthis


" Added by Ljubomir Kurij on 2009 Feb 07.
"

" Set nowrap option
set nowrap

" Show all characters
set list listchars=tab:»·,trail:·,extends:»

" Show line numbers and highlight cursor position
set number
set cursorline


" Added by Ljubomir Kurij on 2009 Oct 28.
"

" Make command line two lines high
set ch=2

" Only do this for Vim version 5.0 and later.
if version >= 500

  " Switch highlighting strings inside C comments on
  let c_comment_strings=1

endif


" Added by Ljubomir Kurij on 2012 Nov 05.
"

set guifont=Tamsyn\ 12


" Added by Ljubomir Kurij on 2013 Mar 23.
"

execute pathogen#infect()


" Added by Ljubomir Kurij on 2010 Sep 28.
"

"colorscheme desert
set background=dark
colorscheme solarized


" Added by Ljubomir Kurij on 2013 July 06.
"

set cc=80
set textwidth=80
set wrapmargin=2

" Added by Ljubomir Kurij on 2013 Aug 18.
"

map ntt <Esc>:NERDTreeToggle<CR>
map tlt <Esc>:TlistToggle<CR>
map \q i"<Esc>ea"<Esc>
map \qq i"<Esc>$a"<Esc>
map \cx i/* <Esc>$a */<Esc>
map \a i<<Esc>ea><Esc>
map \aa i<<Esc>$a><Esc>
map \b i[<Esc>ea]<Esc>
map \bb i[<Esc>$a]<Esc>
map \c i{<Esc>ea}<Esc>
map \cc i{<Esc>$a}<Esc>
map \p i(<Esc>ea)<Esc>
map \pp i(<Esc>$a)<Esc>

" Added by Ljubomir Kurij on 2013 Aug 31.
"
"
if has("gui_running")

  " GUI is running or is about to start.
  " Set some resonable size for gvim window.
  set lines=55 columns=90

endif
