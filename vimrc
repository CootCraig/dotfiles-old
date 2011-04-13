"Use Vim settings, rather then Vi settings (much better!).
"This must be first, because it changes other options as a side effect.
set nocompatible

runtime vim-pathogen/autoload/pathogen.vim

"activate pathogen
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

set hidden

"Use case-smart searching
set ignorecase
set smartcase

set title
set scrolloff=3
set shortmess=atI

" Search Config

" show the `best match so far' as search strings are typed:
set incsearch

" assume the /g flag on :s substitutions to replace all matches in a line:
set gdefault

nnoremap ' `
nnoremap ` '

" UTF-8 All the way
scriptencoding utf-8

" Use zsh.
set shell=zsh

" Enable filetype-specific indenting, syntax, and plugins
filetype plugin indent on
syntax on

" Disable bell.
set vb t_vb=

" Set to auto read when a file is changed from the outside
set autoread

" COLOR SUPPORT

" Explicitly set 256 color support
set t_Co=256

" colorscheme vividchalk
colorscheme calmar256-dark

" TEXT SETTINGS

" Disable line wrapping
set nowrap
" set wrap

" use indents of 2 spaces, and have them copied down lines:
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

" line numbers
set number
set numberwidth=3

" kill trailing spaces when exiting file
autocmd BufWritePre * :%s/\s\+$//e

" KEY BINDINGS

let mapleader = ","

" WINDOW SPLITTING

" Open new horizontal split windows below current
set splitbelow

" Open new vertical split windows to the right
set splitright


" Set temporary directory (don't litter local dir with swp/tmp files)
set directory=/tmp/

" Use the tab complete menu
set wildmenu
set wildmode=list:longest,full

" KEYBINDINGS

" Quick, jump out of insert mode while no one is looking
" imap ii <Esc>

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$


" CUSTOM PLUGINS

" CUSTOM FUNCTIONS

" Add RebuildTagsFile function/command
function! s:RebuildTagsFile()
  !ctags -R --exclude=coverage --exclude=files --exclude=public --exclude=log --exclude=tmp --exclude=vendor *
endfunction
command! -nargs=0 RebuildTagsFile call s:RebuildTagsFile()


" STATUS BAR CONFIG

set laststatus=2
set statusline=\ "
set statusline+=%f\ " file name
set statusline+=[
set statusline+=%{strlen(&ft)?&ft:'none'} " filetype
set statusline+=]
set statusline+=%h%1*%m%r%w%0* " flag
set statusline+=%= " right align
set statusline+=%-14.(%l,%c%V%)\ %<%P " offset


" NERDTree CONFIGURATION

" Enable nice colors
let NERDChristmasTree = 1

" Make it easy to see where we are
let NERDTreeHighlightCursorline = 1

" Make bookmarks visible
let NERDTreeShowBookmarks = 1

" Show hidden files
let NERDTreeShowHidden = 1

" Don't hijack NETRW
let NERDTreeHijackNetrw = 0
let NERDTreeIgnore=['\.$', '\~$']

" Make F2 open NERDTree
nmap <F2> :NERDTreeToggle<CR>


" RUBY

" Highlight ruby operators
let ruby_operators = 1

" Turn off rails bits of statusbar
let g:rails_statusline=0

" NERDTree

" Enable nice colors
let NERDChristmasTree = 1

" Make it easy to see where we are
let NERDTreeHighlightCursorline = 1

" Make bookmarks visible
let NERDTreeShowBookmarks = 1

" Show hidden files
let NERDTreeShowHidden = 1
" Don't hijack NETRW
let NERDTreeHijackNetrw = 0
let NERDTreeIgnore=['\.$', '\~$']

" AUTOCOMMANDS

" function! CustomJsonSettings()
  " autocmd BufRead *.json set filetype=json
  " au! Syntax json source ~/Downloads/json.vim
  " autocmd FileType json set equalprg=json_reformat
  " autocmd FileType json set makeprg=jsonval\ %
  " autocmd FileType json set errorformat=%E%f:\ %m\ at\ line\ %l,%-G%.%#
" endfunction

function! CustomMarkdownSettings()
  set filetype=mkd
endfunction

" taglist
"
nmap <F3> :TlistToggle<CR>

