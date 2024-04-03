return {
  "nvim-telescope/telescope.nvim",
  defaults = {
    ripgrep_arguments = {
      "rg",
      "--hidden",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
  },
}
