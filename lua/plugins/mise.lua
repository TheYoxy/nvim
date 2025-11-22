--- @type LazySpec
return {
  "jmbuhr/otter.nvim",
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter",
      optional = true,
      init = function()
        require("vim.treesitter.query").add_predicate("is-mise?", function(_, _, bufnr, _)
          local filepath = vim.api.nvim_buf_get_name(tonumber(bufnr) or 0)
          local filename = vim.fn.fnamemodify(filepath, ":t")
          return string.match(filename, ".*mise.*%.toml$") ~= nil
        end, { force = true, all = false })
      end,
    },
  },
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
}
