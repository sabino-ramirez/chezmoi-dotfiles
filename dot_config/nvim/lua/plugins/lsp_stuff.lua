return {
	-- mason
	{
		"williamboman/mason.nvim",
		lazy = true,
		cmd = { "Mason", "MasonInstall", "MasonUpdate" },
		opts = {
			PATH = "skip",

			ui = {
				icons = {
					package_pending = " ",
					package_installed = " ",
					package_uninstalled = " ",
				},
			},

			max_concurrent_installers = 10,
		},
	},

	{
		"williamboman/mason-lspconfig.nvim",
		lazy = true,
		opts = {
			ensure_installed = {
				"lua_ls",
			},
			automatic_installation = true,
		},
	},

	-- lspconfig
	{
		"neovim/nvim-lspconfig",
		-- event = "User FilePost",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"saghen/blink.cmp",
		},
		config = function()
			require("config.lsp.lsp_servers")
		end,
	},

	-- conform (formatter)
	{
		"stevearc/conform.nvim",
		lazy = true,
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		-- keys = {
		-- 	{
		-- 		-- Customize or remove this keymap to your liking
		-- 		"<leader>fm",
		-- 		function()
		-- 			require("conform").format({ async = true })
		-- 		end,
		-- 		mode = "",
		-- 		desc = "Format buffer",
		-- 	},
		-- },

		-- This will provide type hinting with LuaLS
		---@module "conform"
		---@type conform.setupOpts
		opts = {
			-- Define your formatters
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_format", "ruff_organize_imports" },
				go = { "gofumpt" },
				javascript = { "biome", "biome-organize-imports", stop_after_first = false },
				typescript = { "biome", "biome-organize-imports", stop_after_first = false },
			},

			-- Set default options
			default_format_opts = {
				lsp_format = "fallback",
			},
		},
		init = function()
			-- If you want the formatexpr, here is the place to set it
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
	},
}
