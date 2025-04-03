local opts = { noremap = true, silent = true }

local map = vim.keymap.set

-- Disable the spacebar key's default behavior in Normal and Visual modes
map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- saving/exiting
map("n", "<leader>w", "<cmd>noautocmd w <cr>")
map("n", "<leader><tab>", "<cmd> wq <cr>")
map("n", "<leader>q", "<cmd> q <cr>")
map("n", "<leader>Q", "<cmd> q! <cr>")
map("n", "<leader>x", "<cmd> bd <cr>")

-- buffer movement
map("n", "<Tab>", "<cmd>bnext<CR>")
map("n", "<S-Tab>", "<cmd>bNext<CR>")

-- Comment
map("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })

-- clear highlights
map("n", "<Esc>", ":noh<CR>", opts)

-- delete single character without copying into register
map("n", "x", '"_x', opts)

-- Find and center
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Stay in indent mode
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Move text up and down
map("v", "<A-j>", ":m .+1<CR>==", opts)
map("v", "<A-k>", ":m .-2<CR>==", opts)

-- Keep last yanked when pasting
map("v", "p", '"_dP', opts)

-- Replace word under cursor
map("n", "<leader>j", "*``cgn", opts)

-- Explicitly yank to system clipboard (highlighted and entire row)
map({ "n", "v" }, "<leader>y", [["+y]])
map("n", "<leader>Y", [["+Y]])

-- -- Diagnostic keymaps
-- map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
-- map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
-- map('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
-- map('n', '<leader>dl', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Save and load session
-- map('n', '<leader>ss', ':mksession! .session.vim<CR>', { noremap = true, silent = false })
-- map('n', '<leader>sl', ':source .session.vim<CR>', { noremap = true, silent = false })
