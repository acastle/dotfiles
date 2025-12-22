local defaults = {
  lua = true,
}

local status_ok, overrides = pcall(require, "config/overrides")
if not status_ok then
  return defaults
end
return vim.tbl_deep_extend("force", defaults, overrides)
