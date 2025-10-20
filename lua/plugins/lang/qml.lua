local stats = vim.uv.fs_stat("/usr/lib/qt6/bin/qmlls")
if stats and stats.type == "file" then
  return {}
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "qmljs" } },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      ---@type lspconfig.options
      ---@diagnostic disable-line: missing-fields
      servers = {
        qmlls = {
          enabled = true,
          filetypes_include = {
            "qml",
          },
        },
      },
      setup = {
        qmlls = function(_, opts)
          opts.cmd = { "/usr/lib/qt6/bin/qmlls", "-E" }
          return true
        end,
      },
    },
  },
}
