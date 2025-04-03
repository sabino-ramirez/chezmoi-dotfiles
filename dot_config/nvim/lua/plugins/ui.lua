return {
	-- treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		main = "nvim-treesitter.configs", -- Sets main module to use for opts
		-- [[ Configure Treesitter ]] See `:help nvim-treesitter`
		opts = {
			ensure_installed = {
				"vim",
				"regex",
				"bash",
				"diff",
				"html",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
			},
			-- Autoinstall languages that are not installed
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = { "ruby" },
			},
			indent = { enable = true, disable = { "ruby" } },
		},
	},

	-- nvim-notify
	-- https://github.com/rcarriga/nvim-notify/blob/d333b6f167900f6d9d42a59005d82919830626bf/doc/nvim-notify.txt#L189
	-- https://github.com/rcarriga/nvim-notify/issues/308
	{
		"rcarriga/nvim-notify",
		opts = {
			timeout = 2000,
			max_width = 50,
			background_colour = nil,
			render = "wrapped-compact",
			top_down = false,
			fps = 60,
		},
	},

	-- noice
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		-- lazy = false,
		opts = {
			hover = {
				silent = false,
			},
			-- you can enable a preset for easier configuration
			presets = {
				bottom_search = false, -- use a classic bottom cmdline for search
				inc_rename = true, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = true, -- add a border to hover docs and signature help
			},
			views = {
				hover = {
					enter = false,
					size = {
						max_width = 40,
						max_height = 50,
					},
					border = {
						-- single, double, rounded, solid, shadow,
						style = "rounded",
						padding == { 2, 5 },
					},
				},
				cmdline_popup = {
					focusable = true,
					size = {
						min_width = 30,
					},
					border = {
						style = "rounded",
						padding = { 1, 2 },
					},
				},
				confirm = {
					focusable = true,
				},
			},
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
	},
}
