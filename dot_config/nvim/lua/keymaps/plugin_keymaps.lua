local opts = { noremap = true, silent = true }
local map = vim.keymap.set

-- miniFiles
map("n", "<leader>e", function()
	-- local path = vim.bo.buftype ~= "nofile" and vim.api.nvim_buf_get_name(0) or nil
	MiniFiles.open(vim.bo.buftype ~= "nofile" and vim.api.nvim_buf_get_name(0) or nil, false)
end, { desc = "Open MiniFiles" })

-- mini sessions
local sessions = require("mini.sessions")
sessions.setup()
vim.keymap.set("n", "<leader>sw", function()
	local session_name = vim.fn.input("enter session to write")
	sessions.write(session_name)
end)

vim.keymap.set("n", "<leader>sd", function()
	local sess_name = vim.fn.input("enter session to delete")
	sessions.delete(sess_name)
end)

vim.keymap.set("n", "<leader>ss", function()
	sessions.select()
end)

-- MiniPick
map("n", "<leader>pr", "<cmd>Pick oldfiles<cr>", opts)
map("n", "<leader>pd", "<cmd>Pick diagnostic<cr>", opts)
map("n", "<leader>pf", "<cmd>Pick files<cr>", opts)
map("n", "<leader>pb", "<cmd>Pick buffers<cr>", opts)
map("n", "<leader>pw", "<cmd>Pick grep_live<cr>", opts)
map("n", "<leader>ph", "<cmd>Pick help<cr>", opts)
map("n", "<leader>pk", "<cmd>Pick keymaps<cr>", opts)
map("n", "<leader>ps", "<cmd>Pick marks<cr>", opts)
map("n", "<leader>po", "<cmd>Pick options<cr>", opts)
-- lsp pickers
map("n", "<leader>lr", "<cmd>Pick lsp scope='references'<cr>", opts)
map("n", "<leader>li", "<cmd>Pick lsp scope='implementation'<cr>", opts)
map("n", "<leader>ls", "<cmd>Pick lsp scope='document_symbol'<cr>", opts)
