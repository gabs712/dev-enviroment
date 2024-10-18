return {
  'mbbill/undotree',
  config = function()
    require('custom.helpers').free_ft_ctrl('undotree')

    vim.g.undotree_WindowLayout = 3
    vim.g.undotree_SplitWidth = 44
    vim.g.undotree_DiffAutoOpen = 0 -- 0, 1
    vim.g.undotree_SetFocusWhenToggle = 0
    vim.g.undotree_ShortIndicators = 0 -- s, h, m, etc
    vim.g.undotree_HighlightChangedText = 0
    vim.g.undotree_HelpLine = 1

    vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'Undotree' })

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'undotree',
      callback = function()
        local current = vim.api.nvim_get_current_buf()

        vim.keymap.set('n', '<C-->', '<plug>UndotreePreviousState', { buffer = current })
        vim.keymap.set('n', '<C-=>', '<plug>UndotreeNextState', { buffer = current })
      end,
    })
  end,
}
