-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  -- import/override with your plugins folder

  -- example of imporing a plugin, comment out to use it or add your own
  -- available plugins can be found at https://github.com/AstroNvim/astrocommunity
  { import = "astrocommunity.bars-and-lines.vim-illuminate" },

  { import = "astrocommunity.color.modes-nvim" },

  { import = "astrocommunity.completion.copilot-lua-cmp" },

  { import = "astrocommunity.diagnostics.trouble-nvim" },

  { import = "astrocommunity.editing-support.conform-nvim" },
  { import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },
  { import = "astrocommunity.editing-support.treesj" },
  { import = "astrocommunity.editing-support.nvim-devdocs" },

  -- { import = "astrocommunity.fuzzy-finder.fzf-lua" },

  { import = "astrocommunity.git.octo-nvim" },

  -- { import = "astrocommunity.lsp.action-preview-nvim" },
  { import = "astrocommunity.lsp.nvim-lint" },
  { import = "astrocommunity.keybinding.nvcheatsheet-nvim" },

  -- { import = "astrocommunity.media.image-nvim" },
  { import = "astrocommunity.media.presence-nvim" },
  { import = "astrocommunity.media.vim-wakatime" },

  { import = "astrocommunity.pack.astro" },
  { import = "astrocommunity.pack.ansible" },
  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.docker" },
  -- { import = "astrocommunity.pack.full-dadbod" },
  { import = "astrocommunity.pack.helm" },
  { import = "astrocommunity.pack.json" },
  -- { import = "astrocommunity.pack.kotlin" },
  -- { import = "astrocommunity.pack.go" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.nix" },
  { import = "astrocommunity.pack.prisma" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.tailwindcss" },
  { import = "astrocommunity.pack.terraform" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.yaml" },

  { import = "astrocommunity.recipes.heirline-nvchad-statusline" },

  { import = "astrocommunity.scrolling.neoscroll-nvim" },

  -- { import = "astrocommunity.terminal-integration.vim-tpipeline" },

  { import = "astrocommunity.utility.noice-nvim" },

  -- { import = "astrocommunity.workflow.bad-practices-nvim" },
}
