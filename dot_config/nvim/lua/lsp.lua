vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      workspace = {
        checkThirdParty = false,
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = { enable = false },
      diagnostics = { globals = { "vim" } },
    },
  },
})

local enabled_servers = {
  "lua_ls",
  "basedpyright",
  "ts_ls",
  "gopls",
  "rust_analyzer",
  "taplo",
  "jsonls",
  "yamlls",
  "bashls",
  "html",
  "cssls",
}
vim.lsp.enable(enabled_servers)

vim.diagnostic.config({
  severity_sort = true,
  underline = { severity = vim.diagnostic.severity.ERROR },
  update_in_insert = false,
  virtual_text = {
    spacing = 4,
    source = "if_many",
    prefix = "●",
  },
  float = {
    border = "rounded",
    source = "if_many",
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "✘",
      [vim.diagnostic.severity.WARN] = "▲",
      [vim.diagnostic.severity.HINT] = "⚑",
      [vim.diagnostic.severity.INFO] = "»",
    },
  },
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
  callback = function(args)
    local buf = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
    end

    -- Goto
    map("n", "gd", vim.lsp.buf.definition, "Goto definition")
    map("n", "gD", vim.lsp.buf.declaration, "Goto declaration")
    map("n", "gy", vim.lsp.buf.type_definition, "Goto type definition")
    map("n", "gI", vim.lsp.buf.implementation, "Goto implementation")
    map("n", "gr", vim.lsp.buf.references, "References")

    -- Help
    map("n", "K", vim.lsp.buf.hover, "Hover")
    map("n", "gK", vim.lsp.buf.signature_help, "Signature help")

    -- Code actions / rename / format
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
    map("n", "<leader>cr", vim.lsp.buf.rename, "Rename")
    map({ "n", "v" }, "<leader>cf", function()
      vim.lsp.buf.format({ async = true })
    end, "Format")

    -- Inlay hints toggle (if server supports it)
    if client and client:supports_method("textDocument/inlayHint") then
      map("n", "<leader>uh", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = buf }), { bufnr = buf })
      end, "Toggle inlay hints")
    end
  end,
})
