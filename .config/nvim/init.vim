" Mouse
" =====
"
" in all modes mouse can resize vim windows, select files in NERDTree, etc
set mouse=a


" Avoid tabs
" ===========
"
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set expandtab

" NERDTree
" =============
"
" show dotfiles
let NERDTreeShowHidden=1
" open nodes with a single mouse click
let NERDTreeMouseMode=3

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif


" terminal mode
" =============
"
" true colors when in terminal mode
set termguicolors

" To map <Esc> to exit terminal-mode
" Source neovim.io/doc/user/nvim_terminal_emulator.html
:tnoremap <Esc> <C-\><C-n>

" UX configurations
" =================
"
" basics
set background=dark   
set number            
set ruler              
set title               

" add two virtual lines after last line
set scrolloff=2       

" allow to move around file buffers w/o write
" important for some plugins not to trigger by write event
" https://vimtricks.com/p/what-is-set-hidden/
set hidden              

" research what these do
set showmatch         
set showmode          
set showcmd            
set wildmenu            
set wildignore=*.o,*.obj,*.bak,*.exe,*.py[co],*.swp,*~,*.pyc,.svn
set laststatus=2      
set matchtime=2         
set matchpairs+=<:>     
set ignorecase         
set smartcase          
set smartindent         
set magic           
set bs=indent,eol,start 
set lazyredraw         
set confirm            
set nobackup           
set viminfo='20,\"500  
set history=50          
set mouse=v             


" CTAGS
" =====
"
" i manually run `ctags` to index of python funcs of site-packages per project dir
set tags+=./.python_tags


" Install Plugins
" ===============
"
call plug#begin(stdpath('data') . '/plugged')
Plug 'ludovicchabant/vim-gutentags'
Plug 'neovim/nvim-lspconfig'
Plug 'vim-airline/vim-airline'
Plug 'glepnir/lspsaga.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-telescope/telescope.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" use vim to type in web text fields in chrome browser after installing chrome firenvim plugin 
" https://jdhao.github.io/2020/01/01/firenvim_nvim_inside_browser/
" The above setting works for Windows and Linux. For macOS, due to the reason that $PATH variable is changed inside browser, we need to run the following command on the command line:
" nvim --headless -c "call firenvim#install(0, 'export PATH=\"$PATH\"')" -c quit
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

call plug#end()


" HELPERS
" =======
" jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" nerdtree-git-plugin
" ====================
"
" Default mapping of git file status to symbols
"
let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }

" Sandbox to learn Lua scripting
" ==============================
"
lua print('output of example to embed a single lua script line')

lua << EOF
print("output of example to embed many lua script lines")
print("output of example to embed many lua script lines")

-- call lua script ~/.config/nvim/lua/basic.lua
require('basic')
EOF
