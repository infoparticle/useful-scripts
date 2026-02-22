
-- ==========================================
-- curl -sSL https://github.com/infoparticle/useful-scripts/raw/refs/heads/main/scripts/dotfiles/tools.editor.vim/dot_config_nvim_init.lua
-- ==========================================

local opt = vim.opt
local g = vim.g

-- --- General Settings ---
opt.mouse = 'a'
opt.clipboard = 'unnamedplus'
opt.encoding = 'utf-8'
opt.fileformats = 'unix,dos'
opt.history = 1000
opt.backspace = 'indent,eol,start'
opt.hidden = true
opt.autoread = true
opt.updatetime = 300
opt.timeoutlen = 500
opt.ttimeoutlen = 10
opt.swapfile = false
opt.backup = false
opt.writebackup = false

-- --- Persistent Undo ---
local undodir = vim.fn.expand('~/.local/share/nvim/undo')
if vim.fn.isdirectory(undodir) == 0 then
    vim.fn.mkdir(undodir, 'p')
end
opt.undofile = true
opt.undodir = undodir
opt.undolevels = 1000

-- --- UI & Visuals ---
opt.number = true
opt.relativenumber = true
-- opt.cursorline = true
opt.termguicolors = true
opt.laststatus = 2
opt.showcmd = true
opt.wildmenu = true
opt.wildmode = 'longest:full,full'
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.title = true
opt.showmatch = true
opt.matchtime = 2
opt.signcolumn = 'auto'
opt.linebreak = true
opt.breakindent = true
opt.listchars = { tab = '»·', trail = '·', extends = '>', precedes = '<', nbsp = '+', eol = '¬' }

-- --- Indentation ---
opt.autoindent = true
opt.smartindent = true
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftround = true

-- --- Search ---
opt.incsearch = true
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.wrapscan = true

-- --- Colors & Statusline ---
vim.cmd('colorscheme sorbet')
-- opt.background = 'dark'

-- Simple informative statusline
opt.statusline = "%#PmenuSel# %{toupper(&filetype)} %#LineNr# %f %m %r %=%{&fileencoding?&fileencoding:&encoding} [%{&fileformat}] %l:%c %p%% "

-- --- Netrw Settings ---
g.netrw_banner = 0
g.netrw_liststyle = 3
g.netrw_browse_split = 4
g.netrw_altv = 1
g.netrw_winsize = 20

-- --- Key Mappings ---
g.mapleader = " "
local keymap = vim.keymap.set

-- Navigation & General
keymap('n', '<Leader>/', ':nohlsearch<CR>')
keymap('n', '<Leader>w', ':w<CR>')
keymap('n', '<Leader>q', ':q<CR>')
keymap('n', '<Leader>x', ':x<CR>')
keymap('n', '<C-h>', '<C-w>h')
keymap('n', '<C-j>', '<C-w>j')
keymap('n', '<C-k>', '<C-w>k')
keymap('n', '<C-l>', '<C-w>l')

-- Buffer & Tabs
keymap('n', '<Leader>bn', ':bnext<CR>')
keymap('n', '<Leader>bp', ':bprevious<CR>')
keymap('n', '<Leader>bd', ':bdelete<CR>')
keymap('n', 'gt', ':tabnext<CR>')
keymap('n', 'gT', ':tabprevious<CR>')

-- Visual Mode Enhancements
keymap('v', 'J', ":m '>+1<CR>gv=gv")
keymap('v', 'K', ":m '<-2<CR>gv=gv")
keymap('v', '<', '<gv')
keymap('v', '>', '>gv')

-- Functionality Toggles
keymap('n', '<Leader>ln', ':set relativenumber!<CR>')
keymap('n', '<Leader>li', ':set list!<CR>')
keymap('n', '<Leader>z', 'za')

-- leetcode!
keymap('n', '<leader>r', ':w<CR>:!sh %:p:h/run.sh<CR>', { desc = "Run local run.sh" })

-- --- Autocommands (Language Specific) ---
local function au(group, ft, pattern, callback)
    vim.api.nvim_create_autocmd(group, { pattern = pattern, callback = callback })
end

-- Highlight Yank
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank({ timeout = 200 })
    end
})

-- Terminal Mode
keymap('t', '<Esc><Esc>', [[<C-\><C-n>]])
keymap('n', '<Leader>tt', ':split | terminal<CR>')

-- --- Utility Functions ---
function _G.netrw_toggle()
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if vim.bo[bufnr].filetype == 'netrw' then
            vim.api.nvim_buf_delete(bufnr, { force = true })
            return
        end
    end
    vim.cmd('Lexplore')
end
keymap('n', '<Leader>e', '<cmd>lua netrw_toggle()<CR>')

-- Restore last position
vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        if mark[1] > 1 and mark[1] <= vim.api.nvim_buf_line_count(0) then
            vim.api.nvim_win_set_cursor(0, mark)
        end
    end
})
