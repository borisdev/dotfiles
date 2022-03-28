-- quick way to convert settings in init.vim or .vimrc to init.lua
-- convert tab to space
vim.cmd([[
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set expandtab
]])

-- general way to set vim settings to lua langauge
vim.opt.mouse = "a" -- mouse active in all modes
vim.opt.background = "dark" 
vim.opt.number = true                        
vim.opt.ruler = true                        
vim.opt.title = true                        
vim.opt.termguicolors = true -- true colors when in terminal mode
vim.opt.scrolloff = 2 -- add 2 virtual lines at end
vim.opt.hidden = true -- move amongst buffers w/o write, vimtricks.com/p/what-is-set-hidden/


vim.g.NERDTreeMouseMode = 3 -- I think one mouse click to open file
vim.g.NERDTreeShowHidden = 1  -- show dotfiles


-- not sure what these do
vim.cmd([[ 
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
]])
