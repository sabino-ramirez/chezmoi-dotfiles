return {
  {
    "sainnhe/gruvbox-material",
    priority = 1000,
    lazy = false,
    config = function()
      vim.opt.background = "dark"

      -- 0, 1, 2
      vim.g.gruvbox_material_transparent_background = 0

      -- material, mix, original
      vim.g.gruvbox_material_foreground = "material"

      -- hard, medium, soft
      vim.g.gruvbox_material_background = "soft"

      -- 0, 1
      vim.g.gruvbox_material_enable_bold = 0

      -- grey, red, orange, yellow, green, aqua, blue
      vim.g.gruvbox_material_menu_selection_background = "aqua"

      -- low, high
      vim.g.gruvbox_material_ui_contrast = "low"

      -- 0, 1
      vim.g.gruvbox_material_diagnostic_text_highlight = 1

      -- none, dimmed
      vim.g.gruvbox_material_inlay_hints_background = "dimmed"

      -- 0, 1
      vim.g.gruvbox_material_enable_italic = true
      vim.g.gruvbox_material_better_performance = 1

      -- set color
      vim.cmd.colorscheme("gruvbox-material")
    end
  },
  {
    "neanias/everforest-nvim",
    version = false,
    -- priority = 1000,
    lazy = true,
    -- priority = 1000, -- make sure to load this before all the other start plugins
    -- Optional; default configuration will be used if setup isn't called.
    config = function()
      -- require("everforest").setup({
      --   -- Your config here
      -- })
      -- vim.cmd.colorscheme("everforest")
    end,
  }
}
