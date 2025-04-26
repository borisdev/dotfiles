-- Reminder :TSInstall typescript and :TSInstall tsx 
--
-- Prettier
vim.g["prettier#autoformat_config_present"] = 1
vim.g["prettier#autoformat"] = 1

-- ToggleTerm 
vim.keymap.set("n", "<leader>tt", ":ToggleTerm direction=horizontal<CR>")

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

-- Set basic vim colorscheme with customized strings
vim.cmd([[
  colorscheme vim
  
  " Make strings bright green
  hi String guifg=#50FA7B gui=NONE
]])

-- We're now using Gruvbox theme, so we don't need this fix
-- vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
--   pattern = {"*.py"},
--   callback = function()
--     vim.cmd("syntax off")
--     vim.cmd("syntax on")
--   end,
-- })

vim.cmd([[
    " Save cursor position before formatting and restore after
    function! PreservePosition(command)
        let l:save = winsaveview()
        execute a:command
        call winrestview(l:save)
    endfunction

    " Use preserved position formatters
    autocmd BufWritePre *.html,*.css,*.js,*.json,*.md call PreservePosition('Prettier')
    autocmd BufWritePre *.py call PreservePosition('Black')
    autocmd BufWritePre *.py call PreservePosition('Isort')
    autocmd BufWritePre *.py call PreservePosition('%s/\s\+$//e')
    autocmd FileType markdown setlocal spell
    autocmd FileType gitcommit setlocal spell
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

vim.api.nvim_create_autocmd("FileType", {
    pattern = "typescript",
    callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
        vim.opt_local.expandtab = true
    end,
})
