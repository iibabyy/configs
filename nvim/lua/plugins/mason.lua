return {
  "mason-org/mason.nvim",
  build = ":MasonUpdate",

  -- So lazy loads mason only when entering these commands
  cmd = {
    "Mason",
    "MasonInstall",
    "MasonUninstall",
    "MasonUninstallAll",
    "MasonLog",
  },

  keys = {
    { "<leader>m", "<cmd>Mason<cr>", desc = "Open Mason" },
  },
}
