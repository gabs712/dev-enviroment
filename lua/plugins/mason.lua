return {
  'williamboman/mason.nvim', -- The package manager
  dependencies = {
    'williamboman/mason-lspconfig.nvim', -- Allow lspconfig server names
    'WhoIsSethDaniel/mason-tool-installer.nvim', -- API to ensure that mason installs packages
  },
  config = function()
    require('mason').setup()
    require('mason-lspconfig').setup() -- Must be setup after mason

    require('mason-tool-installer').setup({
      ensure_installed = {
        -- Language servers
        'ts_ls',
        'lua_ls',
        'tailwindcss',

        -- Formatters
        'prettier',
        'stylua',
      },
    })
  end,
}