--- @type LazySpec
-- File + text picker is now provided by dmtrKovalenko/fff (fff.nvim).
-- Snacks picker stays available for buffers, recent, git, projects, Lazy search,
-- the dashboard, etc. The find-files and grep leader keys below live here; the
-- old Snacks-routed copies in lua/plugins/remap.lua are commented out.
return {
  {
    "dmtrKovalenko/fff",
    build = function()
      -- Downloads a prebuilt binary or falls back to `cargo build`.
      require("fff.download").download_or_build_binary()
    end,
    lazy = false, -- fff lazy-initialises itself
    opts = {
      -- fff indexes everything (honouring .gitignore), including hidden files.
      base_path = vim.fn.getcwd(),
      layout = {
        height = 0.8,
        width = 0.8,
      },
      frecency = {
        enabled = true,
        db_path = vim.fn.stdpath("cache") .. "/fff_nvim",
      },
      history = {
        enabled = true,
        db_path = vim.fn.stdpath("data") .. "/fff_queries",
      },
      keymaps = {
        -- Your old <C-S-k> stepped back through the query history; fff exposes
        -- "previous query" cycling, so keep it on <C-S-k> (and <C-Up>).
        cycle_previous_query = { "<C-S-k>", "<C-Up>" },
      },
    },
    keys = {
      { "<leader><space>", function() require("fff").find_files() end, desc = "Find Files (cwd)" },
      { "<leader>/", function() require("fff").live_grep() end, desc = "Grep (Root Dir)" },
      { "<leader>ff", function() require("fff").find_files() end, desc = "Find Files (Root Dir)" },
      { "<leader>fF", function() require("fff").find_files() end, desc = "Find Files (cwd)" },
      { "<leader>fw", function() require("fff").live_grep() end, desc = "Grep (Root Dir)" },
      { "<leader>fW", function() require("fff").live_grep() end, desc = "Grep (cwd)" },
      { "<leader>fw", function() require("fff").live_grep_under_cursor() end, desc = "Visual selection or word (Root Dir)", mode = { "v", "x" } },
      { "<leader>fW", function() require("fff").live_grep_under_cursor() end, desc = "Visual selection or word (cwd)", mode = { "v", "x" } },
    },
  },
}