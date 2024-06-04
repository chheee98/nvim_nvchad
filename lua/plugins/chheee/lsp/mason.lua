return {
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "jose-elias-alvarez/null-ls.nvim", -- Add null-ls.nvim as a dependency
    "nvim-lua/plenary.nvim", -- null-ls.nvim dependency
  },
  config = function()
    -- import mason
    local mason = require("mason")

    -- Check if mason-lspconfig is properly installed
    local status, mason_lspconfig = pcall(require, "mason-lspconfig")
    if not status then
      vim.notify("mason-lspconfig not found!")
      return
    end

    local mason_tool_installer = require("mason-tool-installer")

    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "?",
          package_pending = "?",
          package_uninstalled = "?",
        },
      },
    })

    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        "tsserver",
        "html",
        "cssls",
        "tailwindcss",
        "svelte",
        "lua_ls",
        "graphql",
        "emmet_ls",
        "prismals",
        "pyright",
      },
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "prettier", -- prettier formatter
        "stylua", -- lua formatter
        "isort", -- python formatter
        "eslint_d",
        "ruff", -- Python linter
        "black", -- Python formatter
        "pylint", -- Python linter
      },
      auto_update = true,
      run_on_start = true,
    })

    -- null-ls setup
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.diagnostics.ruff,
        null_ls.builtins.formatting.black,
        null_ls.builtins.diagnostics.pylint.with({
          extra_args = { "--disable=C0114,C0115,C0116" }, -- Customize pylint args if needed
        }),
      },
    })

    -- Automatically install/upgrade packages on startup
    vim.api.nvim_create_autocmd("User", {
      pattern = "MasonToolsUpdateCompleted",
      callback = function()
        print("Mason tools updated!")
      end,
    })
  end,
}
