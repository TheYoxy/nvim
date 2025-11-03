--- NOTE: this file is here only to support rename

--- @type LazySpec
return {
  {
    "gbprod/yanky.nvim",
    optional = true,
    keys = {
      { "<leader>p", false },
      {
        "<leader>y",
        function()
          if LazyVim.pick.picker.name == "telescope" then
            require("telescope").extensions.yank_history.yank_history({})
          elseif LazyVim.pick.picker.name == "snacks" then
            Snacks.picker.yanky()
          else
            vim.cmd([[YankyRingHistory]])
          end
        end,
        mode = { "n", "x" },
        desc = "Open Yank History",
      },
      { "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank Text" },
      { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put Text After Cursor" },
      { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put Text Before Cursor" },
      { "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }, desc = "Put Text After Selection" },
      { "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }, desc = "Put Text Before Selection" },
      { "[y", "<Plug>(YankyCycleForward)", desc = "Cycle Forward Through Yank History" },
      { "]y", "<Plug>(YankyCycleBackward)", desc = "Cycle Backward Through Yank History" },
      { "]p", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put Indented After Cursor (Linewise)" },
      { "[p", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put Indented Before Cursor (Linewise)" },
      { "]P", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put Indented After Cursor (Linewise)" },
      { "[P", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put Indented Before Cursor (Linewise)" },
      { ">p", "<Plug>(YankyPutIndentAfterShiftRight)", desc = "Put and Indent Right" },
      { "<p", "<Plug>(YankyPutIndentAfterShiftLeft)", desc = "Put and Indent Left" },
      { ">P", "<Plug>(YankyPutIndentBeforeShiftRight)", desc = "Put Before and Indent Right" },
      { "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)", desc = "Put Before and Indent Left" },
      { "=p", "<Plug>(YankyPutAfterFilter)", desc = "Put After Applying a Filter" },
      { "=P", "<Plug>(YankyPutBeforeFilter)", desc = "Put Before Applying a Filter" },
    },
  },
  {
    "folke/snacks.nvim",
    optional = true,
    keys = {
      {
        "<leader>e",
        function()
          Snacks.explorer({ cwd = LazyVim.root() })
        end,
        desc = "Explorer Snacks (root dir)",
      },
      {
        "<leader>E",
        function()
          Snacks.explorer()
        end,
        desc = "Explorer Snacks (cwd)",
      },
      {
        "<leader>o",
        function()
          Snacks.explorer.reveal()
        end,
        desc = "Reveal in Explorer Snacks",
      },
      {
        "<leader>,",
        function()
          Snacks.picker.buffers()
        end,
        desc = "Buffers",
      },
      { "<leader>/", LazyVim.pick("grep"), desc = "Grep (Root Dir)" },
      {
        "<leader>:",
        function()
          Snacks.picker.command_history()
        end,
        desc = "Command History",
      },
      { "<leader><space>", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
      {
        "<leader>n",
        function()
          Snacks.picker.notifications()
        end,
        desc = "Notification History",
      },
      -- find
      {
        "<leader>fb",
        function()
          Snacks.picker.buffers()
        end,
        desc = "Buffers",
      },
      {
        "<leader>fB",
        function()
          Snacks.picker.buffers({ hidden = true, nofile = true })
        end,
        desc = "Buffers (all)",
      },
      { "<leader>fc", LazyVim.pick.config_files(), desc = "Find Config File" },
      { "<leader>ff", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
      { "<leader>fF", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
      -- { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Files (git-files)" },
      {
        "<leader>fe",
        function()
          Snacks.picker.recent({ filter = { cwd = true } })
        end,
        desc = "Recent",
      },
      { "<leader>fE", LazyVim.pick("oldfiles"), desc = "Recent (cwd)" },
      {
        "<leader>fp",
        function()
          Snacks.picker.projects()
        end,
        desc = "Projects",
      },
      -- git
      {
        "<leader>gd",
        function()
          Snacks.picker.git_diff()
        end,
        desc = "Git Diff (hunks)",
      },
      {
        "<leader>gs",
        function()
          Snacks.picker.git_status()
        end,
        desc = "Git Status",
      },
      {
        "<leader>gS",
        function()
          Snacks.picker.git_stash()
        end,
        desc = "Git Stash",
      },
      -- Grep
      {
        "<leader>fb",
        function()
          Snacks.picker.lines()
        end,
        desc = "Buffer Lines",
      },
      {
        "<leader>fB",
        function()
          Snacks.picker.grep_buffers()
        end,
        desc = "Grep Open Buffers",
      },
      { "<leader>fw", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
      { "<leader>fW", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
      {
        "<leader>fp",
        function()
          Snacks.picker.lazy()
        end,
        desc = "Search for Plugin Spec",
      },
      { "<leader>fw", LazyVim.pick("grep_word"), desc = "Visual selection or word (Root Dir)", mode = { "v" } },
      { "<leader>fW", LazyVim.pick("grep_word", { root = false }), desc = "Visual selection or word (cwd)", mode = { "v" } },
      -- search
      {
        '<leader>f"',
        function()
          Snacks.picker.registers()
        end,
        desc = "Registers",
      },
      {
        "<leader>f/",
        function()
          Snacks.picker.search_history()
        end,
        desc = "Search History",
      },
      {
        "<leader>fa",
        function()
          Snacks.picker.autocmds()
        end,
        desc = "Autocmds",
      },
      {
        "<leader>fc",
        function()
          Snacks.picker.command_history()
        end,
        desc = "Command History",
      },
      {
        "<leader>fC",
        function()
          Snacks.picker.commands()
        end,
        desc = "Commands",
      },
      {
        "<leader>fd",
        function()
          Snacks.picker.diagnostics()
        end,
        desc = "Diagnostics",
      },
      {
        "<leader>fD",
        function()
          Snacks.picker.diagnostics_buffer()
        end,
        desc = "Buffer Diagnostics",
      },
      {
        "<leader>fh",
        function()
          Snacks.picker.help()
        end,
        desc = "Help Pages",
      },
      {
        "<leader>fH",
        function()
          Snacks.picker.highlights()
        end,
        desc = "Highlights",
      },
      {
        "<leader>fi",
        function()
          Snacks.picker.icons()
        end,
        desc = "Icons",
      },
      {
        "<leader>fj",
        function()
          Snacks.picker.jumps()
        end,
        desc = "Jumps",
      },
      {
        "<leader>fk",
        function()
          Snacks.picker.keymaps()
        end,
        desc = "Keymaps",
      },
      {
        "<leader>fl",
        function()
          Snacks.picker.loclist()
        end,
        desc = "Location List",
      },
      {
        "<leader>fM",
        function()
          Snacks.picker.man()
        end,
        desc = "Man Pages",
      },
      {
        "<leader>fm",
        function()
          Snacks.picker.marks()
        end,
        desc = "Marks",
      },
      {
        "<leader>fR",
        function()
          Snacks.picker.resume()
        end,
        desc = "Resume",
      },
      {
        "<leader>fq",
        function()
          Snacks.picker.qflist()
        end,
        desc = "Quickfix List",
      },
      {
        "<leader>fu",
        function()
          Snacks.picker.undo()
        end,
        desc = "Undotree",
      },
      -- ui
      {
        "<leader>uC",
        function()
          Snacks.picker.colorschemes()
        end,
        desc = "Colorschemes",
      },
      -- git
      { "<leader>gd", false },
      { "<leader>gs", false },
      { "<leader>gS", false },
      -- Grep
      { "<leader>sb", false },
      { "<leader>sB", false },
      { "<leader>sg", false },
      { "<leader>sG", false },
      { "<leader>sp", false },
      { "<leader>sw", false },
      { "<leader>sW", false },
      -- search
      { '<leader>s"', false },
      { "<leader>s/", false },
      { "<leader>sa", false },
      { "<leader>sc", false },
      { "<leader>sC", false },
      { "<leader>sd", false },
      { "<leader>sD", false },
      { "<leader>sh", false },
      { "<leader>sH", false },
      { "<leader>si", false },
      { "<leader>sj", false },
      { "<leader>sk", false },
      { "<leader>sl", false },
      { "<leader>sM", false },
      { "<leader>sm", false },
      { "<leader>sR", false },
      { "<leader>sq", false },
      { "<leader>su", false },
      { "<leader>ss", false },
      { "<leader>sS", false },
      -- ui
      { "<leader>uC", false },
    },
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        {
          mode = { "n", "v" },
          { "<leader><tab>", group = "tabs" },
          { "<leader>r", group = "refactor" },
          { "<leader>d", group = "debug" },
          { "<leader>dp", group = "profiler" },
          { "<leader>f", group = "file/find" },
          { "<leader>g", group = "git" },
          { "<leader>gh", group = "hunks" },
          { "<leader>q", group = "quit/session" },
          { "<leader>p", group = "lazy" },
          { "<leader>s", group = "search" },
          { "<leader>u", group = "ui" },
          { "<leader>x", group = "diagnostics/quickfix" },
          { "[", group = "prev" },
          { "]", group = "next" },
          { "g", group = "goto" },
          { "gs", group = "surround" },
          { "z", group = "fold" },
          {
            "<leader>b",
            group = "buffer",
            expand = function()
              return require("which-key.extras").expand.buf()
            end,
          },
          {
            "<leader>w",
            group = "windows",
            proxy = "<c-w>",
            expand = function()
              return require("which-key.extras").expand.win()
            end,
          },
          -- better descriptions
          { "gx", desc = "Open with system app" },
        },
      },
    },
  },
  {
    "ThePrimeagen/refactoring.nvim",
    optional = true,
    keys = {
      { "<leader>ri", false },
      { "<leader>rb", false },
      { "<leader>rf", false },
      { "<leader>rF", false },
      {
        "<leader>rn",
        function()
          return require("refactoring").refactor("Inline Variable")
        end,
        mode = { "n", "x" },
        desc = "Inline Variable",
        expr = true,
      },
      {
        "<leader>rbb",
        function()
          return require("refactoring").refactor("Extract Block")
        end,
        mode = { "n", "x" },
        desc = "Extract Block",
        expr = true,
      },
      {
        "<leader>rbf",
        function()
          return require("refactoring").refactor("Extract Block To File")
        end,
        mode = { "n", "x" },
        desc = "Extract Block To File",
        expr = true,
      },
      {
        "<leader>rm",
        function()
          return require("refactoring").refactor("Extract Function")
        end,
        mode = { "n", "x" },
        desc = "Extract Function",
        expr = true,
      },
      {
        "<leader>rM",
        function()
          return require("refactoring").refactor("Extract Function To File")
        end,
        mode = { "n", "x" },
        desc = "Extract Function To File",
        expr = true,
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = {
      servers = {
        ["*"] = {
          keys = {
            { "gd", vim.lsp.buf.definition, desc = "Goto Definition", has = "definition" },
            { "gr", vim.lsp.buf.references, desc = "References", nowait = true },
            { "gI", vim.lsp.buf.implementation, desc = "Goto Implementation" },
            { "gy", vim.lsp.buf.type_definition, desc = "Goto T[y]pe Definition" },
            { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
            {
              "K",
              function()
                return vim.lsp.buf.hover()
              end,
              desc = "Hover",
            },
            {
              "gK",
              function()
                return vim.lsp.buf.signature_help()
              end,
              desc = "Signature Help",
              has = "signatureHelp",
            },
            {
              "<c-k>",
              function()
                return vim.lsp.buf.signature_help()
              end,
              mode = "i",
              desc = "Signature Help",
              has = "signatureHelp",
            },
            { "<leader>l", "", desc = "+lsp", mode = { "n", "v" } },
            {
              "<leader>li",
              function()
                Snacks.picker.lsp_config()
              end,
              desc = "Lsp Info",
            },
            { "<leader>la", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" },
            { "<leader>lc", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "v" }, has = "codeLens" },
            { "<leader>lC", vim.lsp.codelens.refresh, desc = "Refresh & Display Codelens", mode = { "n" }, has = "codeLens" },
            {
              "<leader>rR",
              function()
                Snacks.rename.rename_file()
              end,
              desc = "Rename File",
              mode = { "n" },
              has = { "workspace/didRenameFiles", "workspace/willRenameFiles" },
            },
            { "<leader>rr", vim.lsp.buf.rename, desc = "Rename", has = "rename" },
            { "<leader>lA", LazyVim.lsp.action.source, desc = "Source Action", has = "codeAction" },
            {
              "<leader>lf",
              function()
                vim.notify("This doesn't works anymore. I should have a better look for a fix")
                -- local oxlint = vim.lsp.get_clients({
                --   name = "oxlint"
                -- })
                -- vim.notify(vim.inspect(oxlint))
                --       vim.lsp.buf.code_action({
                -- apply = true,
                --         filter = function(code_action)
                -- vim.print(vim.inspect(code_action))
                --           return string.find(code_action.command, "source.fixAll.oxc")
                --         end
                --       })
                -- if vim.fn.exists(":OxcFixAll") > 0 then vim.cmd("OxcFixAll") end
                -- if vim.fn.exists(":EslintFixAll") > 0 then vim.cmd("EslintFixAll") end
              end,
              desc = "Fix all",
            },
            {
              "]]",
              function()
                Snacks.words.jump(vim.v.count1)
              end,
              has = "documentHighlight",
              desc = "Next Reference",
              cond = function()
                return Snacks.words.is_enabled()
              end,
            },
            {
              "[[",
              function()
                Snacks.words.jump(-vim.v.count1)
              end,
              has = "documentHighlight",
              desc = "Prev Reference",
              cond = function()
                return Snacks.words.is_enabled()
              end,
            },
            {
              "<a-n>",
              function()
                Snacks.words.jump(vim.v.count1, true)
              end,
              has = "documentHighlight",
              desc = "Next Reference",
              cond = function()
                return Snacks.words.is_enabled()
              end,
            },
            {
              "<a-p>",
              function()
                Snacks.words.jump(-vim.v.count1, true)
              end,
              has = "documentHighlight",
              desc = "Prev Reference",
              cond = function()
                return Snacks.words.is_enabled()
              end,
            },
            {
              "<leader>lr",
              function()
                local inc_rename = require("inc_rename")
                return ":" .. inc_rename.config.cmd_name .. " " .. vim.fn.expand("<cword>")
              end,
              expr = true,
              desc = "Rename (inc-rename.nvim)",
              has = "rename",
            },
            {
              "gd",
              function()
                Snacks.picker.lsp_definitions()
              end,
              desc = "Goto Definition",
              has = "definition",
            },
            {
              "gr",
              function()
                Snacks.picker.lsp_references()
              end,
              nowait = true,
              desc = "References",
            },
            {
              "gI",
              function()
                Snacks.picker.lsp_implementations()
              end,
              desc = "Goto Implementation",
            },
            {
              "gy",
              function()
                Snacks.picker.lsp_type_definitions()
              end,
              desc = "Goto T[y]pe Definition",
            },
            {
              "<leader>fs",
              function()
                Snacks.picker.lsp_symbols({ filter = LazyVim.config.kind_filter })
              end,
              desc = "LSP Symbols",
              has = "documentSymbol",
            },
            {
              "<leader>fS",
              function()
                Snacks.picker.lsp_workspace_symbols({ filter = LazyVim.config.kind_filter })
              end,
              desc = "LSP Workspace Symbols",
              has = "workspace/symbols",
            },
          },
        },
        vtsls = {
          keys = {
            { "<leader>co", false },
            { "<leader>cM", false },
            { "<leader>cu", false },
            { "<leader>cD", false },
            { "<leader>cV", false },
            {
              "<leader>ri",
              LazyVim.lsp.action["source.removeUnused.ts"],
              desc = "Remove unused imports",
            },
            {
              "<leader>rI",
              LazyVim.lsp.action["source.organizeImports"],
              desc = "Organize Imports",
            },
            {
              "<leader>lo",
              LazyVim.lsp.action["source.addMissingImports.ts"],
              desc = "Add missing imports",
            },
            {
              "<leader>lD",
              LazyVim.lsp.action["source.fixAll.ts"],
              desc = "Fix all diagnostics",
            },
            {
              "<leader>rN",
              LazyVim.lsp.action["refactor.move.newFile"],
              desc = "Move to new file",
            },
            {
              "<leader>rV",
              function()
                LazyVim.lsp.execute({ command = "typescript.selectTypeScriptVersion" })
              end,
              desc = "Select TS workspace version",
            },
          },
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    keys = {
      { "<leader>cF", false },
      {
        "<leader>rF",
        function()
          require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
        end,
        mode = { "n", "x" },
        desc = "Format Injected Langs",
      },
    },
  },

  {
    "folke/trouble.nvim",
    optional = true,
    keys = {
      { "<leader>cs", false },
      { "<leader>cS", false },
      { "<leader>ls", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols (Trouble)" },
      { "<leader>lS", "<cmd>Trouble lsp toggle<cr>", desc = "LSP references/definitions/... (Trouble)" },
    },
  },

  {
    "MagicDuck/grug-far.nvim",
    optional = true,
    keys = {
      { "<leader>sr", false },
      {
        "<leader>lR",
        function()
          local grug = require("grug-far")
          local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
          grug.open({
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= "" and "*." .. ext or nil,
            },
          })
        end,
        mode = { "n", "v" },
        desc = "Search and Replace",
      },
    },
  },

  {
    "folke/noice.nvim",
    optional = true,
    keys = {
      { "<leader>sn", false },
      { "<leader>snl", false },
      { "<leader>snh", false },
      { "<leader>sna", false },
      { "<leader>snd", false },
      { "<leader>snt", false },

      { "<leader>fN", "", desc = "+noice" },
      {
        "<leader>fNl",
        function()
          require("noice").cmd("last")
        end,
        desc = "Noice Last Message",
      },
      {
        "<leader>fNh",
        function()
          require("noice").cmd("history")
        end,
        desc = "Noice History",
      },
      {
        "<leader>fNa",
        function()
          require("noice").cmd("all")
        end,
        desc = "Noice All",
      },
      {
        "<leader>fNd",
        function()
          require("noice").cmd("dismiss")
        end,
        desc = "Dismiss All",
      },
      {
        "<leader>fNt",
        function()
          require("noice").cmd("pick")
        end,
        desc = "Noice Picker (Telescope/FzfLua)",
      },
    },
  },

  {
    "mrcjkb/rustaceanvim",
    optional = true,
    opts = {
      server = {
        on_attach = function(_, bufnr)
          vim.keymap.set("n", "<leader>lR", function()
            vim.cmd.RustLsp("codeAction")
          end, { desc = "Code Action", buffer = bufnr })
          vim.keymap.set("n", "<leader>dr", function()
            vim.cmd.RustLsp("debuggables")
          end, { desc = "Rust Debuggables", buffer = bufnr })
        end,
      },
    },
  },

  {
    "iamcco/markdown-preview.nvim",
    optional = true,
    keys = {
      {
        "<leader>cp",
        false,
      },
      {
        "<leader>lp",
        ft = "markdown",
        "<cmd>MarkdownPreviewToggle<cr>",
        desc = "Markdown Preview",
      },
    },
  },

  {
    "mason-org/mason.nvim",
    optional = true,
    cmd = "Mason",
    keys = {
      { "<leader>cm", false },
      { "<leader>pm", "<cmd>Mason<cr>", desc = "Mason" },
    },
  },

  {
    "folke/todo-comments.nvim",
    optional = true,
    -- stylua: ignore
    keys = {
      { "<leader>st", false },
      { "<leader>sT", false },

      { "<leader>ft", function() Snacks.picker.todo_comments() end, desc = "Todo" },
      { "<leader>fT", function () Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" },
    },
  },

  {
    -- highlighting for chezmoi files template files
    "alker0/chezmoi.vim",
    optional = true,
    init = function()
      vim.g["chezmoi#use_tmp_buffer"] = 1
      vim.g["chezmoi#source_dir_path"] = os.getenv("HOME") .. "/.dotfiles"
    end,
  },
  {
    "xvzc/chezmoi.nvim",
    optional = true,
    cmd = { "ChezmoiEdit" },
    keys = {
      {
        "<leader>sz",
        false,
      },
      {
        "<leader>fz",
        function()
          if LazyVim.pick.picker.name == "telescope" then
            require("telescope").extensions.chezmoi.find_files()
          elseif LazyVim.pick.picker.name == "fzf" then
            local fzf_lua = require("fzf-lua")
            local actions = {
              ["enter"] = function(selected)
                fzf_lua.actions.vimcmd_entry("ChezmoiEdit", selected, { cwd = os.getenv("HOME") })
              end,
            }
            fzf_lua.files({ cmd = "chezmoi managed --include=files,symlinks", actions = actions, hidden = false })
          elseif LazyVim.pick.picker.name == "snacks" then
            local results = require("chezmoi.commands").list({
              args = {
                "--path-style",
                "absolute",
                "--include",
                "files",
                "--exclude",
                "externals",
              },
            })
            local items = {}

            for _, czFile in ipairs(results) do
              table.insert(items, {
                text = czFile,
                file = czFile,
              })
            end

            ---@type snacks.picker.Config
            local opts = {
              items = items,
              confirm = function(picker, item)
                picker:close()
                require("chezmoi.commands").edit({
                  targets = { item.text },
                  args = { "--watch" },
                })
              end,
            }
            Snacks.picker.pick(opts)
          end
        end,
        desc = "Chezmoi",
      },
    },
    init = function()
      -- run chezmoi edit on file enter
      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = { os.getenv("HOME") .. "/.dotfiles/*" },
        callback = function()
          vim.schedule(require("chezmoi.commands.__edit").watch)
        end,
      })
    end,
  },

  {
    "nvim-mini/mini.ai",
    optional = true,
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({ -- code block
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
          -- t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
          d = { "%f[%d]%d+" }, -- digits
          e = { -- Word with case
            { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
            "^().*()$",
          },
          g = LazyVim.mini.ai_buffer, -- buffer
          u = ai.gen_spec.function_call(), -- u for "Usage"
          U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
        },
      }
    end,
  },
}
