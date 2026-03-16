return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  -- Using the shell script directly avoids the "Unknown function" error
  build = "sh -c 'cd app && ./install.sh'",
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
    vim.g.mkdp_preview_options = {
      -- This is the "Obsidian" switch:
      mkit = {
        breaks = true, -- This turns single line breaks into <br>
      },
    }
  end,
}
