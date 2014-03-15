filetype on " without this vim emits a zero exit status, later, because of :ft off
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif
if filereadable(expand("~/.vimrc.bundles.local"))
  source ~/.vimrc.bundles.local
endif

syntax on
set nocompatible
set clipboard=unnamed 	" yank and paste with the system clipboard
filetype plugin indent on

" vim-airline settings
let g:airline_powerline_fonts = 1

" Editing preferences
set autoindent
set autoread		" reload files when changed on disk, i.e. via `git checkout` 
set encoding=utf-8	" encoding preference
set expandtab		" expand tabs to spaces
set smartcase 		" case-sensitive search if any caps
set softtabstop=2 	" insert mode tab and backspace use 2 spaces
set tabstop=2 		" actual tabs occupy 8 characters
set shiftwidth=2
set wildmenu " show a navigable menu for tab completion
set wildmode=longest,list,full
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*/node_modules,*/bower_components,*/fixtures  " ignores misc. files
set hidden

" Searching preferences
set ignorecase		" case-insensitive search
set incsearch		" search as you type

" Visual settings
set number 		" Show row numbers
set cursorline		" Highlight current line
set gfn=Inconsolata-dz\ for\ Powerline:h12
colorscheme jellybeans	" Default colorscheme jellybeans
set noshowmode		" Hide the default mode text below statusline
set laststatus=2
set list		" show trailing whitespace
set listchars=tab:▸\ ,trail:·,extends:❯,precedes:❮
set guioptions+=c	" supresses popup messages in the statusline (macvim)
set guioptions-=L	" no left scrollbar
set guioptions-=r	" no right scrollbar
set guioptions-=R

" Keyboard shortcuts
let mapleader = ','
nnoremap / /\v
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap <C-a> :b
nnoremap ; :
map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" md is markdown
autocmd BufRead,BufNewFile *.md set filetype=markdown

" Swap settings
set directory-=.

let g:miniBufExplStatusLineText = ""

" Plugin settings
let g:ctrlp_match_window = 'max:20'


" Load local settings
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
