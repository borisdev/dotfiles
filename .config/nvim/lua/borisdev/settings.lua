-- Prettier
vim.g["prettier#autoformat_config_present"] = 1
vim.g["prettier#autoformat"] = 1

-- ToggleTerm 
vim.keymap.set("n", "<C-t>", ":ToggleTerm direction=horizontal<CR>")

-- NO WORKS telescope settings
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})


-- clipboard binds (copy and paste from sys clipboard)
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+y$')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>p", '"+p')
vim.keymap.set("n", "<leader>P", '"+P')
vim.keymap.set("v", "<leader>p", '"+p')
vim.keymap.set("v", "<leader>P", '"+P')

vim.opt.mouse="a" -- mouse active in all modes
vim.opt.background = "dark" 
vim.opt.number = true                        
vim.opt.ruler = true                        
vim.opt.title = true                        
vim.opt.termguicolors = true -- true colors when in terminal mode
vim.opt.scrolloff = 2 -- add 2 virtual lines at end
vim.opt.hidden = true -- move amongst buffers w/o write, vimtricks.com/p/what-is-set-hidden/

vim.cmd([[
    autocmd BufWritePre *.html,*.css,*.js,*.json,*.md Prettier
    autocmd BufWritePre *.py Black
    autocmd BufWritePre *.py Isort
    autocmd FileType markdown setlocal spell
    autocmd FileType gitcommit setlocal spell
    autocmd BufWritePre *.py %s/\s\+$//e " removes trailing whitespace from python files on save
    autocmd BufWritePost *.py call Flake8()
    let g:syntastic_python_flake8_config_file='.flake8'
    xnoremap p pgvy  " https://stackoverflow.com/questions/7163947/paste-multiple-times
    nnoremap <Esc><Esc> :noh<CR>
]])

vim.cmd([[ 
    set smarttab
    set softtabstop=4
    set tabstop=4
    set shiftwidth=4
    set expandtab
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
    set clipboard=unnamedplus
]])
