require("helper")
vim.cmd("packadd packer.nvim")

local packer = import("packer")
if packer == nil then
	return
end
_G.__luacache_config = { modpaths = { enable = false } }

local function enable_impatient()
	local impatient = import("impatient")
	if impatient ~= nil then
		impatient.enable_profile()
	else
		vim.notify("impatient is not installed", vim.log.levels.ERROR)
	end
end

enable_impatient()

packer.startup(function(use)
	-- Packer and utilities
	use({ "wbthomason/packer.nvim" })
	use({ "lewis6991/impatient.nvim" }) -- Cache
	use({ "nathom/filetype.nvim" })
	use({
		"echasnovski/mini.nvim",
		config = function()
			require("config.miniconf")
		end,
	})

	-- Icons
	use({ "nvim-tree/nvim-web-devicons" })

	-- Color scheme
	use({ "ellisonleao/gruvbox.nvim" })

	-- LSP and completion
	use({
		"williamboman/mason.nvim",
		config = function()
			require("config.mason")
		end,
	})
	use({ "williamboman/mason-lspconfig.nvim" })
	use({
		"neovim/nvim-lspconfig",
		config = function()
			require("config.lspconfig")
		end,
	})
	use({ "ray-x/lsp_signature.nvim" })
	use({
		"hrsh7th/nvim-cmp",
		config = function()
			require("config.completion")
		end,
	})
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "hrsh7th/cmp-nvim-lsp-document-symbol" })
	use({ "hrsh7th/cmp-nvim-lsp-signature-help" })
	use({ "hrsh7th/cmp-path" })
	use({ "hrsh7th/cmp-buffer" })
	use({ "hrsh7th/cmp-nvim-lua" })
	use({ "hrsh7th/cmp-emoji" })
	use({ "petertriho/cmp-git" })
	use({ "Dosx001/cmp-commit" })
	use({ "hrsh7th/cmp-vsnip" })

	use({ "Shougo/ddc.vim" })
	use({ "vim-denops/denops.vim" })
	use({ "Shougo/pum.vim" })
	use({ "Shougo/ddc-around" })
	use({ "LumaKernel/ddc-file" })
	use({ "Shougo/ddc-nvim-lsp" })
	use({ "Shougo/ddc-matcher_head" })
	use({ "Shougo/ddc-sorter_rank" })
	use({ "Shougo/ddc-converter_remove_overlap" })

	-- UI enhancements
	use({ "onsails/lspkind.nvim" }) -- Icons for completion list
	use({ "glepnir/lspsaga.nvim", requires = { "nvim-tree/nvim-web-devicons", opt = true } })
	use({ "stevearc/dressing.nvim" })
	use({ "j-hui/fidget.nvim" }) -- Rich LSP status display

	-- Language Tools
	use({
		"simrat39/rust-tools.nvim",
		ft = { "rust" },
		config = function()
			require("config.rust-tools")
		end,
	})
	use({ "Saecki/crates.nvim", ft = { "rust" } })
	use({ "David-Kunz/cmp-npm", ft = { "javascript", "typescript", "json" } })
	use({ "vuki656/package-info.nvim", ft = { "javascript", "json" } }) -- package.json

	-- Snippets
	use({ "rafamadriz/friendly-snippets" })
	use({
		"hrsh7th/vim-vsnip",
		config = function()
			require("config.vsnip")
		end,
	})
	use({ "hrsh7th/vim-vsnip-integ" })
	use({ "avneesh0612/react-nextjs-snippets", ft = { "javascript" } })

	-- mini.vim
	use({ "airblade/vim-gitgutter" })
	use({ "t9md/vim-quickhl", event = "CursorHold" }) -- Highlight word under cursor
	use({ "jose-elias-alvarez/null-ls.nvim" })
	use({ "lukas-reineke/lsp-format.nvim" })

	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	})
	-- Debugger
	use({ "mfussenegger/nvim-dap" })

	-- Filer
	use({ "nvim-lua/popup.nvim" })
	use({ "nvim-lua/plenary.nvim" })
	use({ "kkharji/sqlite.lua" })
	use({ "vifm/vifm.vim" })
	use({ "voldikss/vim-floaterm" })
	use({
		"akinsho/toggleterm.nvim",
		tag = "*",
		config = function()
			require("toggleterm").setup()
		end,
	})
end)

local v = import("config.vifm_")
if v == nil then
	return
end
