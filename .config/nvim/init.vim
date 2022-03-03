set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
set encoding=UTF-8

call plug#begin(stdpath('data') . '/plugged')
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
