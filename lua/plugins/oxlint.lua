--- Vite+ project root: a `vite.config.ts` next to a local `vp` binary.
--- Vite+ keeps lint/fmt config inside vite.config.ts, and only the bundled
--- oxlint (launched through `vp`) can read it.
--- @param bufnr integer
--- @return string|nil
local function vite_plus_root(bufnr)
  local root = vim.fs.root(bufnr, "vite.config.ts")
  if root and vim.uv.fs_stat(root .. "/node_modules/.bin/vp") then
    return root
  end
end

local supported = {
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",
  "json",
  "jsonc",
  "vue",
  "svelte",
  "astro",
  "css",
  "yaml",
}

--- @module "lazy"
--- @module "lspconfig"
--- @module "lspconfig.configs"
--- @module "lspconfig.configs.tailwindcss"
--- @type LazySpec
return {
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "oxlint", "oxfmt" } },
  },
  {
    "neovim/nvim-lspconfig",
    ---@diagnostic disable missing-fields
    ---@type PluginLspOpts
    opts = {
      servers = {
        ---@type lspconfig.settings.oxlint
        oxlint = {
          -- keep the mason binary for normal projects, use the project's Vite+ oxlint when there is one
          cmd = function(dispatchers)
            local root = vite_plus_root(vim.api.nvim_get_current_buf())
            if root then
              return vim.lsp.rpc.start(
                { root .. "/node_modules/.bin/vp", "lint", "--lsp" },
                dispatchers,
                { cwd = root } -- vp resolves its config from the working directory
              )
            end
            return vim.lsp.rpc.start({ vim.fn.exepath("oxlint"), "--lsp" }, dispatchers)
          end,
          -- capabilities = { textDocument = { diagnostic = vim.NIL } },
          root_dir = function(bufnr, on_dir)
            local vite_plus = vite_plus_root(bufnr)
            if vite_plus then
              return on_dir(vite_plus)
            end
            -- prefer the top-level oxlint config if it exists (monorepo support)
            local git = vim.fs.root(bufnr, ".git")
            local markers = { ".oxlintrc.json", ".oxlintrc.jsonc", "oxlint.config.ts" }
            local root = git and vim.fs.root(git, markers) or vim.fs.root(bufnr, markers)
            if root then
              on_dir(root)
            end
          end,

          settings = {
            run = "onSave",
            -- configPath = nil,
            -- tsConfigPath = nil,
            unusedDisableDirectives = "allow",
            typeAware = true,
            -- disableNestedConfig = false,
            -- fixKind = 'safe_fix',
            fixKind = "safe_fix_or_suggestion",
          },
        },

        --- disable the oxfmt lsp server since we use conform for formatting
        oxfmt = { enabled = false },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      for _, ft in ipairs(supported) do
        opts.formatters_by_ft[ft] = opts.formatters_by_ft[ft] or {}
        table.insert(opts.formatters_by_ft[ft], "oxfmt")
      end

      -- Vite+ keeps `fmt` inside vite.config.ts, which only the bundled `vp fmt` can read
      opts.formatters = opts.formatters or {}
      opts.formatters.oxfmt = vim.tbl_deep_extend("force", opts.formatters.oxfmt or {}, {
        command = function(_, ctx)
          local root = vite_plus_root(ctx.filename)
          if root then
            return root .. "/node_modules/.bin/vp"
          end
          return require("conform.util").from_node_modules("oxfmt")(nil, ctx)
        end,
        args = function(_, ctx)
          if vite_plus_root(ctx.filename) then
            return { "fmt", "--stdin-filepath", "$FILENAME" }
          end
          return { "--stdin-filepath", "$FILENAME" }
        end,
      })
    end,
  },
}
