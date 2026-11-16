--- @type LazySpec
return {
  -- add some stuff to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    ---@module "nvim-treesitter"
    ---@param opts TSConfig
    opts = function(_, opts)
      -- coda is not in nvim-treesitter's parser list, so register it by hand.
      -- TSUpdate reloads the parser table, hence the autocmd re-registering it.
      ---@type ParserInfo
      local config = {
        install_info = {
          url = "https://github.com/TheYoxy/tree-sitter-coda",
          branch = "master",
          queries = "queries/coda",
        },
        tier = 2,
      }

      require("nvim-treesitter.parsers").coda = config
      vim.api.nvim_create_autocmd("User", {
        pattern = "TSUpdate",
        callback = function()
          require("nvim-treesitter.parsers").coda = config
        end,
      })

      table.insert(opts.ensure_installed, "coda")
    end,
  },
}
