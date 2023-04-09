local cmp = require("cmp")
local luasnip = require("luasnip")
luasnip.setup({ region_check_events = "InsertEnter", delete_check_events = "InsertEnter" })
require("luasnip.loaders.from_vscode").lazy_load()

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
	completion = { completeopt = "menu,menuone,noinsert" },
	sorting = {
		comparators = {
			-- The built-in comparators:
			cmp.config.compare.offset,
			cmp.config.compare.exact,
			cmp.config.compare.score,
			--require('cmp-under-comparator').under,
			cmp.config.compare.kind,

			cmp.config.compare.sort_text,
			cmp.config.compare.length,
			cmp.config.compare.order,
		},
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	window = {
		completion = {
			winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
			col_offset = -3,
			side_padding = 0,
		},
	},
	formatting = {
		fields = { "abbr", "menu", "kind" },
		format = require("lspkind").cmp_format({
			mode = "symbol_text",
			maxwidth = 50,
			ellipsis_char = "...",
			before = function(entry, vim_item)
				vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
				vim_item.abbr = "  " .. vim_item.abbr .. " "
				if entry.source.name == "cmp_tabnine" then
					local detail = (entry.completion_item.data or {}).detail
					vim_item.kind = ""
					if detail and detail:find(".*%%.*") then
						vim_item.kind = vim_item.kind .. " " .. detail
					end

					if (entry.completion_item.data or {}).multiline then
						vim_item.kind = vim_item.kind .. " " .. "[ML]"
					end
				end
				local maxwidth = 80
				vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)
				return vim_item
			end,
		}),
	},
	mapping = {
		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-y>"] = cmp.config.disable,
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		["<CR>"] = cmp.mapping.confirm({
			select = true,
			behavior = cmp.ConfirmBehavior.Replace,
		}),
		["<tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<s-tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	},
	sources = {
		{ name = "nvim_lsp_signature_help" },
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "nvim_lua" },
		{ name = "path" },
		{ name = "buffer" },
		{ name = "cmp_tabnine" },
		{ name = "commint" },
		{ name = "git" },
		--{ name = "copilot" },
		{ name = "treesitter" },
		{ name = "npm" },
		{ name = "crates" },
	},
})

cmp.setup.cmdline("/", {
	sources = cmp.config.sources({
		{ name = "nvim_lsp_document_symbol" },
	}, {
		{ name = "buffer" },
	}),
})

cmp.setup.cmdline(":", {
	sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
})
