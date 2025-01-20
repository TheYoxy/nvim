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
