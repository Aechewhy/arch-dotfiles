return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8", -- It is safer to pin to a specific version like 0.1.8
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      -- 1. Load the plugin ONLY after it's installed
      local builtin = require("telescope.builtin")

      -- 2. Set up your keymaps inside the config function
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
    end,
  },
}
