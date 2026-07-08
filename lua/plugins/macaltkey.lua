local uname = io.popen("uname"):read("*l")
if uname == "Linux" then
  return {}
end

--- @module 'lazy'
--- @type LazySpec
return {
  {
    "clvnkhr/macaltkey.nvim",
    opts = {
      language = "en-US", -- American
      -- or "en-GB" British. US is default

      modifier = "a",
      -- If this is a single char like 'y', then
      -- will convert <y-x> or <Y-x> (case insensitive) to the character at option-x.
      -- also accepts arbitrary strings, e.g. 'abc' will convert
      -- any of <a-x>, <b-x>, and <c-x> (case sensitive).

      -- Can be passed to the extra opts table of the
      -- convenience functions.

      double_set = false,
      -- If this is true, then will set both the converted
      -- and unconverted keybind, e.g. both <a-a> and å.
      -- Can be passed to the extra opts table of the
      -- convenience functions.
    },
  },
}
