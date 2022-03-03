" Vim swapping block docker container to see mounted file changes
" https://github.com/moby/moby/issues/15793#issuecomment-571932545
" Disable swapping files in the same directory as edited file,
" mostly for editing /etc/hosts which is mounted to Docker HostManager
" and swapping causes inode change and breaks DHM.
" @see https://stackoverflow.com/a/15317146/842480
" IMPORTANT: directories must exist, so create them!
" :set backupdir=~/.vim/backup//
" :set directory=~/.vim/swap//
" :set undodir=~/.vim/undo//

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Pathogen -- package installer, uses concept of a bundle
"
execute pathogen#infect()

" Syntastic (Manages UI of syntax checkers)
" 3. Recommended settings
" https://github.com/vim-syntastic/syntastic#3-recommended-settings

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1
let g:syntastic_python_checkers = ['flake8']
" let g:syntastic_python_checkers = ['pylint', 'flake8']
let g:syntastic_python_flake8_post_args='--ignore=E501'
let g:syntastic_loc_list_height=2

" Disable annoying bell sound when I push escape
set belloff=all
set noerrorbells
set vb t_vb=

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Keep VIM Plugin commands between vundle#begin/end.

" subsequent to opens, it will asynchronously update our tag file on save
" https://medium.com/@kuiro5/best-way-to-set-up-ctags-with-neovim-37be99c1bd11
Plugin 'ludovicchabant/vim-gutentags'

" fugitive runs git commands from vim such as :Gcommit
Plugin 'git://github.com/tpope/vim-fugitive'

" syntatastic includes jslint and other syntax checkers
Plugin 'git://github.com/scrooloose/syntastic.git'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line



set background=dark   
set nowrap            
set scrolloff=2       
set number            
set showmatch         
set showmode          
set showcmd            
set ruler              
set title               
set wildmenu            
set wildignore=*.o,*.obj,*.bak,*.exe,*.py[co],*.swp,*~,*.pyc,.svn
set laststatus=2        
set matchtime=2         
set matchpairs+=<:>     

set ignorecase         
set smartcase          
set smartindent         
set smarttab            
set magic           
set bs=indent,eol,start 

set tabstop=4           
set shiftwidth=4        
set expandtab       

" https://vi.stackexchange.com/questions/422/displaying-tabs-as-characters
set listchars=eol:¬,tab:▸\ 

set lazyredraw         
set confirm            
set nobackup           
set viminfo='20,\"500  
set hidden              
set history=50          
set mouse=v             

if &t_Co > 2 || has("gui_running")
  syntax on         
  set hlsearch       
  set incsearch 
endif

map <F10> :set paste<CR>
map <F11> :set nopaste<CR>
imap <F10> <C-O>:set paste<CR>
imap <F11> <nop>
set pastetoggle=<F11>

filetype plugin indent on


set paste
set textwidth=80
syntax on
set hlsearch
filetype indent plugin on
set grepprg=grep\ -nH\ $*
filetype indent on
let g:tex_flavor='latex'

set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set expandtab

" How To Generate Ctags Include Python site-packages
" Go into the project's directory and run ctags to generate the file that is the index -- the map for each funtion to its file path location
" use ~/.gitignore so we dont add these local files to the group repo
" ctags -R --fields=+l --languages=python --python-kinds=-iv -f ./.python_tags $(python -c "import os, sys; print(' '.join('{}'.format(d) for d in sys.path if os.path.isdir(d)))")
set tags+=./.python_tags
set statusline+=%{gutentags#statusline()}
