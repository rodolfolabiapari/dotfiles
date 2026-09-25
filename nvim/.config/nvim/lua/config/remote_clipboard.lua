-- Unified clipboard provider. Detects the OS at runtime and picks the right
-- local clipboard backend, while every yank is also emitted as OSC 52 when
-- running inside tmux/SSH/herdr (so remote clients receive it). Paste prefers
-- the local clipboard when available; otherwise it falls back to an OSC 52
-- query answered by the terminal/tmux.
--
-- Backends:
--   macOS          : pbcopy / pbpaste
--   Linux Wayland  : wl-copy / wl-paste
--   Linux X11      : xclip / xsel
local M = {}

local function proc_lines(pid, file)
  local ok, lines = pcall(vim.fn.readfile, "/proc/" .. pid .. "/" .. file)
  return ok and lines or {}
end

local function proc_ppid(pid)
  for _, line in ipairs(proc_lines(pid, "status")) do
    local ppid = line:match("^PPid:%s+(%d+)")
    if ppid then
      return tonumber(ppid)
    end
  end
end

local function ancestor_process_named(name)
  local pid = vim.fn.getpid()

  for _ = 1, 16 do
    local ppid = proc_ppid(pid)
    if not ppid or ppid <= 1 then
      return false
    end

    local comm = proc_lines(ppid, "comm")[1] or ""
    if comm:find(name, 1, true) then
      return true
    end

    pid = ppid
  end

  return false
end

local function is_macos()
  local ok, uname = pcall(vim.uv.os_uname)
  return ok and uname and uname.sysname == "Darwin"
end

local function executable(cmd)
  return vim.fn.executable(cmd) == 1
end

-- Resolve the local clipboard backend for this OS, or nil if none is usable.
-- Returns { copy_cmd, paste_cmd, is_x11 }. `is_x11` marks backends whose
-- stdout semantics differ from the (Wayland/macOS) --primary flag model.
local function resolve_backend()
  if is_macos() then
    if executable("pbcopy") and executable("pbpaste") then
      return { copy = { "pbcopy" }, paste = { "pbpaste" } }
    end
    return nil
  end

  if not (vim.uv.os_uname().sysname == "Linux") then
    return nil
  end

  if vim.env.WAYLAND_DISPLAY ~= nil and executable("wl-copy") and executable("wl-paste") then
    return { copy = { "wl-copy", "--sensitive", "--type", "text/plain" }, paste = { "wl-paste", "--no-newline" } }
  end

  if executable("xsel") then
    return { copy = { "xsel", "--clipboard", "--input" }, paste = { "xsel", "--clipboard", "--output" } }
  end

  if executable("xclip") then
    return {
      copy = { "xclip", "-selection", "clipboard" },
      paste = { "xclip", "-selection", "clipboard", "-out" },
    }
  end

  return nil
end

function M.setup()
  local in_tmux = vim.env.TMUX ~= nil
  local in_ssh = vim.env.SSH_TTY ~= nil or vim.env.SSH_CONNECTION ~= nil
  local in_herdr = vim.env.HERDR_PANE_ID ~= nil or ancestor_process_named("herdr")

  local remote = in_tmux or in_ssh or in_herdr
  local backend = resolve_backend()

  -- Nothing usable locally and not in a remote session: leave the core
  -- clipboard untouched so `unnamedplus` can still work as a fallback.
  if backend == nil and not remote then
    return
  end

  local osc52 = require("vim.ui.clipboard.osc52")

  local function copy(register)
    local emit = osc52.copy(register)

    return function(lines)
      if backend then
        local cmd = vim.deepcopy(backend.copy)
        if register == "*" and vim.env.WAYLAND_DISPLAY ~= nil then
          cmd[#cmd + 1] = "--primary"
        end
        vim.fn.system(cmd, lines)
      end

      if remote and vim.g.omarchy_remote_clipboard_osc52 ~= false then
        emit(lines)
      end
    end
  end

  local function paste(register)
    local _ = register
    if backend then
      return function()
        local lines = vim.fn.systemlist(backend.paste, "", 1)
        return vim.v.shell_error == 0 and lines or {}
      end
    end

    return function()
      return osc52.paste("+")
    end
  end

  vim.g.clipboard = {
    name = "OmarchyClipboard",
    copy = { ["+"] = copy("+"), ["*"] = copy("*") },
    paste = { ["+"] = paste("+"), ["*"] = paste("*") },
    cache_enabled = 0,
  }
end

return M
