return {

  -- add pyright to lspconfig
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        pyright = {},
        stylua = {},
        lua_ls = {},
        bashls = {},
        jsonls = {
          settings = {
            json = {
              -- Esta desabilitado pois estou usando o plugin b0o/schemastore.nvim
              schemas = require("schemastore").json.schemas(),
              validate = { enable = true },
            },
          },
        },
        marksman = {},
        terraformls = {},
        tflint = {},
        yamlls = {
          settings = {
            yaml = {
              schemaStore = {
                -- Esta desabilitado pois estou usando o plugin b0o/schemastore.nvim
                enable = false,
                url = "",
              },
              schemas = require("schemastore").yaml.schemas(),
            },
          },
        },
      },
    },
  },
}
