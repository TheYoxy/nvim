if vim.g.vscode then return {} end -- NOTE: don't do anything in vscode instances

-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes

vim.filetype.add {
  pattern = {
    [".*/hypr/.*%.conf"] = "hyprlang",
    [".zsh"] = "sh",
    [".zshenv"] = "sh",
    [".zsh/.*%.zsh"] = "sh",
    ["Directory.[Bb]uild.props"] = "xml",
    ["Directory.[Pp]ackages.props"] = "xml",
    ["Directory.[Bb]uild.target"] = "xml",
    ["*.slnx"] = "xml",
    ["*.csproj"] = "xml",
    ["*%.tmpl"] = "gotmpl",
  },
}
