-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Workaround for hashicorp/terraform-ls#2039",
  group = vim.api.nvim_create_augroup("terraformls", {}),
  pattern = { "*.tf", "*.tfvars" },
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    if client.name ~= "tofu_ls" then
      return
    end

    local root_dir = client.config.root_dir
    if not root_dir or vim.fs.dirname(ev.file) == root_dir then
      return
    end

    vim.schedule(function()
      local root_level_file = vim.fn.glob(vim.fs.joinpath(root_dir, "*.tf"), true, true)[1]
      if root_level_file then
        vim.fn.bufload(vim.fn.bufadd(root_level_file))
      end
    end)
  end,
})
