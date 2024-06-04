return  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
    },
    keys = {
      { "<leader>ldo", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
      { "<leader>ldc", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
      { "<leader>ldt", "<cmd>DiffviewToggleFiles<cr>", desc = "Toggle Diffview Files" },
      { "<leader>ldf", "<cmd>DiffviewFocusFiles<cr>", desc = "Focus Diffview Files" },
    },
    config = function()
      require("diffview").setup{}
    end,
}
