return {
	"echasnovski/mini.nvim",
	version = false,
	lazy = true,
	init = function()
		require("mini.files").setup({
			mappings = { close = "q" },
			windows = { max_number = 5, width_focus = 30, width_nofocus = 20 },
		})

		-- cursorword
		require("mini.cursorword").setup()

		-- tabline
		require("mini.tabline").setup({
			format = nil,
			set_vim_settings = true,
			tabpage_section = "left",
		})

		-- status line
		require("mini.statusline").setup({
			content = {
				active = nil,
				inactive = nil,
			},
			use_icons = true,
			set_vim_settings = true,
		})

		-- -- comments
		-- require("mini.comment").setup({
		--     ignore_blank_line = true,
		--     start_of_line = true,
		-- 	-- mappings = {
		-- 	-- 	comment = "<leader>/",
		-- 	-- 	comment_line = "<leader>/",
		-- 	-- 	comment_visual = "<leader>/",
		-- 	-- 	textobject = "<leader>/",
		-- 	-- },
		-- })

		-- pairs
		require("mini.pairs").setup()

		-- pairs
		require("mini.operators").setup()

		-- split join
		require("mini.splitjoin").setup()

		-- surround
		require("mini.surround").setup({
			-- Module mappings. Use `""` (empty string) to disable one.
			mappings = {
				add = "sa", -- Add surrounding in Normal and Visual modes
				delete = "sd", -- Delete surrounding
				find = "sf", -- Find surrounding (to the right)
				find_left = "sF", -- Find surrounding (to the left)
				highlight = "sh", -- Highlight surrounding
				replace = "sr", -- Replace surrounding
				update_n_lines = "sn", -- Update `n_lines`

				suffix_last = "l", -- Suffix to search with "prev" method
				suffix_next = "n", -- Suffix to search with "next" method
			},
		})

		-- a/i
		require("mini.ai").setup()

		-- move
		require("mini.move").setup()

		-- icons
		require("mini.icons").setup()

		-- picker
		require("mini.pick").setup({
			content_from_bottom = false,
			use_cache = true,
		})

		-- -- dashboard
		-- local starter = require("mini.starter")
		-- starter.setup({
		-- 	items = {
		-- 		-- Use this if you set up 'mini.sessions'
		-- 		starter.sections.sessions(3, true),
		-- 		-- (amount, in_curr_dir, show_path)
		-- 		starter.sections.recent_files(5, true, false),
		-- 		starter.sections.recent_files(3, false, true),
		-- 		starter.sections.pick(),
		-- 	},
		-- 	content_hooks = {
		-- 		-- starter.gen_hook.adding_bullet("* ", true),
		-- 		starter.gen_hook.indexing("all", { "Builtin actions", "Pick", "Sessions", "Recent files" }),
		-- 		starter.gen_hook.padding(3, 2),
		-- 	},
		-- })

		-- extras
		require("mini.extra").setup()

		-- vim.cmd("colorscheme minicyan")
		-- vim.cmd('colorscheme minischeme')
		-- vim.cmd('colorscheme randomhue')

		vim.cmd([[
      highlight LineNr guifg=#004c4c
      highlight LineNr guibg=none
      highlight LineNr ctermbg=none
      " highlight Normal guibg=none
      " highlight Normal ctermbg=none
      " highlight NonText guibg=none
      " highlight NonText ctermbg=none
      " highlight SignColumn guibg=NONE
      " highlight SignColumn ctermbg=NONE
    ]])
	end,
}
