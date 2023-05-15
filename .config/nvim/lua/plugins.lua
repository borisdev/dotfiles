vim.cmd([[ 

"
" Rationale: When the vim-plug package manager does not exist then it must be auto installed in new containers and laptops
" Source: modified this https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
" We want this --> $HOME/.local/share/nvim/site/autoload/plug.vim
" stdpath('data') denotes $HOME/.local/share/nvim

let data_dir = stdpath('data') . '/site' 
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"
" List of the vim plugins (requirements.txt)
"

call plug#begin(stdpath('data') . '/plugged')
Plug 'ellisonleao/glow.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim'
Plug 'vim-airline/vim-airline'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-telescope/telescope.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'scrooloose/nerdtree'
Plug 'nvie/vim-flake8'
Plug 'github/copilot.vim'
Plug 'nvim-tree/nvim-web-devicons' " optional, for file icons
Plug 'nvim-tree/nvim-tree.lua'
Plug 'rhysd/vim-grammarous'
Plug 'psf/black', { 'branch': 'stable' }
call plug#end()
]])
