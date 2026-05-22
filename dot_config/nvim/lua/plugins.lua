vim.pack.add({
  { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
  { src = "https://github.com/nvim-mini/mini.icons" },
  { src = "https://github.com/nvim-mini/mini.ai" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/ibhagwan/fzf-lua" },
  { src = "https://github.com/stevearc/oil.nvim" },
})

require("catppuccin").setup({
  flavour = "mocha",
  integrations = {
    fzf = true,
    treesitter = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
      },
      underlines = {
        errors = { "underline" },
        hints = { "underline" },
        warnings = { "underline" },
        information = { "underline" },
      },
    },
  },
})
vim.cmd.colorscheme("catppuccin-mocha")

require("mini.icons").setup()
MiniIcons.mock_nvim_web_devicons()

require("mini.ai").setup({
  n_lines = 500,
})

local ts = require("nvim-treesitter")
ts.setup({
  install_dir = vim.fn.stdpath("data") .. "/site",
})

local parsers = {
  "bash", "c", "css", "diff", "go", "html", "javascript", "json",
  "lua", "luadoc", "markdown", "markdown_inline", "python", "query",
  "regex", "rust", "toml", "tsx", "typescript", "vim", "vimdoc", "yaml",
}

local installed = ts.get_installed("parsers")
local to_install = vim.tbl_filter(function(p)
  return not vim.tbl_contains(installed, p)
end, parsers)
if #to_install > 0 then
  ts.install(to_install)
end

vim.api.nvim_create_autocmd("FileType", {
  callback = function(ev)
    local ft = vim.bo[ev.buf].filetype
    local lang = vim.treesitter.language.get_lang(ft)
    if lang and pcall(vim.treesitter.start, ev.buf, lang) then
      vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})

require("fzf-lua").setup({ "default-title" })
require("oil").setup({
  default_file_explorer = true,
  delete_to_trash = true,
 bskip_confirm_for_simple_edits = true,
  view_options = {
    show_hidden = true,
  },
  keymaps = {
    ["g?"] = { "actions.show_help", mode = "n" },
    ["<CR>"] = "actions.select",
    ["<C-v>"] = { "actions.select", opts = { vertical = true } },
    ["<C-x>"] = { "actions.select", opts = { horizontal = true } },
    ["<C-t>"] = { "actions.select", opts = { tab = true } },
    ["<C-p>"] = "actions.preview",
    ["<C-c>"] = { "actions.close", mode = "n" },
    ["<C-l>"] = "actions.refresh",
    ["-"] = { "actions.parent", mode = "n" },
    ["_"] = { "actions.open_cwd", mode = "n" },
    ["`"] = { "actions.cd", mode = "n" },
    ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
    ["gs"] = { "actions.change_sort", mode = "n" },
    ["gx"] = "actions.open_external",
    ["g."] = { "actions.toggle_hidden", mode = "n" },
    ["g\\"] = { "actions.toggle_trash", mode = "n" },
  },
})
