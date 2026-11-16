-- Files `mise lsp` serves: it ignores every other TOML file.
return function(bufnr)
  local filepath = vim.fs.normalize(vim.api.nvim_buf_get_name(tonumber(bufnr) or 0))
  local filename = vim.fn.fnamemodify(filepath, ":t")
  return filename:match("^%.?mise.*%.toml$") ~= nil
    or filepath:match("/%.?mise/config%.toml$") ~= nil
    or filepath:match("/%.?mise/config%.local%.toml$") ~= nil
    or filepath:match("/%.?mise/config%.[^/]+%.toml$") ~= nil
    or filepath:match("/%.config/mise/mise%.toml$") ~= nil
    or filepath:match("/%.config/mise/mise%.local%.toml$") ~= nil
    or filepath:match("/%.?mise/conf%.d/[^/]+%.toml$") ~= nil
end
