if vim.g.vscode then return {} end -- NOTE: don't do anything in vscode instances

-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes

if vim.fn.getenv "TERM_PROGRAM" == "ghostty" then
  vim.opt.title = true
  vim.opt.titlestring = "%{fnamemodify(getcwd(), ':t')}"
end

vim.filetype.add {
  extension = {
    props = "xml",
    csproj = "xml",
    editorconfig = "editorconfig",
    slnx = "xml",
    tmpl = "gotmpl",
  },
  pattern = {
    [".*/hypr/.*%.conf"] = "hyprlang",
    [".zsh"] = "sh",
    [".zshenv"] = "sh",
    [".zsh/.*%.zsh"] = "sh",
  },
}
local blend = 20

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "TelescopePrompt",
--   callback = function(ctx)
--     local backdropName = "TelescopeBackdrop"
--     local telescopeBufnr = ctx.buf
--
--     -- `Telescope` does not set a zindex, so it uses the default value
--     -- of `nvim_open_win`, which is 50: https://neovim.io/doc/user/api.html#nvim_open_win()
--     local telescopeZindex = 50
--
--     local backdropBufnr = vim.api.nvim_create_buf(false, true)
--     local winnr = vim.api.nvim_open_win(backdropBufnr, false, {
--       relative = "editor",
--       row = 0,
--       col = 0,
--       width = vim.o.columns,
--       height = vim.o.lines,
--       focusable = false,
--       style = "minimal",
--       zindex = telescopeZindex - 1, -- ensure it's below the reference window
--     })
--
--     if vim.g.transparent_enabled then
--       vim.api.nvim_set_hl(0, backdropName, { bg = nil, blend = blend, guibg = NONE, default = true })
--     else
--       vim.api.nvim_set_hl(0, backdropName, { bg = "#000000", blend = blend, default = true })
--     end
--
--     vim.wo[winnr].winhighlight = "Normal:" .. backdropName
--     vim.wo[winnr].winblend = blend
--     vim.bo[backdropBufnr].buftype = "nofile"
--
--     -- close backdrop when the reference buffer is closed
--     vim.api.nvim_create_autocmd({ "WinClosed", "BufLeave" }, {
--       once = true,
--       buffer = telescopeBufnr,
--       callback = function()
--         if vim.api.nvim_win_is_valid(winnr) then vim.api.nvim_win_close(winnr, true) end
--         if vim.api.nvim_buf_is_valid(backdropBufnr) then vim.api.nvim_buf_delete(backdropBufnr, { force = true }) end
--       end,
--     })
--   end,
-- })
