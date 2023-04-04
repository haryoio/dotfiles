-- safe import mason-core
local pstatus, mason_package = pcall(require, "mason-core.packagge")
if not pstatus then
  return
end
-- safe import mason-registory
local rstatus, mason_registry = pcall(require, "mason-registry")
if not rstatus then
  return
end
-- safe import null_ls
local nstatus, null_ls = pcall(require, "null-ls")
if not nstatus then
  return
end

-- mason-registory
local null_sources = {}

for _, package in ipairs(mason_registry.get_installed_packages()) do
  local package_categories = package.spec.categories[1]
  if package_categories == mason_package.Cat.Formatter then
    table.insert(null_sources, null_ls.builtins.formatting[package.name])
  end
  if package_categories == mason_package.Cat.Linter then
    table.insert(null_sources, null_ls.builtins.diagnostics[package.name])
  end
end

local bf = null_ls.builtins.formatting
local bl = null_ls.builtins.linter
local bd = null_ls.builtins.diagnostics
local sources = {
  bf.eslint.with({ prefer_local = "node_modules/.bin" }),
  bd.eslint.with({ prefer_local = "node_modules/.bin" }),
  bl.eslint.with({ prefer_local = "node_modules/.bin" }),
  bf.deno,
  bd.deno,
  bl.deno,
  bf.efm,
  bd.efm,
  bl.efm,
  bl.prettierd,
  bd.prettierd,
  bf.prettierd,
  bf.stylua,
  bl.stylua,
  bd.stylua,
  bf.gofmt,
}

for i in ipairs(sources) do
  table.insert(null_sources, i)
end

null_ls.setup({
  diagnostics_format = "#{m} (#{s}: #{c})",
  sources = null_sources,
})
