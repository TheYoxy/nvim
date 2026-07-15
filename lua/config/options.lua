-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
if vim.fn.getenv("TERM_PROGRAM") == "ghostty" then
  vim.opt.title = true
  vim.opt.titlestring = "%{fnamemodify(getcwd(), ':t')}"
end

-- vim.g.root_spec = { "lsp", { ".git", "lua" }, { "package.json", "tsconfig.json" }, "cwd" }
vim.g.root_spec = { ".git", "cwd" }
vim.opt.laststatus = 3
vim.opt.so = 999 -- Lines of context
vim.opt.sop = 999 -- Lines of context
-- vim.opt.ss = 1 -- Columns of context
-- vim.opt.siso = 0 -- Columns of context

vim.keymap.set("n", "<leader>po", ":update<CR> :source<CR>", { desc = "Update and source" })
vim.filetype.add({
  extension = {
    props = "xml",
    csproj = "xml",
    editorconfig = "editorconfig",
    slnx = "xml",
    tmpl = "gotmpl",
    -- cod = "coda",
  },
  pattern = {
    [".*/hypr/.*%.conf"] = "hyprlang",
    [".zsh"] = "sh",
    [".zshenv"] = "sh",
    [".zsh/.*%.zsh"] = "sh",
  },
})

require("colorify").run()

table.insert(vim.opt.spelllang, "fr")
vim.opt.list = true -- Show some invisible characters (tabs...
vim.opt.listchars = {
  -- space = ".",
  -- eol = "$",
  -- tab = ">-",
  nbsp = "\\x24",
}
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.lazyvim_prettier_needs_config = true

-- Remote clipboard copy
if os.getenv("SSH_TTY") then
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
      ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
    },
  }
end

-- vim.lsp.config("fallow", {
--   cmd = { "fallow-lsp" },
--   filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
--   root_markers = { ".fallowrc.json", "package.json", ".git" },
--   init_options = {
--     -- Every issue type is enabled by default. List only the ones you
--     -- want to turn off; any key you omit stays enabled.
--     -- issueTypes = {
--     --   ["circular-dependencies"] = false,
--     -- },
--   },
-- })
--
-- vim.lsp.enable("fallow")
