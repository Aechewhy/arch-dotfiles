return {
  "nvim-mini/mini.nvim",
  config = function()
    -- 1. Enable Surround
    require("mini.surround").setup({
      -- 2. Remap keys to avoid conflict with Flash (s)
      mappings = {
        add = "gsa", -- Add surrounding in Normal and Visual modes
        delete = "gsd", -- Delete surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        replace = "gsr", -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
      },
    })
  end,
}
