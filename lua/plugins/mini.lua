return {
    {
        'echasnovski/mini.move',
        opts = {},
        keys = { '<M-h>', '<M-l>', '<M-j>', '<M-k>' },
        config = function(_, opts)
            require('mini.move').setup(opts)
        end,
    },
    {
        'echasnovski/mini.bufremove',
    -- stylua: ignore
    keys = {
      { "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
      { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
    },
    },
    {
        'echasnovski/mini.animate',
        event = 'VeryLazy',
        enabled = false,
        config = function(_, _)
            require('mini.animate').setup()
        end,
    },
}
