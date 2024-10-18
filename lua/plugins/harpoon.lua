return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require('harpoon')
    harpoon:setup({
      settings = {
        save_on_toggle = true,
      },
    })

    vim.keymap.set('n', '<Tab>', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Harpoon marks' })
    vim.keymap.set('n', '<C-m>', function()
      harpoon:list():add()
      print('Harpoon mark settled ' .. os.date('%H:%M:%S'))
    end, { desc = 'Set harpoon mark' })

    vim.keymap.set('n', '<C-l>', function()
      harpoon:list():select(1)
    end, { desc = 'Go to harpoon mark 1' })
    vim.keymap.set('n', '<C-k>', function()
      harpoon:list():select(2)
    end, { desc = 'Go to harpoon mark 2' })
    vim.keymap.set('n', '<C-j>', function()
      harpoon:list():select(3)
    end, { desc = 'Go to harpoon mark 3' })
    vim.keymap.set('n', '<C-h>', function()
      harpoon:list():select(4)
    end, { desc = 'Go to harpoon mark 4' })

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'harpoon',
      callback = function()
        local current = vim.api.nvim_get_current_buf()

        vim.keymap.set('n', '-', '<Nop>', { buffer = current })
      end,
    })
  end,
}
