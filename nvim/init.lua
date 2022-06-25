vim.g.mapleader = " "

--------------------------
-- Caching for init.lua --
--------------------------
require('impatient')

------------------------------
-- Neovim Function Bindings --
------------------------------
local execute = vim.api.nvim_command
local fn = vim.fn
local o = vim.o
local wo = vim.wo
local bo = vim.bo

-----------------------------
-- Remap Function Bindings --
-----------------------------
local remap = vim.api.nvim_set_keymap

function map(from, to)
	remap('', from, to, {})
end

function nmap(from, to)
	remap('n', from, to, {})
end

function noremap(from, to)
	remap('', from, to, { noremap = true })
end

function nnoremap(from, to)
	remap('n', from, to, { noremap = true })
end

function inoremap(from, to)
	remap('i', from, to, { noremap = true })
end

function vnoremap(from, to)
	remap('v', from, to, { noremap = true })
end

-------------
-- Plugins --
-------------

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

require('packer').startup(function()
	use {
		'RRethy/nvim-base16',
		'SmiteshP/nvim-gps',
		'bronson/vim-trailing-whitespace',
		'editorconfig/editorconfig-vim',
		'folke/which-key.nvim',
		'kyazdani42/nvim-tree.lua',
		'kyazdani42/nvim-web-devicons',
		'lewis6991/gitsigns.nvim',
		'lewis6991/impatient.nvim',
		'm-demare/hlargs.nvim',
		'neovim/nvim-lspconfig',
		'noib3/nvim-cokeline',
		'numToStr/Comment.nvim',
		'nvim-lua/plenary.nvim',
		'nvim-lua/popup.nvim',
		'nvim-lualine/lualine.nvim',
		'nvim-telescope/telescope-ui-select.nvim',
		'nvim-telescope/telescope.nvim',
		'p00f/nvim-ts-rainbow',
		'petertriho/nvim-scrollbar',
		'rust-lang/rust.vim',
		'simrat39/rust-tools.nvim',
		'wbthomason/packer.nvim',
		'yamatsum/nvim-cursorline',
		'hrsh7th/nvim-cmp',
		'hrsh7th/cmp-nvim-lsp',
		'dcampos/nvim-snippy',
		'dcampos/cmp-snippy',
        'jose-elias-alvarez/typescript.nvim',
	}
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate'
	}
	if packer_bootstrap then
		require('packer').sync()
	end
end)

------------------
-- VIM Settings --
------------------

-- Global
o.autoindent = true
o.autoread = true
o.autowrite = true
o.backspace = 'indent,eol,start'
o.backupcopy = 'yes'
o.compatible = false
o.completeopt = 'menu,menuone,noselect'
o.expandtab = true
o.encoding = 'utf-8'
o.formatoptions = 'tcq'
o.hlsearch = true
o.ignorecase = true
o.incsearch = true
o.shiftwidth = 4
o.shortmess = "Sc"
o.showmatch = true
o.smartcase = true
o.smartindent = true
o.softtabstop = 4
o.tabstop = 4
o.termguicolors = true
o.textwidth = 80
o.timeoutlen = 1000
o.ttimeoutlen = 0
o.undofile = true
o.laststatus = 2
o.number = true
o.relativenumber = true
o.syntax = true
o.signcolumn = 'yes'
o.mouse = a;

o.undodir = os.getenv('HOME') .. '/.vim/undo-dir'

-- Colorscheme
vim.g.base16colorspace = 256
vim.cmd('colorscheme base16-default-dark')
vim.cmd('filetype plugin indent on')

-- Autocmd
vim.cmd('autocmd BufWritePost plugins.lua PackerCompile')
-- vim.cmd('autocmd BufRead,BufNewFile *.md *.txt setlocal spell spelling=en_us')
vim.cmd('autocmd InsertLeave * set nopaste')
vim.cmd('au TextYankPost * silent! lua vim.highlight.on_yank()')

-- Remaps
nnoremap('up', '<nop>')
nnoremap('down', '<nop>')
nnoremap('<leader><leader>', '<c-^>')
nnoremap('<left>', ':bp<CR>')
nnoremap('<right>', ':bn<CR>')
nmap('<leader>w', ':w<CR>')

-- C-j to escape
inoremap('<C-j>', '<Esc>')
vnoremap('<C-j>', '<Esc>')

