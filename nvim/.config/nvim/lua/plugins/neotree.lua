return {
  "nvim-neo-tree/neo-tree.nvim",
  -- event = "VeryLazy",
  branch = "v3.x",
  keys = {
    { "<leader>E", ":Neotree reveal toggle<CR>" },
    {
      "<leader>tf",
      function()
        local currBuffer = vim.api.nvim_buf_get_name(0)
        vim.cmd("Neotree reveal_file=" .. currBuffer)
      end,
    },
  },
  opts = {
    filesystem = {
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_by_name = {
          ".git",
          ".DS_Store",
          "thumbs.db",
        },
      },
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
}
