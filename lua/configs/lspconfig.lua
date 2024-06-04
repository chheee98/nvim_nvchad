-- -- EXAMPLE
-- local on_attach = require("nvchad.configs.lspconfig").on_attach
-- local on_init = require("nvchad.configs.lspconfig").on_init
-- local capabilities = require("nvchad.configs.lspconfig").capabilities
--
-- local lspconfig = require "lspconfig"
-- local servers = { "html", "cssls" }
--
-- -- lsps with default config
-- for _, lsp in ipairs(servers) do
--   lspconfig[lsp].setup {
--     on_attach = on_attach,
--     on_init = on_init,
--     capabilities = capabilities,
--   }
-- end
--
-- -- typescript
-- lspconfig.tsserver.setup {
--   on_attach = on_attach,
--   on_init = on_init,
--   capabilities = capabilities,
-- }
--
local M = {}

local lspconfig = require("lspconfig")
local on_init = require("nvchad.configs.lspconfig").on_init
local cmp_nvim_lsp = require("cmp_nvim_lsp")

-- Define capabilities
M.capabilities = cmp_nvim_lsp.default_capabilities()

-- Define on_attach function
M.on_attach = function(client, bufnr)
  -- Your custom on_attach functionality
  local opts = { noremap = true, silent = true, buffer = bufnr }
  -- vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  -- Add other keymaps here if needed
end

-- Add the LspAttach autocommand
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.schedule(function()
      local bufnr = args.buf
      local opts = { noremap = true, silent = true, buffer = bufnr }
      -- vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
      -- Add other keymaps here if needed
    end)
  end,
})
-- lsps with default config
local servers = { "html", "cssls", "tsserver", "pyright" }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = M.on_attach,
    on_init = on_init,
    capabilities = M.capabilities,
  }
end

-- Configure LSP servers
lspconfig.pyright.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
}

return M
