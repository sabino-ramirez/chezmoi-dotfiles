return {
  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = { 'rafamadriz/friendly-snippets' },

    -- use a release tag to download pre-built binaries
    version = '1.*',
    lazy = true,

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = {
        preset = 'enter',
        ["<tab>"] = { "snippet_forward", 'fallback' },
        ["<S-tab>"] = { "snippet_backward", 'fallback' },

        ["<c-n>"] = { "select_next", 'fallback' },
        ["<c-p>"] = { "select_prev", 'fallback' },
        ["<c-space>"] = { "show", 'show_documentation', "hide_documentation" }
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono'
      },

      -- (Default) Only show the documentation popup when manually triggered
      completion = { documentation = { auto_show = false } },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lsp', 'snippets', 'path', 'buffer', "cmdline", "omni" },
        providers = {
          lsp = {
            name = "LSP",
            module = "blink.cmp.sources.lsp",
            transform_items = function(_, items)
              return vim.tbl_filter(
                function(item) return item.kind ~= require('blink.cmp.types').CompletionItemKind.Text end,
                items
              )
            end,
            max_items = nil,
          },
          snippets = {
            -- For `snippets.preset == 'default'`
            opts = {
              friendly_snippets = true,
              search_paths = { vim.fn.stdpath('config') .. '/snippets' },
              global_snippets = { 'all' },
              extended_filetypes = {},
              ignored_filetypes = {},
              get_filetype = function(context)
                return vim.bo.filetype
              end,
              -- Set to '+' to use the system clipboard, or '"' to use the unnamed register
              clipboard_register = "+",
            }
          },
          path = {
            module = 'blink.cmp.sources.path',
            score_offset = 3,
            fallbacks = { 'buffer' },
            opts = {
              trailing_slash = true,
              label_trailing_slash = true,
              get_cwd = function(context) return vim.fn.expand(('#%d:p:h'):format(context.bufnr)) end,
              show_hidden_files_by_default = false,
            }
          },
          buffer = {
            module = 'blink.cmp.sources.buffer',
            score_offset = -3,
            opts = {
              -- default to all visible buffers
              get_bufnrs = function()
                return vim
                    .iter(vim.api.nvim_list_wins())
                    :map(function(win) return vim.api.nvim_win_get_buf(win) end)
                    :filter(function(buf) return vim.bo[buf].buftype ~= 'nofile' end)
                    :totable()
              end,
            }
          },
          cmdline = {
            module = 'blink.cmp.sources.cmdline',
          },
          omni = {
            module = 'blink.cmp.sources.complete_func',
            enabled = function() return vim.bo.omnifunc ~= 'v:lua.vim.lsp.omnifunc' end,
            ---@type blink.cmp.CompleteFuncOpts
            opts = {
              complete_func = function() return vim.bo.omnifunc end,
            },
          },
        },
      },

      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
  },
}
