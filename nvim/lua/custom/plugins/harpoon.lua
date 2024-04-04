return {
  'ThePrimeagen/harpoon',
  dependencies = { 'nvim-lua/plenary.nvim' },
  branch = 'harpoon2',
  opts = {
    menu = {
      width = vim.api.nvim_win_get_width(0) - 4,
    },
  },
  keys = function()
    local keys = {
      {
        '<leader>a',
        function()
          require('harpoon'):list():add()
        end,
        desc = 'Harpoon File',
      },
      {
        '<leader>h',
        function()
          local harpoon = require 'harpoon'
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = 'Harpoon Quick Menu',
      },
      {
        '<C-S-P>',
        function()
          require('harpoon'):list():prev()
        end,
        desc = 'Previous harpoon file',
      },
      {
        '<C-S-N>',
        function()
          require('harpoon'):list():prev()
        end,
        desc = 'Next harpoon file',
      },
    }

    for i = 1, 5 do
      table.insert(keys, {
        '<leader>' .. i,
        function()
          require('harpoon'):list():select(i)
        end,
        desc = 'Harpoon to File ' .. i,
      })
    end
    return keys
  end,
}
