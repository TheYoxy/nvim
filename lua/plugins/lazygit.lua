if vim.g.vscode then return {} end -- NOTE: don't do anything in vscode instances

---@type LazySpec
return {
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
      {
        "AstroNvim/astrocore",
        ---@type AstroCoreOpts
        opts = {
          mappings = {
            n = {
              ["<Leader>gg"] = { function() require("lazygit").lazygit() end, desc = "Open lazygit" },
            },
          },
        },
      },
    },
    event = "BufRead",
    config = function() require("telescope").load_extension "lazygit" end,
  },
}
