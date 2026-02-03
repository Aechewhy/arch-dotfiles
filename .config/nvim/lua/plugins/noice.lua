return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    -- add any options here
    presets = {
      bottom_search = true, -- Keep / search at the bottom (better context)
      command_palette = true, -- Force : command line to be a centered popup
      long_message_to_split = true, -- Good to have: long messages go to a split
    },
    views = {
      cmdline_popup = {
        position = {
          row = "30%", -- CHANGED: This puts it in the vertical center
          col = "50%",
        },
        size = {
          width = 60,
          height = "auto",
        },
      },
      popupmenu = {
        relative = "editor",
        position = {
          row = 8, -- You might want to adjust this if the menu feels too high/low relative to the box
          col = "50%",
        },
        size = {
          width = 60,
          height = 10,
        },
        border = {
          style = "rounded",
          padding = { 0, 1 },
        },
        win_options = {
          winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
        },
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
}
