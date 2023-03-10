vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.rustfmt_autosave = 1
vim.opt.termguicolors = true
vim.opt.showmode = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.updatetime = 300
vim.opt.signcolumn = 'yes'
vim.opt.guicursor = 'n-v-c-i:ver15-blinkon450-blinkoff150'

vim.api.nvim_exec ( 'language en_US', true )
vim.api.nvim_exec ( 'syntax enable', true )
vim.api.nvim_exec ( 'set number', true )
vim.api.nvim_exec ( 'set autoindent smartindent', true )
vim.api.nvim_exec ( 'set virtualedit=onemore', true )
vim.api.nvim_exec ( 'set clipboard=unnamed', true )
vim.api.nvim_exec ( 'set tabstop=4', true )
vim.api.nvim_exec ( 'set shiftwidth=4', true )
vim.api.nvim_exec ( 'set expandtab', true )
vim.api.nvim_exec ( 'set makeprg=mingw32-make', true )

-- ////////////////////////////////////////////////////////////

function _G.ensure_packer()
	local fn = vim.fn
	local install_path = fn.stdpath( 'data' )..'/site/pack/packer/start/packer.nvim'
	if fn.empty( fn.glob( install_path ) ) > 0 then
		fn.system( { 'git', 'clone', '--clone', '1', 'https://github.com/wbthomason/packer.nvim', install_path } )
		vim.cmd [[packadd packer.nvim]]
		return true
	end

	return false
end

function _G.map( mode, lhs, rhs, opts )
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend( 'force', options, opts )
	end
	vim.api.nvim_set_keymap( mode, lhs, rhs, options )
end

function _G.check_backspace()
	local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end

-- ////////////////////////////////////////////////////////////

local opts = { noremap = true }
map( 'n', 'a', 'i', opts ) -- insert mode, remove append
map( 'n', '$', 'g$', opts )
map( 'n', ',', '<leader>', opts )

map( 'n', 'j', 'h', opts ) -- Remap hjkl to jikl
map( 'n', 'i', 'k', opts ) 
map( 'n', 'k', 'j', opts ) --       i
map( 'n', 'l', 'l', opts ) --     j k l

map( 'v', 'j', 'h', opts )
map( 'v', 'i', 'k', opts ) 
map( 'v', 'k', 'j', opts )
map( 'v', 'l', 'l', opts )

map( 'i', '<M-j>', '<Left>', opts ) -- move inside insert mode using jikl
map( 'i', '<M-i>', '<Up>', opts )
map( 'i', '<M-k>', '<Down>', opts )
map( 'i', '<M-l>', '<Right>', opts )

map( 'n', '<M-j>', '<C-w>h', opts ) -- Split Windows 
map( 'n', '<M-i>', '<C-w>k', opts )
map( 'n', '<M-k>', '<C-w>j', opts )
map( 'n', '<M-l>', '<C-w>l', opts )

map( 'n', '<M-e>', ':NvimTreeToggle<CR>' ) -- open NvimTree
map( 'n', '<C-s>', ':wa<CR>' ) -- save project

map( 'v', '<C-c>', '"+y', opts ) -- use default Ctrl + c,v,x
map( 'v', '<C-x>', '"+c', opts )
map( 'v', '<C-v>', 'c<ESC>"+p', opts )
map( 'n', '<C-v>', 'c<ESC>"+p', opts ) -- disable visual block mode
map( 'i', '<C-v>', '<C-r><C-o>+', opts )

map( 'n', '<C-z>', ':undo<CR>', opts )
map( 'n', '<C-y>', ':redo<CR>', opts )

