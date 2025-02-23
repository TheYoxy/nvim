--- @type LazySpec
return {
  "goolord/alpha-nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  --- @type PluginOpts
  opts = function(_, opts)
    local dashboard = require "alpha.themes.dashboard"
    --- @param shortcut string Shortcut string of a button mapping
    --- @param desc string Real text description of the mapping
    --- @param rhs string? Righthand side of mapping if defining a new mapping (_optional_)
    --- @param map_opts table? `keymap.set` options used during keymap creating (_optional_)
    dashboard.button = function(shortcut, desc, rhs, map_opts)
      -- HACK: fixes leader customization, remove after fixed upstream
      -- https://github.com/goolord/alpha-nvim/pull/271
      local lhs = shortcut:gsub("%s", ""):gsub(dashboard.leader, "<Leader>")
      local default_map_opts = { noremap = true, silent = true, nowait = true, desc = desc }

      local leader = vim.g.mapleader
      if leader == " " then leader = "SPC" end

      return {
        type = "button",
        val = desc,
        on_press = function()
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(rhs or lhs .. "<Ignore>", true, false, true), "t", false)
        end,
        opts = {
          position = "center",
          shortcut = shortcut:gsub(dashboard.leader, leader),
          cursor = -2,
          width = 36,
          align_shortcut = "right",
          hl = "DashboardCenter",
          hl_shortcut = "DashboardShortcut",
          keymap = rhs and { "n", lhs, rhs, require("astrocore").extend_tbl(default_map_opts, map_opts) },
        },
      }
    end
    -- customize the dashboard header
    opts.section.header.val = {
      "░        ░░   ░░░  ░░       ░░░        ░░  ░░░░  ░░░      ░░░       ░░░░      ░░",
      "▒  ▒▒▒▒▒▒▒▒    ▒▒  ▒▒  ▒▒▒▒  ▒▒  ▒▒▒▒▒▒▒▒  ▒▒▒▒  ▒▒  ▒▒▒▒  ▒▒  ▒▒▒▒  ▒▒  ▒▒▒▒▒▒▒",
      "▓      ▓▓▓▓  ▓  ▓  ▓▓  ▓▓▓▓  ▓▓      ▓▓▓▓▓  ▓▓  ▓▓▓  ▓▓▓▓  ▓▓       ▓▓▓▓      ▓▓",
      "█  ████████  ██    ██  ████  ██  ██████████    ████  ████  ██  ██████████████  █",
      "█        ██  ███   ██       ███        █████  ██████      ███  █████████      ██",
      "                                                                                ",
      "░        ░░  ░░░░  ░░        ░░  ░░░░  ░░░      ░░░  ░░░░  ░░  ░░░░  ░          ",
      "▒▒▒▒  ▒▒▒▒▒  ▒▒▒▒  ▒▒  ▒▒▒▒▒▒▒▒▒  ▒▒  ▒▒▒  ▒▒▒▒  ▒▒▒  ▒▒  ▒▒▒▒  ▒▒  ▒▒          ",
      "▓▓▓▓  ▓▓▓▓▓        ▓▓      ▓▓▓▓▓▓    ▓▓▓▓  ▓▓▓▓  ▓▓▓▓    ▓▓▓▓▓▓    ▓▓▓          ",
      "████  █████  ████  ██  ███████████  █████  ████  ███  ██  ██████  ████          ",
      "████  █████  ████  ██        █████  ██████      ███  ████  █████  ████          ",
    }

    local get_icon = require("astroui").get_icon
    opts.section.buttons.val = {
      dashboard.button("LDR n  ", get_icon("FileNew", 2, true) .. "New File  "),
      dashboard.button("LDR f f", get_icon("Search", 2, true) .. "Find File  "),
      dashboard.button("LDR f e", get_icon("Search", 2, true) .. "Recently Opened Files"),
      dashboard.button("LDR f o", get_icon("DefaultFile", 2, true) .. "Recents  "),
      dashboard.button("LDR f w", get_icon("WordFile", 2, true) .. "Find Word  "),
      dashboard.button("LDR S l", get_icon("Refresh", 2, true) .. "Last Session  "),
      dashboard.button("LDR S l", get_icon("Refresh", 2, true) .. "Load Last Session"),
      dashboard.button("LDR S F", get_icon("Refresh", 2, true) .. "Load dir session"),
    }

    dashboard.config.layout = {
      { type = "padding", val = vim.fn.max { 2, vim.fn.floor(vim.fn.winheight(0) * 0.2) } },
      dashboard.section.header,
      { type = "padding", val = 5 },
      dashboard.section.buttons,
      { type = "padding", val = 3 },
      dashboard.section.footer,
    }
    return opts
  end,
}
