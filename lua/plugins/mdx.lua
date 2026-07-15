if true then
  return {}
end

--- @type LazySpec
return {
  {
    "davidmh/mdx.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", opts = { ensure_installed = { "markdown" } } },
  },
}
