if vim.g.vscode then return {} end -- NOTE: don't do anything in vscode instances

---@type LazySpec
return {
  "xiyaowong/transparent.nvim",
  lazy = false,
  opts = {
    extra_groups = {
      "NormalFloat",
      "NvimTreeNormal",
    },
  },
  --- @param _ any
  --- @param opts transparent.Config
  config = function(_, opts)
    local transparent = require "transparent"
    transparent.setup(opts)
    transparent.clear_prefix "BufferLine"
    transparent.clear_prefix "NeoTree"
    transparent.clear_prefix "lualine"
    transparent.clear_prefix "TabLine"
    transparent.clear_prefix "TabLineSel"
    transparent.clear_prefix "TabLineFill"
    transparent.clear_prefix "TelescopeNormal"
    transparent.clear_prefix "TelescopeBorder"
    transparent.clear_prefix "TelescopeBorder"
    transparent.clear_prefix "NotifyLogTime"
    transparent.clear_prefix "NotifyDEBUGBody"
    transparent.clear_prefix "NotifyDEBUGTitle"
    transparent.clear_prefix "NotifyINFOBody"
    transparent.clear_prefix "NotifyINFOTitle"
    transparent.clear_prefix "NotifyWARNBody"
    transparent.clear_prefix "NotifyWARNTitle"
    transparent.clear_prefix "NotifyERRORBody"
    transparent.clear_prefix "NotifyERRORTitle"
  end,
  dependencies = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        opts.mappings.n["<Leader>ue"] = { "<Cmd>TransparentToggle<CR>", desc = "Toggle transparency" }
        if vim.tbl_get(opts, "autocmds", "heirline_colors") then
          table.insert(opts.autocmds.heirline_colors, {
            event = "User",
            pattern = "TransparentClear",
            desc = "Refresh heirline colors",
            callback = function()
              if package.loaded["heirline"] then require("astroui.status.heirline").refresh_colors() end
            end,
          })
        end
      end,
    },
    {
      "rcarriga/nvim-notify",
      --- @type notify.Config
      --- @diagnostic disable: missing-fields
      opts = {
        background_colour = "#000000",
      },
    },
  },
}
