--- Tailwind class-aware highlighting configuration.
---
--- `kinds` lives in lua/tailwind_classes/kinds.lua and is derived from the
--- Tailwind CSS v4 docs (https://tailwindcss.com/docs/), minus color utilities.
--- Extend it there, with `register_kind`, or by passing `opts.kinds`.

local kinds = require("tailwind_classes.kinds")

--- @class TailwindKind
--- @field name string Kind label; highlight group defaults to `@tailwind.<name>`.
--- @field exact? string[] Class names matched literally.
--- @field prefix? string[] Class names matched by prefix (longest prefix wins).
--- @field hl? string Explicit highlight group override.

--- @class TailwindClassesConfig
--- @field enabled boolean Master switch.
--- @field priority integer Extmark priority; must beat the surrounding string capture.
--- @field attributes table<string, boolean> JSX attributes whose string value is a class list.
--- @field functions table<string, boolean> Functions whose string arguments are class lists.
--- @field kinds TailwindKind[] Ordered list of class kinds.
--- @field palette string[] Highlight groups cycled across kinds for default colours.
--- @field highlights table<string, vim.api.keyset.highlight> Explicit group overrides, keyed by group name.
--- @field classify? fun(token: string, ctx: string?): TailwindKind? Optional full override of the classifier.

return {
  tailwind_classes = {
    enabled = true,
    priority = 128,

    attributes = {
      class = true,
      className = true,
      classList = true,
    },

    functions = {
      cva = true,
      cn = true,
      clsx = true,
      classNames = true,
      twMerge = true,
    },

    kinds = kinds,

    -- Default colours cycle through these groups, so neighbouring kinds differ.
    -- Override any individual kind via `highlights` or by setting `hl` on it.
    palette = {
      "@number",
      "@keyword",
      "@function",
      "@constant",
      "@string",
      "@type",
      "@property",
      "@operator",
      "@variable",
      "@punctuation",
      "@attribute",
      "@label",
    },

    highlights = {},
  },
}