local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
map( 'i', '<S-TAB>', [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts )
map( 'i', '<CR>', [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts )
map( 'i', '<TAB>', 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_backspace() ? "<TAB>" : coc#refresh()', opts )
map( 'i', '<C-space>', 'coc#refresh()', opts );

local opts = { silent = true }
map( 'i', '<Esc>', '<Esc>`^', opts )

map( 'n', '[g', '<Plug>(coc-diagnostic-prev)', opts )
map( 'n', ']g', '<Plug>(coc-diagnostic-next)', opts )
map( 'n', 'gd', '<Plug>(coc-definition)', opts )
map( 'n', 'gy', '<Plug>(coc-type-definition)', opts )
map( 'n', 'gi', '<Plug>(coc-implementation)', opts )
map( 'n', 'gr', '<Plug>(coc-references)', opts )
map( 'n', '<M-r>', '<Plug>(coc-rename)', opts )

map( 'i', '<C-j>', '<Plug>(coc-snippets-expand-jump)', opts );

map( 'n', 'K', '<CMD>lua show_docs()<CR>', opts ) -- View Documentation

map( 'n', ',ff', '<CMD>Telescope find_files<CR>', opts )
map( 'n', ',fg', '<CMD>Telescope live_grep<CR>', opts )
map( 'n', ',fb', '<CMD>Telescope buffers<CR>', opts )
map( 'n', ',fn', '<CMD>Telescope help_tags<CR>', opts )

-- ////////////////////////////////////////////////////////////

vim.api.nvim_create_augroup("CocGroup", {})

vim.api.nvim_create_autocmd("CursorHold", {
    group = "CocGroup",
    command = "silent call CocActionAsync('highlight')",
    desc = "Highlight symbol under cursor on CursorHold"
})

vim.api.nvim_create_autocmd("FileType", {
    group = "CocGroup",
    pattern = "rust,c,json",
    command = "setl formatexpr=CocAction('formatSelected')",
    desc = "Setup formatexpr specified filetype(s)."
})

-- ////////////////////////////////////////////////////////////

local packer_bootstrap = ensure_packer()

return require( 'packer' ).startup( function( use )
	use { 'wbthomason/packer.nvim' } -- Plugin Manager

	use { 'neoclide/coc.nvim',
			branch = 'release'
		}

	use { 'rust-lang/rust.vim' }
	use { 'saecki/crates.nvim',
			tag = 'v0.3.0',
			requires = { 'nvim-lua/plenary.nvim' },
			config = function()
				require( 'crates' ).setup()
			end,
		}

	use { 'jackguo380/vim-lsp-cxx-highlight' }

	use { 'nvim-treesitter/nvim-treesitter',
			config = function()
				local ts_update = require( 'nvim-treesitter.install' ).update( { with_sync = true } )
				ts_update()
			end,
		}

	use { 'L3MON4D3/LuaSnip',
			tag = 'v<CurrentMajor>.*',
		}

	use { 'nvim-tree/nvim-web-devicons',
			config = function() 
				require( 'nvim-web-devicons' ).setup( {
					color_icons = true,
					default = true,
				} )
			end,
		}

	use { 'nvim-tree/nvim-tree.lua', -- File Explorer
			tag = 'nightly',
			requires = { 'nvim-tree/nvim-web-devicons' },
			config = function() 
				require( 'nvim-tree' ).setup()
			end,
		}

	use { 'akinsho/bufferline.nvim', 
			tag = 'v3.*', 
			requires = 'nvim-tree/nvim-web-devicons',
			config = function()
				require('bufferline').setup( {
					options = {
						mode = 'buffers',
						offsets = {
							{filetype = 'NvimTree'}
						},
					}
				} )
			end,
		}
	
	use { 'karb94/neoscroll.nvim',
			config = function()
				require( 'neoscroll' ).setup()
			end,
		}
	
	use { 'nvim-lua/plenary.nvim' }
	use { 'nvim-telescope/telescope.nvim',
			tag = '0.1.0',
			requires = { 'nvim-lua/plenary.nvim' },
		}

	use { 'nvim-lualine/lualine.nvim',
			requires = { 'nvim-tree/nvim-web-devicons', opt = true },
			config = function()
				require( 'lualine' ).setup( {
					options = {
						theme = 'onedark',
						icons_enabled = true,
						section_separators = { left = '', right = '' },
						component_separators = { left = '|', right = '|' },
						disabled_filetypes = { 'packer', 'NvimTree' },
					},
				} )
			end,
		}

	use { 'folke/tokyonight.nvim', -- Theme
			config = function()
				vim.cmd( 'colorscheme tokyonight-night' )
			end,
		}

	if packer_bootstrap then
		require( 'packer' ).sync()
	end
end )


