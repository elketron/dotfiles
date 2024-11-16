return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  tag = "0.1.8",
  opts = {
    defaults = {
      borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    },
    file_ignore_patterns = { "node_modules", "bin", "obj", "%__virtual.cs$" },
  },
}
