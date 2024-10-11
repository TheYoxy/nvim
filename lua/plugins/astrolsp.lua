-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    -- Configuration table of features provided by AstroLSP
    features = {
      autoformat = true, -- enable or disable auto formatting on start
      codelens = true, -- enable/disable codelens refresh on start
      inlay_hints = false, -- enable/disable inlay hints on start
      semantic_tokens = true, -- enable/disable semantic token highlighting
    },
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
          "lua",
          "rust",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- "sumneko_lua",
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
    },
    -- customize language server configuration options passed to `lspconfig`
    ---@diagnostic disable: missing-fields
    config = {
      nil_ls = {
        settings = {
          ["nil"] = {
            nix = {
              maxMemoryMB = 16384,
              flake = {
                autoEvalInputs = true,
              },
            },
          },
        },
      },
      -- clangd = { capabilities = { offsetEncoding = "utf-8" } },
    },
    -- customize how language servers are attached
    handlers = {
      hls = function(_, opts) require("lspconfig").hls.setup(opts) end,
      -- rust_analyzer = function(_, opts) require("rust-tools").setup { server = opts } end,
      -- a function without a key is simply the default handler, functions take two parameters, the server name and the configured options table for that server
      -- function(server, opts) require("lspconfig")[server].setup(opts) end

      -- the key is the server that is being setup with `lspconfig`
      -- rust_analyzer = false, -- setting a handler to false will disable the set up of that language server
      -- pyright = function(_, opts) require("lspconfig").pyright.setup(opts) end -- or a custom handler function can be passed
    },
    -- mappings to be set up on attaching of a language server
    mappings = {
      n = {
        ["<Leader>xq"] = false,
        ["<Leader>xl"] = false,
        ["<Leader>w"] = false,
        ["<Leader>r"] = { name = "Refactoring" },
        ["<Leader>rr"] = {
          function() vim.lsp.buf.rename() end,
          desc = "Rename symbol",
        },
        ["<Leader>rd"] = {
          function() vim.lsp.buf.delete() end,
          desc = "Delete symbol",
        },
        ["<Leader>rf"] = {
          function() vim.lsp.buf.format(require("astrolsp").format_opts) end,
          desc = "Format buffer",
          cond = "textDocument/formatting",
        },
        ["<Leader>ri"] = {
          function()
            -- Check if the current buffer has vtsls as its language server
            local clients = vim.lsp.get_clients { bufnr = 0 }
            local has_vtsls = false
            for _, client in ipairs(clients) do
              if client.name == "vtsls" then
                has_vtsls = true
                break
              end
            end

            if has_vtsls then
              -- Execute the "Remove Unused Imports" code action
              vim.lsp.buf.code_action {
                context = {
                  only = { "source.organizeImports" },
                },
                apply = true,
              }
              print "Removed unused imports"
            else
              print "vtsls is not active in this buffer"
            end
          end,
          desc = "Remove imports",
          cond = "textDocument/codeAction",
        },
        -- [":"] = {
        --   function() require("fine-cmdline").open { default_value = "" } end,
        --   desc = "Fine commandline",
        -- },
        -- a `cond` key can provided as the string of a server capability to be required to attach, or a function with `client` and `bufnr` parameters from the `on_attach` that returns a boolean
        -- gD = {
        --   function() vim.lsp.buf.declaration() end,
        --   desc = "Declaration of current symbol",
        --   cond = "textDocument/declaration",
        -- },
        -- ["<Leader>uY"] = {
        --   function() require("astrolsp.toggles").buffer_semantic_tokens() end,
        --   desc = "Toggle LSP semantic highlight (buffer)",
        --   cond = function(client) return client.server_capabilities.semanticTokensProvider and vim.lsp.semantic_tokens end,
        -- },
      },
      v = {
        ["<Leader>rf"] = {
          function() vim.lsp.buf.format(require("astrolsp").format_opts) end,
          desc = "Format buffer",
          cond = "textDocument/formatting",
        },
      },
    },
    -- A custom `on_attach` function to be run after the default `on_attach` function
    -- takes two parameters `client` and `bufnr`  (`:h lspconfig-setup`)
    on_attach = function(client, bufnr)
      -- this would disable semanticTokensProvider for all clients
      -- client.server_capabilities.semanticTokensProvider = nil
    end,
  },
}
