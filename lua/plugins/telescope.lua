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
          ["<Leader>fe"] = {
            function() require("telescope.builtin").oldfiles { only_cwd = true } end,
            desc = "Find history",
          },
          ["<Leader>fs"] = {
            function()
              if require("astrocore").is_available "aerial.nvim" then
                require("telescope").extensions.aerial.aerial()
              else
                require("telescope.builtin").lsp_dynamic_workspace_symbols()
              end
            end,
            desc = "Find workspace symbols",
          },
          ["<Leader>fE"] = {
            function() require("telescope.builtin").oldfiles {} end,
            desc = "Find all history",
          },
          ["<Leader>ls"] = {
            function()
              require("telescope.builtin").lsp_workspace_symbols {
                fname_width = 20,
                symbol_width = 35,
              }
            end,
            desc = "Search workspace symbols",
          },
          -- ["<Leader>w"] = { desc = " Diagnostics" },
          -- ["<Leader>wx"] = {
          --   function() require("telescope.builtin").diagnostics { bufnr = 0 } end,
          --   desc = "Show diagnostics (Current buffer)",
          -- },
          -- ["<Leader>wX"] = {
          --   function() require("telescope.builtin").diagnostics { bufnr = nil } end,
          --   desc = "Show diagnostics (Workspace)",
          -- },
          -- ["[x"] = { function() vim.diagnostic.goto_next() end, desc = "Next diagnostic" },
          -- ["]x"] = { function() vim.diagnostic.goto_prev() end, desc = "Previous diagnostic" },
        },
      },
    },
  },
}
