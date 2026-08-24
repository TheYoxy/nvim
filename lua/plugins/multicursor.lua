--- @module "lazy"
--- @type LazySpec
return {
  {
    "brenton-leighton/multiple-cursors.nvim",
    version = "*", -- Use the latest tagged version
    -- This causes the plugin setup function to be called
    --- @module "multiple-cursors"
    opts = {},
    event = "VeryLazy",
    lazy = true,
    keys = {
      {
        "<C-Up>",
        function()
          require("multiple-cursors").add_cursor_up()
        end,
        mode = { "n", "i", "x" },
        desc = "Add cursor and move up",
      },
      {
        "<C-Down>",
        function()
          require("multiple-cursors").add_cursor_down()
        end,
        mode = { "n", "i", "x" },
        desc = "Add cursor and move down",
      },

      {
        "<C-LeftMouse>",
        "<Cmd>MultipleCursorsMouseAddDelete<CR>",
        mode = { "n", "i" },
        desc = "Add or remove cursor on mouse click",
      },
      {
        "<C-Return>",
        "<Cmd>MultipleCursorsAddDelete<CR>",
        mode = { "n" },
        desc = "Add a locked cursor or remove an existing cursor",
      },

      {
        "<C-g>",
        function()
          require("multiple-cursors").add_cursors_to_matches()
        end,
        mode = { "n" },
        desc = "Add cursors to cword",
      },
      {
        "<C-g>",
        function()
          require("multiple-cursors").add_cursors_to_visual_area()
        end,
        mode = { "v", "x" },
        desc = "Add cursors to the lines of the visual area",
      },
      {
        "<C-G>",
        function()
          require("multiple-cursors").add_cursors_to_matches_v()
        end,
        mode = { "n", "x" },
        desc = "Add cursors to cword in previous area",
      },
    },
  },
}
