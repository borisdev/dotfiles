" terminal mode
" =============
"
" true colors when in terminal mode
set termguicolors

" To map <Esc> to exit terminal-mode
" Source neovim.io/doc/user/nvim_terminal_emulator.html
:tnoremap <Esc> <C-\><C-n>

set encoding=UTF-8
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
set lazyredraw         
set confirm            
set nobackup           
set viminfo='20,\"500  
set hidden              
set history=50          
set mouse=v             
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set expandtab

" Generate the file that is an index to search for all funcs in Python site-packages
" In the project's directory and run ctags
" ctags -R --fields=+l --languages=python --python-kinds=-iv -f ./.python_tags $(python -c "import os, sys; print(' '.join('{}'.format(d) for d in sys.path if os.path.isdir(d)))")
" add `.python_tags` to ~/.gitignore
set tags+=./.python_tags

" jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif


call plug#begin(stdpath('data') . '/plugged')
Plug 'ludovicchabant/vim-gutentags'
Plug 'neovim/nvim-lspconfig'
Plug 'vim-airline/vim-airline'
Plug 'glepnir/lspsaga.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-telescope/telescope.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'scrooloose/nerdtree'
call plug#end()




" *****  Playground for using the lua scripting language


lua print('output of example to embed a single lua script line')

lua << EOF
print("output of example to embed many lua script lines")
print("output of example to embed many lua script lines")
EOF

" call lua script ~/.config/nvim/lua/basic.lua
lua require('basic')
