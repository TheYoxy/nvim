if not vim.fn.has("macunix") then -- NOTE: This is a macos specific configuration
  return {}
end

return {
  {
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
    --- @module "obsidian"
    --- @type obsidian.config
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
      legacy_commands = false,
      finder = "snacks.pick",
      templates = {
        folder = "templates",
        date_format = "%Y-%m-%d-%a",
        time_format = "%H:%M",
      },
      daily_notes = {
        folder = "daily",
        date_format = "%Y-%m-%d",
      },
      frontmatter = {
        sort = true,
        func = function(note) -- This is equivalent to the default frontmatter function.
          -- Add the title of the note as an alias.
          if note.title then
            note:add_alias(note.title)
          end

          local out = { id = note.id, aliases = note.aliases, tags = note.tags, Date = os.date("%Y-%m-%d") }

          -- `note.metadata` contains any manually added fields in the frontmatter.
          -- So here we just make sure those fields are kept in the frontmatter.
          if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
            for k, v in pairs(note.metadata) do
              out[k] = v
            end
          end

          out["last-modified"] = os.date("%Y-%m-%d")

          return out
        end,
      },
      footer = {
        enabled = true,
      },
      attachments = {
        folder = "/assets",
      },
    },
  },
  {
    "saghen/blink.cmp",
    optional = true,
    --- @module "blink.cmp"
    --- @type blink.cmp.Config
    opts = {
      sources = {
        per_filetype = {
          markdown = { "lsp", "path" },
        },
      },
    },
  },
  {
    "kevalin/mermaid.nvim",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
          if type(opts.ensure_installed) == "table" then
            vim.list_extend(opts.ensure_installed, { "mermaid" })
          end
        end,
      },
    },
    config = function()
      require("mermaid").setup()

      -- Install the tree-sitter parser manually if TSInstall fails
      -- :TSInstall mermaid
    end,
  },
}
