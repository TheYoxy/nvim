-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Cap every log in stdpath("log") at 5 MB, keeping the newest bytes.
-- Neovim has no rotation: vim.lsp.log opens its file with io.open(path, "a+") and
-- appends forever (lsp.log reached 366 MB here), so the head gets dropped instead.
-- This runs at load rather than from an autocmd: config/autocmds.lua is only sourced
-- inside LazyVim's `User VeryLazy` callback when nvim starts with no arguments, which
-- is after VimEnter, so an autocmd registered there never fires.
-- shortcut: once per startup, so a long-running session can exceed 5 MB until restart;
-- add a FocusGained autocmd calling trim_logs() if that matters.
local MAX_LOG_SIZE = 5 * 1024 * 1024

local function trim_log(path)
  local stat = vim.uv.fs_stat(path)
  if not stat or stat.type ~= "file" or stat.size <= MAX_LOG_SIZE then
    return
  end

  local src = io.open(path, "rb")
  if not src then
    return
  end
  src:seek("end", -MAX_LOG_SIZE)
  local tail = src:read(MAX_LOG_SIZE)
  src:close()

  -- Skip the partial first line so the file doesn't start mid-entry.
  local nl = tail and tail:find("\n", 1, true)
  if nl then
    tail = tail:sub(nl + 1)
  end

  -- Rewriting in place is safe while a session holds an O_APPEND handle: its later
  -- writes land at the new end of file.
  local dst = io.open(path, "wb")
  if not dst then
    return
  end
  dst:write(tail)
  dst:close()
end

local function trim_logs()
  local dir = vim.fn.stdpath("log")
  for name, kind in vim.fs.dir(dir) do
    if kind == "file" then
      trim_log(vim.fs.joinpath(dir, name))
    end
  end
end

trim_logs()

local uname = io.popen("uname"):read("*l")
if uname == "linux" then
  require("config.remote_clipboard").setup()
end

-- Prepend mise shims to PATH
vim.env.PATH = vim.env.HOME .. "/.local/share/mise/shims:" .. vim.env.PATH

if vim.fn.getenv("TERM_PROGRAM") == "ghostty" then
  vim.opt.title = true
  vim.opt.titlestring = "%{fnamemodify(getcwd(), ':t')}"
end

-- vim.g.root_spec = { "lsp", { ".git", "lua" }, { "package.json", "tsconfig.json" }, "cwd" }
vim.g.root_spec = { ".git", ".obsidian", "cwd" }
vim.opt.laststatus = 3
vim.opt.so = 999 -- Lines of context
-- vim.opt.ss = 1 -- Columns of context
-- vim.opt.siso = 0 -- Columns of context
vim.o.numberwidth = 1
vim.o.ruler = false
vim.o.swapfile = false

vim.filetype.add({
  extension = {
    props = "xml",
    csproj = "xml",
    editorconfig = "editorconfig",
    slnx = "xml",
    tmpl = "gotmpl",
    cod = "coda",
    coda = "coda",
  },
  pattern = {
    [".*/hypr/.*%.conf"] = "hyprlang",
    [".zsh"] = "sh",
    [".zshenv"] = "sh",
    [".zsh/.*%.zsh"] = "sh",
  },
})

require("colorify").run()

table.insert(vim.opt.spelllang, "fr")
vim.opt.list = true -- Show some invisible characters (tabs...
vim.opt.listchars = {
  -- space = ".",
  -- eol = "$",
  -- tab = ">-",
  nbsp = "\\x24",
}
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.lazyvim_prettier_needs_config = true
vim.g.lazyvim_check_order = false

-- vim.lsp.config("fallow", {
--   cmd = { "fallow-lsp" },
--   filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
--   root_markers = { ".fallowrc.json", "package.json", ".git" },
--   init_options = {
--     -- Every issue type is enabled by default. List only the ones you
--     -- want to turn off; any key you omit stays enabled.
--     -- issueTypes = {
--     --   ["circular-dependencies"] = false,
--     -- },
--   },
-- })
--
-- vim.lsp.enable("fallow")
