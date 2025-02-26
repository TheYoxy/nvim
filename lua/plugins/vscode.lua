if not vim.g.vscode then
  return {}
end

local enabled = {
  "LazyVim",
  "dial.nvim",
  "flit.nvim",
  "lazy.nvim",
  "leap.nvim",
  "mini.ai",
  "mini.comment",
  "mini.move",
  "mini.pairs",
  "mini.surround",
  "nvim-treesitter",
  "nvim-treesitter-textobjects",
  "nvim-ts-context-commentstring",
  "snacks.nvim",
  "ts-comments.nvim",
  "vim-repeat",
  "yanky.nvim",
}

local Config = require("lazy.core.config")
Config.options.checker.enabled = false
Config.options.change_detection.enabled = false
Config.options.defaults.cond = function(plugin)
  return vim.tbl_contains(enabled, plugin.name) or plugin.vscode
end
vim.g.snacks_animate = false

-- Add some vscode specific keymaps
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimKeymapsDefaults",
  callback = function()
    -- VSCode-specific keymaps for search and navigation
    vim.keymap.set("n", "<leader><space>", "<cmd>Find<cr>")
    vim.keymap.set("n", "<leader>/", [[<cmd>lua require('vscode').action('workbench.action.findInFiles')<cr>]])
    vim.keymap.set("n", "<leader>fs", [[<cmd>lua require('vscode').action('workbench.action.gotoSymbol')<cr>]])

    -- Keep undo/redo lists in sync with VsCode
    vim.keymap.set("n", "u", "<Cmd>call VSCodeNotify('undo')<CR>")
    vim.keymap.set("n", "<C-r>", "<Cmd>call VSCodeNotify('redo')<CR>")

    -- Navigate VSCode tabs like lazyvim buffers
    vim.keymap.set("n", "<S-h>", "<Cmd>call VSCodeNotify('workbench.action.previousEditor')<CR>")
    vim.keymap.set("n", "<S-l>", "<Cmd>call VSCodeNotify('workbench.action.nextEditor')<CR>")

    local vscode = require("vscode-neovim")
    vim.notify = require("vscode-neovim").notify

    -- vim.keymap.set({ "n" }, "<leader>", function() vscode.action "whichkey.show" end, { noremap = false, remap = true })
    -- vim.keymap.set({ "n", "x", "i" }, "<C-g>", function() vscode.action "editor.action.addSelectionToNextFindMatch" end)
    -- vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = "Move cursor down" })
    -- vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = "Move cursor up" })

    -- vim.keymap.set("n", "+", "<c-a>", { desc = "Increment number", noremap = true })
    -- vim.keymap.set("n", "-", "<c-x>", { desc = "Decrement number", noremap = true })

    -- vim.keymap.set("n", "za", function()
    --   vscode.action "editor.fold"
    -- end, { desc = "Toggle fold" })

    vim.keymap.set(
      "n",
      "<leader>si",
      [[<cmd>lua require('vscode').action('vscode-neovim.restart')<cr>]],
      { desc = "Restart vscode" }
    )

    vim.keymap.set(
      "n",
      "<leader>gg",
      [[<cmd>lua require('vscode').action('lazygit-vscode.toggle')<cr>]],
      { desc = "Toggle lazygit" }
    )
  end,
})

function LazyVim.terminal()
  require("vscode").action("workbench.action.terminal.toggleTerminal")
end

return {
  {
    "snacks.nvim",
    opts = {
      bigfile = { enabled = false },
      dashboard = { enabled = false },
      indent = { enabled = false },
      input = { enabled = false },
      notifier = { enabled = false },
      picker = { enabled = false },
      quickfile = { enabled = false },
      scroll = { enabled = false },
      statuscolumn = { enabled = false },
    },
  },
  {
    name = "my-lazy/custom_nvim",
    dir = vim.fn.stdpath("config") .. "/lua/my-lazy",
    config = function(_, opts)
      opts = opts or {}
      -- disable the colorscheme
      opts.colorscheme = function() end
      require("my-lazy.init").setup(opts)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { highlight = { enable = false } },
  },
}
