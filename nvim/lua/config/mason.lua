local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local nvim_lsp = require("lspconfig")

mason.setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})
mason_lspconfig.setup({})
-- built-in LSP function
mason_lspconfig.setup_handlers({
  function(server_name)
    local node_root_dir = nvim_lsp.util.root_pattern("package.json")
    local is_node_repo = node_root_dir(vim.api.nvim_buf_get_name(0)) ~= nil

    local opts = {}

    if server_name == "tsserver" then
      if not is_node_repo then
        return
      end
      vim.bo.shiftwidth = 2

      opts.root_dir = node_root_dir
    elseif server_name == "eslint" then
      if not is_node_repo then
        return
      end
      vim.bo.shiftwidth = 2

      opts.root_dir = node_root_dir
    elseif server_name == "denols" then
      if is_node_repo then
        return
      end
      vim.bo.shiftwidth = 2

      opts.root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc", "deps.ts", "import_map.json")
      opts.init_options = {
        lint = true,
        unstable = true,
        suggest = {
          imports = {
            hosts = {
                  ["https://deno.land"] = true,
                  ["https://cdn.nest.land"] = true,
                  ["https://crux.land"] = true,
                  ["npm:"] = true,
            },
          },
        },
      }
    else
      opts.tab_width = function() return vim.opt.shiftwidth:get() end
    end

    opts.on_attach = function(client) require("lsp-format").on_attach(client) end
    -- format on save
    nvim_lsp[server_name].setup(opts)
  end,
})

local prettier = {
  formatCommand = [[prettier --stdin-filepath ${INPUT} ${--tab-width:tab_width}]],
  formatStdin = true,
}
require("lspconfig").efm.setup({
  on_attach = require("lsp-format").on_attach,
  init_options = { documentFormatting = true },
  settings = {
    languages = {
      typescript = { prettier },
      --typescript = { prettier },
      yaml = { prettier },
    },
  },
})


require 'lspconfig'.lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
    },
  },
})
