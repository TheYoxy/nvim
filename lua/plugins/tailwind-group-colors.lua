--- @type LazySpec
return {
  {
    -- Colour Tailwind classes by utility family (Tree-sitter, no grammar).
    "TheYoxy/tailwind-group-colors.nvim",
    -- Must be on the rtp before Tree-sitter highlights the first buffer.
    lazy = false,
    main = "tailwind-group-colors",
    opts = {},
  },
}
