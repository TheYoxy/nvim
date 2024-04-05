if true then return {} end -- WARN:Remove this line to enable this file

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    autocmds = {
      -- disable alpha autostart
      alpha_autostart = false,
      restore_session = {
        {
          event = "VimEnter",
          desc = "Restore previous directory session if neovim opened with no arguments",
          callback = function()
            -- Only load the session if nvim was started with no args
            if vim.fn.argc(-1) == 0 then
              -- try to load a directory session using the current working directory
              require("resession").load(vim.fn.getcwd(), { dir = "dirsession", silence_errors = true })
              -- trigger buffer read auto commands on each opened buffer after load
              vim.tbl_map(vim.cmd.doautoall, { "BufReadPre", "BufReadPost" })
            end
          end,
        },
      },
    },
  },
}
