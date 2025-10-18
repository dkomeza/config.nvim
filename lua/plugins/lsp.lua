return {
  "neovim/nvim-lspconfig",
  "williamboman/mason-lspconfig.nvim",
  config = function()
    local lspconfig = require("lspconfig")

    -- LSP keymaps can be empty for now
    local on_attach = function(_, bufnr) end

    -- capabilities placeholder (for completion later)
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    -- Mason-lspconfig setup
    require("mason-lspconfig").setup({
      automatic_installation = true,
    })

    require("mason-lspconfig").setup_handlers({
      function(server_name) -- default handler
        lspconfig[server_name].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end,
    })
  end,
}

