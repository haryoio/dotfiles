vim.cmd("packadd packer.nvim")

local status, packer = pcall(require, "packer")
if not status then
  print("Packer is not installed")
  return
end
_G.__luacache_config = { modpaths = { enable = false } }

-- impatient.nvimが読み込める場合のみ最適化する
local ok, impatient = pcall(require, "impatient")
if ok then
  impatient.enable_profile()
else
  vim.notify(ok, vim.log.levels.ERROR)
end

packer.startup(function(use)
  use({ "wbthomason/packer.nvim" })

  use({ "lewis6991/impatient.nvim", })     -- キャッシュ
  use({ "nathom/filetype.nvim" })
  use({ "nvim-tree/nvim-web-devicons" })   -- アイコンをかっこよく

  -- Color scheme
  use({ "ellisonleao/gruvbox.nvim" })

  -- Splash Page
  use({
    "goolord/alpha-nvim",
    requires = { "nvim-tree/nvim-web-devicons" },
  })

  -- LSP and completion
  use({
    "williamboman/mason.nvim",
    config = function() require("config.mason") end,
  })
  use({ "williamboman/mason-lspconfig.nvim", })
  use({
    "neovim/nvim-lspconfig",
    config = function()
      require("config.lspconfig")
    end,
  })
  use({ "ray-x/lsp_signature.nvim" })   --
  use({
    "hrsh7th/nvim-cmp",
    config = function()
      require("config.completion")
    end,
  })                                -- cmp engine
  use({ "hrsh7th/cmp-nvim-lsp" })   -- cmp lsp source
  use({ "hrsh7th/cmp-nvim-lsp-document-symbol" })
  use(


    {
      "hrsh7th/cmp-nvim-lsp-signature-help",
      requires = { "ray-x/lsp_signature.nvim" },
    })                              -- cmp lsp sigunature help source
  use({ "hrsh7th/cmp-path" })       -- cmp path source
  use({ "hrsh7th/cmp-buffer" })     -- cmp buffer source
  use({ "hrsh7th/cmp-nvim-lua" })   -- cmp nvim lua source
  use({ "hrsh7th/cmp-emoji" })      -- cmp emoji source
  use({ "petertriho/cmp-git" })     -- cmp git source
  use({ "Dosx001/cmp-commit" })     -- cmp commit source
  --	use({ "tzachar/cmp-tabnine", run = "./install.sh" }) -- cmp tabnine source
  --	use({ "codota/tabnine-nvim", run = "./dl_binaries.sh" })
  ---	use({ "hrsh7th/cmp-copilot" })
  use({ "saadparwaiz1/cmp_luasnip", opt = true, requires = { "L3MON4D3/LuaSnip" } })   -- cmp luasnip source
  use({ "ray-x/cmp-treesitter", requires = { "nvim-treesitter/nvim-treesitter" } })    -- cmp treesitter source
  use({ "hrsh7th/cmp-cmdline" })                                                       -- cmp commandline source

  use({ "onsails/lspkind.nvim" })                                                      -- 補間一覧にアイコン表示
  -- LSP style
  use({ "glepnir/lspsaga.nvim", requires = { "nvim-tree/nvim-web-devicons", opt = true } })
  use({ "stevearc/dressing.nvim" })
  use({ "j-hui/fidget.nvim" })   -- LSPの状態をリッチに表示する

  -- Language Tools
  use({
    "simrat39/rust-tools.nvim",
    ft = { "rust" },
    config = function()
      require("config.rust-tools")
    end,
  })
  --	use({ "prabirshrestha/asynccomplete.vim" })
  --	use({ "prabirshrestha/asynccomplete-lsp.vim" })
  use({ "Saecki/crates.nvim", ft = { "rust" } })
  use({ "David-Kunz/cmp-npm", ft = { "javascript", "typescript", "json" } })
  use({ "vuki656/package-info.nvim", ft = { "javascript", "json" } })   -- package.json
  use({ "dhruvasagar/vim-table-mode", ft = { "markdown" } })
  -- UI
  use({
    "folke/trouble.nvim",
    requires = { "nvim-tree/nvim-web-devicons", opt = true },
    config = function()
      require("config.trouble")
    end,
  })                            -- 定義ジャンプなどを便利にするUIなどを提供
  --Snippet
  use({ "L3MON4D3/LuaSnip" })   -- show snnipet
  use({ "rafamadriz/friendly-snippets" })
  use({ "avneesh0612/react-nextjs-snippets", ft = { "javascript" } })
  --session
  use({
    "rmagatti/auto-session",
    config = function()
      require("auto-session").setup({
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
      })
    end,
  })

  --Syntaxhighlight
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("config.treesitter")
    end,
  })
  use({ "windwp/nvim-ts-autotag", requires = { "nvim-treesitter/nvim-treesitter" } })
  --	use({ "yioneko/nvim-yati", requires = { "nvim-treesitter/nvim-treesitter" } })
  use({ "nvim-treesitter/nvim-treesitter-context" })   -- 長い関数などを上部に表示
  --use({ "JoosepAlviste/nvim-ts-context-commentstring" }) -- commentstringをいい感じに設定
  use({
    "terrortylor/nvim-comment",
    config = function()
      require("nvim_comment").setup({
        comment_empty_trim_whitespace = false,
      })
    end,
  })
  use({ "airblade/vim-gitgutter" })
  --	use({ "m-demare/hlargs.nvim" }) -- 引数の変数だけ色を変える

  --Highlight
  use({ "RRethy/vim-illuminate", event = "CursorHold" })   -- カーソル下の単語をハイライト
  use({ "t9md/vim-quickhl", event = "CursorHold" })        -- カーソル下の単語に色を付ける
  --	use({ "folke/todo-comments.nvim" }) -- todoなどを読みやすくする

  use({
    "windwp/nvim-autopairs",
    config = function()
      require("config.autopairs")
    end,
  })
  use({
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  })
  --Lualine
  use({
    "nvim-lualine/lualine.nvim",
    event = { "InsertEnter", "CursorHold", "FocusLost", "BufRead", "BufNewFile" },
    requires = { "kyazdani42/nvim-web-devicons", module = { "nvim-web-devicons" } },
    config = function()
      require("config.lualine")
    end,
  })
  -- Tab Management
  use({
    "romgrk/barbar.nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("config.barbar")
    end,
  })

  --Formatter
  use({ "gpanders/editorconfig.nvim" })
  --Linter
  use({
    "jose-elias-alvarez/null-ls.nvim",
    requires = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require("config.null_ls")
    end,
  })

  use "lukas-reineke/lsp-format.nvim"

  --GGGit
  use({
    "lewis6991/gitsigns.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("gitsigns").setup()
    end,
  })
  --Debugger
  use({ "mfussenegger/nvim-dap" })
  --use({ "theHamsta/nvim-dap-virtual-text" })
  use({ "nvim-telescope/telescope-dap.nvim" })

  --Filer
  use({
    "lambdalisue/fern.vim",
    config = function()
      require("config.fern")
    end,
  })
  use({ "lambdalisue/nerdfont.vim" })   --fern icons
  use({ "lambdalisue/fern-git-status.vim" })
  use({
    "lambdalisue/fern-renderer-nerdfont.vim",
    requires = { "lambdalisue/fern.vim", "lambdalisue/nerdfont.vim" },
  })
  use({
    "lambdalisue/fern-hijack.vim",
    requires = { "lambdalisue/fern.vim" },
  })

  --FizzyFinder
  use({
    "nvim-telescope/telescope.nvim",
    -- ref: https://qiita.com/delphinus/items/fb905e452b2de72f1a0f
    requires = {
      { "nvim-lua/popup.nvim" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-file-browser.nvim", module = "telescope._extensions.file_browser" },
      { "nvim-telescope/telescope-packer.nvim",       module = "telescope._extensions.packer" },
      { "nvim-telescope/telescope-ui-select.nvim",    module = "telescope._extensions.ui-select" },
      { "nvim-telescope/telescope-frecency.nvim",     module = "telescope._extensions.frecency" },
    },
    config = function()
      require("config.telescope")
    end,
  })

  use({
    "akinsho/toggleterm.nvim",
    tag = '*',
    config = function()
      require("toggleterm").setup()
    end
  })

  use({ "nvim-lua/popup.nvim" })
  use({ "nvim-lua/plenary.nvim" })
  use({ "nvim-telescope/telescope-file-browser.nvim" })
  use({ "nvim-telescope/telescope-packer.nvim" })
  use({ "nvim-telescope/telescope-ui-select.nvim" })
  use({ "nvim-telescope/telescope-frecency.nvim" })
  -- -SQLite
  use({ "kkharji/sqlite.lua" })
end)

local telescope_extensions = {
  "frecency",
  "file_browser",
  "packer",
  "ui-select",
}

for _, extension in ipairs(telescope_extensions) do
  require("telescope").load_extension(extension)
end

require("luasnip.loaders.from_vscode").lazy_load()
