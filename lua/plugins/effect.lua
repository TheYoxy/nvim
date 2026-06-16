-- NOTE: disabled, the effect language service is not installed via mason, i should look at it in more detail
if true then
  return {}
end

return {
  -- Ensure LSP servers
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        vtsls = {},
      },
    },
  },

  -- Configure tsserver plugin
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      LazyVim.extend(opts.servers.vtsls, "settings.vtsls.tsserver.globalPlugins", {
        {
          name = "@effect/typescript-plugin",
          location = LazyVim.get_pkg_path("effect-language-service", "@effect/language-service"),
          languages = { "vue" },
          configNamespace = "typescript",
          enableForWorkspaceTypeScriptVersions = true,
        },
      })

      if opts.servers.tsgo ~= nil then
        LazyVim.extend(opts.servers.tsgo, "settings.vtsls.tsserver.globalPlugins", {
          {
            name = "@effect/typescript-plugin",
            location = LazyVim.get_pkg_path("effect-language-service", "@effect/language-service"),
            languages = { "vue" },
            configNamespace = "typescript",
            enableForWorkspaceTypeScriptVersions = true,
          },
        })
      end
    end,
  },
}
