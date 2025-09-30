if not vim.fn.has("macunix") then -- NOTE: This is a macos specific configuration
  return {}
end

return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  ft = "markdown",
  keys = {
    ["gf"] = {
      function()
        if require("obsidian").util.cursor_on_markdown_link() then
          return "<Cmd>Obsidian follow_link<CR>"
        else
          return "gf"
        end
      end,
      desc = "Obsidian Follow Link",
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "hrsh7th/nvim-cmp", optional = true },
  },
  opts = {
    workspaces = {
      {
        name = "Endevops",
        path = vim.env.HOME .. "/dev/notes/Endevops", -- specify the vault location. no need to call 'vim.fn.expand' here
      },
      {
        name = "Entrainements",
        path = vim.env.HOME .. "/dev/notes/Entrainements",
      },
    },
    open = {
      use_advanced_uri = true,
    },
    finder = "snacks.pick",
    templates = {
      subdir = "templates",
      date_format = "%Y-%m-%d-%a",
      time_format = "%H:%M",
    },
    daily_notes = {
      folder = "daily",
    },
    completion = {
      nvim_cmp = not not require("lazy.core.config").plugins["nvim-cmp"],
      blink = not not require("lazy.core.config").plugins["blink"],
    },
    note_frontmatter_func = function(note) -- This is equivalent to the default frontmatter function.
      local out = { id = note.id, aliases = note.aliases, tags = note.tags }
      -- `note.metadata` contains any manually added fields in the frontmatter.
      -- So here we just make sure those fields are kept in the frontmatter.
      if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
      end
      return out
    end,

    -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
    -- URL it will be ignored but you can customize this behavior here.
    follow_url_func = vim.ui.open,
  },
}
