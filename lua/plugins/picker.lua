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
    --- @module "fff"
    --- @type FffConfig
    opts = {
      -- fff indexes everything (honouring .gitignore), including hidden files.
      base_path = vim.fn.getcwd(),
      title = "Find Files", -- Window title
      install = {
        timeout = 1200, -- 20 minutes - should be plenty
      },
      max_results = 100, -- Maximum search results to display
      max_threads = 4, -- Maximum threads for fuzzy search
      lazy_sync = true,

      prompt = "🛸 ", -- Input prompt symbol
      layout = {
        width = 0.75, -- Window width as fraction of screen
        height = 0.85, -- Window height as fraction of screen
        prompt_position = "top", -- or 'top'
        preview_position = "right", -- or 'left', 'right', 'top', 'bottom'
        preview_size = 0.5,
        flex = false,
      },
      frecency = {
        enabled = true,
        db_path = vim.fn.stdpath("cache") .. "/fff_nvim",
      },

      preview = {
        enabled = true,
        max_lines = 100,
        max_size = 10 * 1024 * 1024, -- 1MB
        chunk_size = 8192,
        binary_file_threshold = 1024,
        line_numbers = false,
        wrap_lines = false,
        show_file_info = true,
      },

      history = {
        enabled = true,
        db_path = vim.fn.stdpath("data") .. "/fff_queries",
        min_combo_count = 3, -- file will get a boost if it was selected 3 in a row times per specific query
        combo_boost_score_multiplier = 100, -- Score multiplier for combo matches
      },

      keymaps = {
        move_up = { "<Up>", "<C-p>", "<C-k>" },
        move_down = { "<Down>", "<C-n>", "<C-j>" },
        preview_scroll_up = "<C-u>",
        preview_scroll_down = "<C-d>",
      },

      git = {
        status_text_color = true, -- Enable git status colors on filename text
      },
      grep = {
        smart_case = true,
      },
      -- Highlight groups
      hl = {
        border = "FloatBorder",
        normal = "Normal",
        cursor = "CursorLine",
        matched = "IncSearch",
        title = "Title",
        prompt = "Question",
        active_file = "Visual",
        frecency = "Number",
        debug = "Comment",
        git_staged = "FFFGitStaged", -- Files staged for commit
        git_modified = "FFFGitModified", -- Modified unstaged files
        git_deleted = "FFFGitDeleted", -- Deleted files
        git_renamed = "FFFGitRenamed", -- Renamed files
        git_untracked = "FFFGitUntracked", -- New untracked files
        git_ignored = "FFFGitIgnored", -- Git-ignored files
      },
    },
    keys = {
      {
        "<leader><space>",
        function()
          require("fff").find_files()
        end,
        desc = "Find Files (cwd)",
      },
      {
        "<leader>/",
        function()
          require("fff").live_grep({
            cwd = vim.fn.getcwd(),
          })
        end,
        desc = "Grep (Root Dir)",
      },
      {
        "<leader>ff",
        function()
          require("fff").find_files()
        end,
        desc = "Find Files (Root Dir)",
      },
      {
        "<leader>fF",
        function()
          require("fff").find_files()
        end,
        desc = "Find Files (cwd)",
      },
      {
        "<leader>fw",
        function()
          require("fff").live_grep()
        end,
        desc = "Grep (Root Dir)",
      },
      {
        "<leader>fW",
        function()
          require("fff").live_grep()
        end,
        desc = "Grep (cwd)",
      },
      {
        "<leader>fw",
        function()
          require("fff").live_grep_under_cursor()
        end,
        desc = "Visual selection or word (Root Dir)",
        mode = { "v", "x" },
      },
      {
        "<leader>fW",
        function()
          require("fff").live_grep_under_cursor()
        end,
        desc = "Visual selection or word (cwd)",
        mode = { "v", "x" },
      },
    },
  },
}
