--- @type LazySpec
return {
  -- add some stuff to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    ---@param opts TSConfig
    opts = function(_, opts)
      local function add(lang)
        if type(opts.ensure_installed) == "table" then
          table.insert(opts.ensure_installed, lang)
        end
      end

      local parser_config = require("nvim-treesitter.parsers")

      ---@type ParserInfo
      local config = {
        install_info = {
          url = "https://github.com/theyoxy/tree-sitter-coda",
          revision = "master",
          files = { "src/parser.c" },
          -- development mode
          -- url = vim.env.HOME .. "/dev/tree-sitter-coda",
          -- generate_requires_npm = true,
          -- requires_generate_from_grammar = true,
        },
        filetype = "coda",
        tier = 1,
      }
      parser_config.coda = config
      add("coda")

      -- vim.opt.rtp:append(vim.env.HOME .. "/dev/tree-sitter-coda")
    end,
  },
}
