-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
if vim.fn.getenv("TERM_PROGRAM") == "ghostty" then
  vim.opt.title = true
  vim.opt.titlestring = "%{fnamemodify(getcwd(), ':t')}"
end

vim.g.root_spec = { "lsp", { ".git", "lua" }, { "package.json", "tsconfig.json" }, "cwd" }
vim.opt.laststatus = 3
vim.opt.scrolloff = 4 -- Lines of context
vim.opt.sidescrolloff = 0 -- Columns of context
vim.g.snacks_animate = false -- disable all animations

vim.keymap.set("n", "<leader>po", ":update<CR> :source<CR>", { desc = "Update and source" })
vim.filetype.add({
  extension = {
    props = "xml",
    csproj = "xml",
    editorconfig = "editorconfig",
    slnx = "xml",
    tmpl = "gotmpl",
    cod = "coda",
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
