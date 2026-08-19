require("telescope").setup({
    defaults = {
        preview = {
            treesitter = false,
        },
    },
    pickers = {
        buffers = {
            mappings = {
                i = {
                    ["<C-d>"] = require("telescope.actions").delete_buffer,
                },
                n = {
                    ["dd"] = require("telescope.actions").delete_buffer,
                },
            },
        },
    },
})
