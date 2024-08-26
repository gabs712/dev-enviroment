return {
  'windwp/nvim-autopairs',
  event = "InsertEnter",
  config = function()
    require('nvim-autopairs').setup({
      disable_filetype = {
        'TelescopePrompt', 
        'spectre_panel',
        'harpoon',
      },
      disable_in_macro = false,
    })
  end
}
