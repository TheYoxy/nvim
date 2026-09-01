if true then
  return {
    { import = "lazyvim.plugins.extras.ai.sidekick" },
    { import = "lazyvim.plugins.extras.ai.supermaven" },
  }
end

--- @type LazySpec
return {
  {
    "milanglacier/minuet-ai.nvim",
    version = false,
    event = "InsertEnter",
    keys = {
      { "<leader>mp", "<cmd>Minuet duet predict<cr>", desc = "Minuet: predict next edit" },
      { "<leader>ma", "<cmd>Minuet duet apply<cr>", desc = "Minuet: apply next edit" },
      { "<leader>md", "<cmd>Minuet duet dismiss<cr>", desc = "Minuet: dismiss next edit" },
      { "<leader>mh", "<cmd>Minuet duet toggle<cr>", desc = "Minuet: toggle NES" },
    },
    opts = {
      provider = "openai_compatible",
      n_completions = 1,
      context_window = 4096,
      throttle = 400,
      debounce = 100,
      provider_options = {
        openai_compatible = {
          api_key = "TERM",
          name = "Ollama",
          end_point = "http://archlinux:11434/v1/chat/completions",
          model = "hf.co/mradermacher/Mellum2-12B-A2.5B-Base-i1-GGUF:Q5_K_S",
          optional = {
            max_tokens = 128,
            top_p = 0.9,
          },
        },
      },
    },
    config = function(_, opts)
      require("minuet").setup(opts)
      -- accept a highlighted minuet item with <Tab>, same as supermaven did
      LazyVim.cmp.actions.ai_accept = function()
        local ok, blink = pcall(require, "blink.cmp")
        if not ok then
          return
        end
        local ok_item, item = pcall(function()
          return blink.get_selected_item()
        end)
        if ok_item and item and item.kind_name == "Ollama" then
          blink.accept()
          return true
        end
      end
    end,
  },

  {
    "saghen/blink.cmp",
    optional = true,
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      opts.sources.default = opts.sources.default or {}
      table.insert(opts.sources.default, "minuet")
      opts.sources.providers = opts.sources.providers or {}
      opts.sources.providers.minuet = {
        name = "minuet",
        module = "minuet.blink",
        async = true,
        timeout_ms = 3000,
        score_offset = 50,
      }
      opts.completion = opts.completion or {}
      opts.completion.trigger = vim.tbl_deep_extend("force", opts.completion.trigger or {}, {
        prefetch_on_insert = false,
      })
    end,
  },
}
