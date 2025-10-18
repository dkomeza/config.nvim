return {
  "williamboman/mason.nvim",
  -- always load Mason on startup
  lazy = false,
  config = function()
    require("mason").setup()
  end,
}

