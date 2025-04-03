local lspconfig = require("lspconfig")
local base = require("config.lsp.lsp_base")

-- lua
lspconfig.lua_ls.setup({
	on_attach = base.on_attach,
	capabilities = base.capabilities,
	on_init = base.lua_neovim_oninit,

	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

-- typescript
lspconfig.ts_ls.setup({
	on_attach = function(client, bufnr)
		base.on_attach(client, bufnr, { disable_formatting = true })
	end,
	capabilities = base.capabilities,

	settings = {
		typescript = {
			inlayHints = {
				-- includeInlayEnumMemberValueHints = true,
				-- includeInlayFunctionLikeReturnTypeHints = true,
				-- includeInlayFunctionParameterTypeHints = true,
				-- includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
				-- includeInlayParameterNameHintsWhenArgumentMatchesName = true,
				-- includeInlayPropertyDeclarationTypeHints = true,
				-- includeInlayVariableTypeHints = true,
			},
		},
	},
})

-- biome
lspconfig.biome.setup({
	cmd = { "bunx", "biome", "lsp-proxy" },
	-- on_attach = base.on_attach,
	-- on_init = base.on_init,

	capabilities = vim.lsp.protocol.make_client_capabilities(),
})
