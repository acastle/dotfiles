return {
  {
    "nvim-neotest/neotest",
    opts = {},
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-dotnet"),
        },
      })
    end,
    dependencies = {
      "Issafalcon/neotest-dotnet",
    },
  },
}