-- quick start and end
nmap('H', '^')
nmap('L', '$')

nnoremap('<leader>sd', '<cmd> lua vim.lsp.buf.hover()<cr>')
nnoremap('<leader>gd', '<cmd> lua vim.lsp.buf.definition()<cr>')
nnoremap('<leader>gD', '<cmd> lua vim.lsp.buf.declaration()<cr>')
nnoremap('[d', '<cmd> lua vim.diagnostic.goto_prev()<cr>')
nnoremap(']d', '<cmd> lua vim.diagnostic.goto_next()<cr>')
nnoremap('<leader>ld', '<cmd> lua vim.diagnostic.setloclist()<cr>')
nmap('<F2>', '<cmd> lua vim.lsp.buf.rename()<cr>')


-------------------------
-- Nvim Plugin Configs --
-------------------------

-- Git Signs - left sidebar git indicators
require('gitsigns').setup({
	current_line_blame = false
})

-- NvimTree - File navigator sidebar
require('nvim-tree').setup({
    view = {
        width = 40,
        side = "right"
    }
})
nnoremap('<C-n>', ':NvimTreeToggle<CR>')

-- Which Key - helpful pop up of what kyebindings exist
require('which-key').setup()

-- Nvim GPS - status line component to show where you are in the file
require('nvim-gps').setup()
local gps = require('nvim-gps')

-- Lualine - status line plugin
require('lualine').setup({
	extensions = {'nvim-tree'},
	sections = {
		lualine_c = {'filename', { gps.get_location, cond = gps.is_available } },
	},
})

-- Cokeline - Bufferbar plugin
require('cokeline').setup({
	sidebar = {
		filetype = 'NvimTree',
		components = {
			{
				text = ' NvimTree',
				style = 'bold',
			}
		},
	},
})

-- Nvim Treesitter - configs
require('nvim-treesitter.configs').setup({
	ensure_installed = 'all',
	highlight = {
		enable = true,
	},
	rainbow = {
		enable = true,
		extended_mode = true,
		max_file_lines = nil,
	}
})

require('nvim-web-devicons').setup({
	default = true,
})

local cmp = require('cmp')

require('cmp').setup({
	snippet = {
		expand = function(args)
			require('snippy').expand_snippet(args.body)
		end,
	},
	sources = {
		{ name = 'nvim_lsp' },
        { name = 'path' },
		{ name = 'snippy' },
	},
	mapping = cmp.mapping.preset.insert({
		['<Tab>'] = cmp.mapping.confirm({ select = true }),
	}),
    experimental = {
        ghost_text = true
    }
})

local capa = vim.lsp.protocol.make_client_capabilities()
capa = require('cmp_nvim_lsp').update_capabilities(capa)

-- hlargs - Highlight function args using treesitter
require('hlargs').setup()

-- typescript lsp setup.
require('typescript').setup({
    disable_commands = false,
    debug = false,
})

-- Rust Tools - Setup lsp and more automatically for rust
local opts = {
	server = {
		settings = {
			['rust-analyzer'] = {
				checkOnSave = {
					command = 'clippy',
				}
			},
		},
	},
}
require('rust-tools').setup(opts)

-- Telescope - Search, file finding, grepping, and more using builtins
require('telescope').setup({
	defaults = { file_ingore_patterns = {'target'} },
})
require('telescope').load_extension('ui-select')
tb = require('telescope.builtin')
nnoremap('<leader>ff', '<cmd> lua tb.find_files()<cr>')
nnoremap('<leader>fs', '<cmd> lua tb.lsp_document_symbols()<cr>')
nnoremap('<leader>fb', '<cmd> Telescope buffers<cr>')
nnoremap('<leader>.', '<cmd> lua vim.lsp.buf.code_action()<cr>')
vnoremap('<leader>.', '<cmd> lua vim.lsp.buf.range_code_action()<cr>')


-- Scrollbar - add a scroll bar to neovim
require('scrollbar').setup({
	handle = {
		color = '#b8b8b8',
	},
	handlers = {
		search = false,
	},
})

-- Comment - comment keymaps for extra powers on what to comment out
require('Comment').setup()

------------------------
-- Vim Plugin Configs --
------------------------
vim.g.rustfmt_autosave = 1
vim.g.rustfmt_recommended_style = 1
vim.g.rust_recommended_style = 0
vim.g.mix_format_on_save = 1

