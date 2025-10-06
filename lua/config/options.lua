-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
if vim.fn.getenv("TERM_PROGRAM") == "ghostty" then
  vim.opt.title = true
  vim.opt.titlestring = "%{fnamemodify(getcwd(), ':t')}"
end

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

-- local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
-- parser_config.coda = {
--   install_info = {
--     url = "https://github.com/theyoxy/tree-sitter-coda",
--     files = { "src/parser.c" },
--     -- development mode
--     -- url = vim.env.HOME .. "/dev/tree-sitter-coda",
--     -- generate_requires_npm = true,
--     -- requires_generate_from_grammar = true,
--   },
--   filetype = "coda",
-- }

-- vim.opt.rtp:append(vim.env.HOME .. "/dev/tree-sitter-coda")
--

table.insert(vim.opt.spelllang, "fr")
