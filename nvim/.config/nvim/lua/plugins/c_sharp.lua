vim.g.dotnet_build_project = function()
  local default_path = vim.fn.getcwd() .. "/"
  if vim.g["dotnet_last_proj_path"] ~= nil then
    default_path = vim.g["dotnet_last_proj_path"]
  end
  local path = vim.fn.input("Path to your *proj file", default_path, "file")
  vim.g["dotnet_last_proj_path"] = path
  local cmd = "dotnet build -c Debug " .. path .. " > /dev/null"
  print("")
  print("Cmd to execute: " .. cmd)
  local f = os.execute(cmd)
  if f == 0 then
    print("\nBuild: ✔️ ")
  else
    print("\nBuild: ❌ (code: " .. f .. ")")
  end
end

vim.g.dotnet_get_dll_path = function()
  local request = function()
    return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
  end

  if vim.g["dotnet_last_dll_path"] == nil then
    vim.g["dotnet_last_dll_path"] = request()
  else
    if vim.fn.confirm("Do you want to change the path to dll?\n" .. vim.g["dotnet_last_dll_path"], "&yes\n&no", 2) == 1 then
      vim.g["dotnet_last_dll_path"] = request()
    end
  end

  return vim.g["dotnet_last_dll_path"]
end

local includes = {
  { "Hoffs/omnisharp-extended-lsp.nvim", lazy = true },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "c_sharp" })
      end
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = opts.sources or {}
      table.insert(opts.sources, nls.builtins.formatting.csharpier)
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        cs = { "csharpier" },
      },
      formatters = {
        csharpier = {
          command = "dotnet-csharpier",
          args = { "--write-stdout" },
        },
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "netcoredbg", "csharpier", "omnisharp" })
      end
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        omnisharp = {
          handlers = {
            ["textDocument/definition"] = function(...)
              return require("omnisharp_extended").handler(...)
            end,
          },
          keys = {
            {
              "gd",
              function()
                require("omnisharp_extended").telescope_lsp_definitions()
              end,
              desc = "Goto Definition",
            },
          },
          enable_roslyn_analyzers = true,
          organize_imports_on_format = true,
          enable_import_completion = true,
        },
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    opts = function(_, opts)
      local dap = require("dap")
      dap.adapters["netcoredbg"] = {
        type = "executable",
        command = vim.fn.exepath("netcoredbg"),
        args = { "--interpreter=vscode" },
      }
      for _, lang in ipairs({ "cs", "fsharp", "vb" }) do
        dap.configurations[lang] = {
          {
            type = "netcoredbg",
            name = "Launch file",
            request = "launch",
            ---@diagnostic disable-next-line: redundant-parameter
            program = function()
              if vim.fn.confirm("Should I recompile first?", "&yes\n&no", 2) == 1 then
                vim.g.dotnet_build_project()
              end
              return vim.g.dotnet_get_dll_path()
            end,
            cwd = "${workspaceFolder}",
          },
        }
      end
    end,
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "issafalcon/neotest-dotnet",
    },
    opts = {
      adapters = {
        ["neotest-dotnet"] = {},
      },
    },
  },
}

local modules = require("config.modules")
if not modules.c_sharp then
  includes = {}
end
return includes
