return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			dim = {
				scope = {
					enabled = true,
					min_size = 2,
					max_size = 20,
					siblings = false,
					debounce = 30,
				},
				animate = {
					enabled = 0,
					easing = "outQuad",
					duration = {
						step = 10,
						total = 200,
					},
				},
				filter = function(buf)
					return vim.g.snacks_dim ~= false and vim.b[buf].snacks_dim ~= false and vim.bo[buf].buftype == ""
				end,
			},
			dashboard = {
				width = 50,
				preset = {
					header = [[
              _     _                                       
             ( \---/ )                                      
              ) . . (                                       
________,--._(___Y___)_,--._______________________________  
        `--'           `--'                                  
          ]],
					-- pick = nil
					keys = {
						{
							icon = " ",
							key = "f",
							desc = "find file",
							action = ":lua Snacks.dashboard.pick('files')",
						},
						{
							icon = " ",
							key = "w",
							desc = "find text",
							action = ":lua Snacks.dashboard.pick('grep_live')",
						},
						{
							icon = " ",
							key = "s",
							desc = "last session",
							section = "session",
						},
						{
							icon = " ",
							key = "r",
							desc = "recent files",
							action = ":Pick files",
						},
						{
							icon = "󰒲 ",
							key = "L",
							desc = "lazy",
							action = ":Lazy",
							enabled = package.loaded.lazy ~= nil,
						},
						{
							icon = " ",
							key = "c",
							desc = "config",
							action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
						},
					},
				},
				sections = {
					{ section = "header" },
					{ section = "keys", gap = 0, padding = 1 },
					{
						title = [[_________________
            ]],
						function()
							sessions = {}
							for s in pairs(MiniSessions.detected) do
								table.insert(sessions, {
									desc = s,
									key = string.sub(s, 1, 1),
									action = function()
										MiniSessions.read(s)
									end,
								})
							end
							return sessions
						end,
						padding = 2,
					},
					{ section = "recent_files", gap = 0, padding = 2 },
					{ section = "startup" },
				},
			},
		},
		init = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				callback = function()
					-- Snacks.dim()
					-- Setup some globals for debugging (lazy-loaded)
					_G.dd = function(...)
						Snacks.debug.inspect(...)
					end
					_G.bt = function()
						Snacks.debug.backtrace()
					end
					vim.print = _G.dd -- Override print to use snacks for `:=` command

					-- Create some toggle mappings
					Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
					Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>tw")
					Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>tL")
					Snacks.toggle.diagnostics():map("<leader>td")
					Snacks.toggle.line_number():map("<leader>tl")
					-- Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
					-- Snacks.toggle.treesitter():map("<leader>uT")
					Snacks.toggle
						.option("cursorline", {
							off = false,
							on = "true",
							name = "Cursorline",
						})
						:map("<leader>tc")
					Snacks.toggle
						.option("background", {
							off = "light",
							on = "dark",
							name = "Dark Background",
						})
						:map("<leader>tb")
					Snacks.toggle.inlay_hints():map("<leader>th")
					Snacks.toggle.indent():map("<leader>tg")
					Snacks.toggle.dim():map("<leader>tD")
					Snacks.toggle.zen():map("<leader>tz")
				end,
			})
		end,
	},
}
