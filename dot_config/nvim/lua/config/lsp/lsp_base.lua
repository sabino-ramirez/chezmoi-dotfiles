local M = {}
local map = vim.keymap.set

M.on_attach = function(client, bufnr, opts)
  opts = opts or {}
  local disable_formatting = opts.disable_formatting == true
  local function buffer_opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end

  -- enable inlay hints
  if client.server_capabilities.inlayHintProvider then
    vim.lsp.inlay_hint.enable(true)
  end

  -- disable_formatting
  if disable_formatting then
    -- turn off client formatting capabilities
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
    client.capabilities.textDocument.formatting.dynamicRegistration = false
  end

  -- standard keybinds
  map("n", "K", vim.lsp.buf.hover, buffer_opts("hover"))
  map("n", "gd", vim.lsp.buf.definition, buffer_opts("goto def"))
  map("n", "<leader>D", vim.lsp.buf.type_definition, buffer_opts("goto type def"))
  map("n", "<leader>ra", vim.lsp.buf.rename, buffer_opts("rename"))

  map("n", "<leader>fm", function()
    require("conform").format { lsp_fallback = true }
  end, { desc = "general format file" })

  -- map("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", buffer_opts("goto def"))
  map("n", "<leader>lf", vim.diagnostic.open_float, buffer_opts("diagnostics float"))

  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, buffer_opts("code actions"))
end

-- use blink with lspconfig
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}
-- M.capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
M.capabilities = vim.tbl_deep_extend(
  'force',
  capabilities,
  require('blink.cmp').get_lsp_capabilities({}, false)
)

-- disable semanticTokens
M.on_init = function(client, _)
  if client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

M.lua_neovim_oninit = function(client)
  if client.workspace_folders then
    local path = client.workspace_folders[1].name
    if path ~= vim.fn.stdpath('config') and (vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc')) then
      return
    end
  end
  client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
    runtime = {
      -- Tell the language server which version of Lua you're using
      -- (most likely LuaJIT in the case of Neovim)
      version = 'LuaJIT'
    },

    -- Make the server aware of Neovim runtime files
    workspace = {
      checkThirdParty = false,
      library = {
        vim.env.VIMRUNTIME
        -- Depending on the usage, you might want to add additional paths here.
        -- "${3rd}/luv/library"
        -- "${3rd}/busted/library",
      }
      -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
      -- library = vim.api.nvim_get_runtime_file("", true)
    }
  })
end


return M
