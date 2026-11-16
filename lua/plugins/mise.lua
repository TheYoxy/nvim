local is_mise_file = require("config.mise")

--- @type LazySpec
return {
  {
    "jmbuhr/otter.nvim",
    config = function()
      vim.api.nvim_create_autocmd({ "FileType" }, {
        pattern = { "toml" },
        group = vim.api.nvim_create_augroup("EmbedToml", {}),
        callback = function()
          require("otter").activate()
        end,
      })
    end,
    opts = {
      lsp = {
        -- `:h events` that cause the diagnostics to update. Set to:
        -- { "BufWritePost", "InsertLeave", "TextChanged" } for less performant
        -- but more instant diagnostic updates
        diagnostic_update_events = { "BufWritePost" },
        -- function to find the root dir where the otter-ls is started
        root_dir = function(_, bufnr)
          return vim.fs.root(bufnr or 0, {
            ".git",
            ".obsidian",
            "_quarto.yml",
            "package.json",
          }) or vim.fn.getcwd(0)
        end,
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- nvim-lspconfig ships the `mise` config (cmd/filetypes); only the root
        -- is overridden so the client starts for mise files alone.
        mise = {
          root_dir = function(bufnr, on_dir)
            if is_mise_file(bufnr) then
              on_dir(vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr)))
            end
          end,
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    init = function()
      require("vim.treesitter.query").add_predicate("is-mise?", function(_, _, bufnr, _)
        return is_mise_file(bufnr)
      end, { force = true, all = false })
    end,
  },
}
