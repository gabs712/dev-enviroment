return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = 'nvim-treesitter/nvim-treesitter-textobjects',
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = {
        'tsx',
        'lua',
        'javascript',
        'html',
        'css',
        'typescript',
        'vim',
        'vimdoc',
        'bash',
        'regex',
        'markdown',
        'markdown_inline',
        'yaml',
        'toml',
      },

      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },

      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Jump to next ocurrence if not inside any

          keymaps = {
            ['iv'] = { query = '@assignment.inner', desc = 'Select inside variable' },
            ['av'] = { query = '@assignment.outer', desc = 'Select around variable' },
            ['lv'] = { query = '@assignment.lhs', desc = 'Select left variable' },
            ['rv'] = { query = '@assignment.rhs', desc = 'Select right variable' },

            ['if'] = { query = '@function.inner', desc = 'Select inside function' },
            ['af'] = { query = '@function.outer', desc = 'Select around function' },

            ['im'] = { query = '@call.inner', desc = 'Select inside function call (method)' },
            ['am'] = { query = '@call.outer', desc = 'Select around function call (method)' },

            ['il'] = { query = '@loop.inner', desc = 'Select inside loop' },
            ['al'] = { query = '@loop.outer', desc = 'Select around loop' },

            ['ii'] = { query = '@conditional.inner', desc = 'Select inside conditional (if)' },
            ['ai'] = { query = '@conditional.outer', desc = 'Select around conditional (if)' },

            ['ic'] = { query = '@class.inner', desc = 'Select inside class' },
            ['ac'] = { query = '@class.outer', desc = 'Select around class' },

            ['ia'] = { query = '@parameter.inner', desc = 'Select inside argument or parameter' },
            ['aa'] = { query = '@parameter.outer', desc = 'Select around argument or parameter' },
          },
        },
        swap = {
          enable = true,
          swap_previous = {
            ['Hv'] = { query = '@assignment.outer', desc = 'Swap variable with previous' },
            ['Hf'] = { query = '@function.outer', desc = 'Swap function with previous' },
            ['Hl'] = { query = '@loop.outer', desc = 'Swap loop with previous' },
            ['Hi'] = { query = '@conditional.outer', desc = 'Swap conditional (if) with previous' },
            ['Hc'] = { query = '@class.outer', desc = 'Swap class with previous' },
            ['Ha'] = { query = '@parameter.inner', desc = 'Swap argument with previous' },
          },
          swap_next = {
            ['Lv'] = { query = '@assignment.outer', desc = 'Swap variable with next' },
            ['Lf'] = { query = '@function.outer', desc = 'Swap function with next' },
            ['Ll'] = { query = '@loop.outer', desc = 'Swap loop with next' },
            ['Li'] = { query = '@conditional.outer', desc = 'Swap conditional (if) with next' },
            ['Lc'] = { query = '@class.outer', desc = 'Swap class with next' },
            ['La'] = { query = '@parameter.inner', desc = 'Swap argument with next' },
          },
        },
        move = {
          enable = true,
          set_jumps = true,

          goto_next_start = {
            [']f'] = { query = '@call.outer', desc = 'Next function call start' },
            [']m'] = { query = '@function.outer', desc = 'Next method/function def start' },
            [']c'] = { query = '@class.outer', desc = 'Next class start' },
            [']i'] = { query = '@conditional.outer', desc = 'Next conditional start' },
            [']l'] = { query = '@loop.outer', desc = 'Next loop start' },

            -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
            -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
            [']s'] = { query = '@scope', query_group = 'locals', desc = 'Next scope' },
            [']z'] = { query = '@fold', query_group = 'folds', desc = 'Next fold' },
          },
          goto_next_end = {
            [']F'] = { query = '@call.outer', desc = 'Next function call end' },
            [']M'] = { query = '@function.outer', desc = 'Next method/function def end' },
            [']C'] = { query = '@class.outer', desc = 'Next class end' },
            [']I'] = { query = '@conditional.outer', desc = 'Next conditional end' },
            [']L'] = { query = '@loop.outer', desc = 'Next loop end' },
          },
          goto_previous_start = {
            ['[f'] = { query = '@call.outer', desc = 'Prev function call start' },
            ['[m'] = { query = '@function.outer', desc = 'Prev method/function def start' },
            ['[c'] = { query = '@class.outer', desc = 'Prev class start' },
            ['[i'] = { query = '@conditional.outer', desc = 'Prev conditional start' },
            ['[l'] = { query = '@loop.outer', desc = 'Prev loop start' },
          },
          goto_previous_end = {
            ['[F'] = { query = '@call.outer', desc = 'Prev function call end' },
            ['[M'] = { query = '@function.outer', desc = 'Prev method/function def end' },
            ['[C'] = { query = '@class.outer', desc = 'Prev class end' },
            ['[I'] = { query = '@conditional.outer', desc = 'Prev conditional end' },
            ['[L'] = { query = '@loop.outer', desc = 'Prev loop end' },
          },
        },
      },
    })

    local ts_repeat_move = require('nvim-treesitter.textobjects.repeatable_move')

    -- Repeat textobject moves
    vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move)
    vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_opposite)

    -- Make builtin f, F, t, T also repeatable with ; and ,
    vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f_expr, { expr = true })
    vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F_expr, { expr = true })
    vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t_expr, { expr = true })
    vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T_expr, { expr = true })

    -- Repeatable diagnostic move
    local next_diagnostic, prev_diagnostic = ts_repeat_move.make_repeatable_move_pair(function()
      vim.diagnostic.jump({ count = 1 })
    end, function()
      vim.diagnostic.jump({ count = -1 })
    end)

    vim.keymap.set('n', ']d', next_diagnostic, { desc = 'Next diagnostic' })
    vim.keymap.set('n', '[d', prev_diagnostic, { desc = 'Previous diagnostic' })
  end,
}
