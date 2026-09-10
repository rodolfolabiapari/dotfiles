-- nvim-lspconfig: configura os servidores de linguagem (LSP) que rodam no
-- Neovim: autocomplete, diagnóstico, hover (K), go-to-definition (gd), rename.
-- Cada servidor declarado aqui é instalado via Mason automaticamente.
--
-- Destaques:
-- - jsonls + SchemaStore → schemas de JSON (incluindo K8s)
-- - yamlls + SchemaStore → schemas de YAML (kind:, apiVersion: autocompletam)
-- - marksman → LSP de markdown (links, headings)
-- - terraformls + tflint → validação de Terraform/HCL
-- - pyright → Python type checking

return {
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
