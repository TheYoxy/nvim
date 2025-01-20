if vim.g.vscode then return {} end -- NOTE: don't do anything in vscode instances
---@type LazySpec
return {
  "nvim-telescope/telescope.nvim",
  opts = {
    defaults = {
      file_ignore_patterns = { ".git/", "node_modules/", "bin/", "obj/" },
      vimgrep_arguments = {
        "rg",
        "--hidden",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--trim",
      },
    },
    pickers = {
      find_files = {
        hidden = true,
      },
    },
  },
  dependencies = {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          ["<Tab>"] = {
            function()
              if #vim.t.bufs > 1 then
                require("telescope.builtin").buffers { sort_mru = true, ignore_current_buffer = true }
              else
                vim.notify "No other buffers open"
              end
            end,
            desc = "Switch Buffers",
          },
          ["<Leader>e"] = { function() vim.notify "This keymap is replaced by [<Leader>fe]" end, desc = "Find history" },
          ["<Leader>fe"] = {
            function() require("telescope.builtin").oldfiles { only_cwd = true } end,
            desc = "Find history",
          },
          ["<Leader>fE"] = {
            function() require("telescope.builtin").oldfiles {} end,
            desc = "Find all history",
          },
          ["<Leader>w"] = { desc = " Diagnostics" },
          ["<Leader>wx"] = {
            function() require("telescope.builtin").diagnostics { bufnr = 0 } end,
            desc = "Show diagnostics (Current buffer)",
          },
          ["<Leader>wX"] = {
            function() require("telescope.builtin").diagnostics { bufnr = nil } end,
            desc = "Show diagnostics (Workspace)",
          },
          ["[x"] = { function() vim.diagnostic.goto_next() end, desc = "Next diagnostic" },
          ["]x"] = { function() vim.diagnostic.goto_prev() end, desc = "Previous diagnostic" },
        },
      },
    },
  },
}
