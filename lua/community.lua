if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.pack.lua" },
    -- import/override with your plugins folder

    -- example of imporing a plugin, comment out to use it or add your own
    -- available plugins can be found at https://github.com/AstroNvim/astrocommunity
    { import = "astrocommunity.bars-and-lines.vim-illuminate" },
    { import = "astrocommunity.bars-and-lines.heirline-vscode-winbar" },

    { import = "astrocommunity.completion.copilot-lua-cmp" },

    { import = "astrocommunity.diagnostics.trouble-nvim" },

    { import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },

    { import = "astrocommunity.git.octo-nvim" },

    { import = "astrocommunity.media.vim-wakatime" },
    -- { import = "astrocommunity.media.presence-nvim" },

    { import = "astrocommunity.pack.bash" },
    { import = "astrocommunity.pack.rust" },
    { import = "astrocommunity.pack.astro" },
    { import = "astrocommunity.pack.lua" },
    { import = "astrocommunity.pack.cs" },
    { import = "astrocommunity.pack.kotlin" },
    { import = "astrocommunity.pack.full-dadbod" },
    { import = "astrocommunity.pack.docker" },
    { import = "astrocommunity.pack.json" },
    { import = "astrocommunity.pack.typescript" },
    { import = "astrocommunity.pack.yaml" },
    { import = "astrocommunity.pack.tailwindcss" },
    { import = "astrocommunity.pack.astro" },
    { import = "astrocommunity.pack.terraform" },
    { import = "astrocommunity.pack.prisma" },

    { import = "astrocommunity.scrolling.neoscroll-nvim" },

    { import = "astrocommunity.terminal-integration.vim-tpipeline" },

    { import = "astrocommunity.utility.noice-nvim" },

    { import = "astrocommunity.workflow.bad-practices-nvim" },

    { import = "astrocommunity.colorscheme.github-nvim-theme" },
}
