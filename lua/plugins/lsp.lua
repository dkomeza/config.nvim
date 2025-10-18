return {
  "neovim/nvim-lspconfig",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",

  config = function()
    -- Mason setup
    require("mason").setup()

    local lspconfig = require("lspconfig")

    -- LSP keymaps (commented out for now)
    local on_attach = function(_, bufnr)
      -- local bufmap = function(mode, lhs, rhs, desc)
      --   vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
      -- end

      -- bufmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to Definition")
      -- bufmap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", "Go to Declaration")
      -- bufmap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", "References")
      -- bufmap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover Info")
      -- bufmap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename")
      -- bufmap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action")
      -- bufmap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Previous Diagnostic")
      -- bufmap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", "Next Diagnostic")
    end

    -- Capabilities (for autocompletion later)
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    -- Mason LSP automatic setup
    require("mason-lspconfig").setup({
      automatic_installation = true,
    })

    require("mason-lspconfig").setup_handlers({
      function(server_name) -- default handler for all servers
        lspconfig[server_name].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end,
    })
  end,
}

