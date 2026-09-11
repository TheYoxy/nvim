--- @type LazySpec
return {
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "gh-actions-language-server" } },
  },
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- GitHub Actions language server.
        -- The built-in `root_dir` only attaches inside `.github/workflows`
        -- (plus `.forgejo`/`.gitea` equivalents), so it never runs on
        -- regular yaml files. LazyVim auto-installs it via mason when a
        -- workflow file is opened.
        gh_actions_ls = {},
      },
    },
  },
}
