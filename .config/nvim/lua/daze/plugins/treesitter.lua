return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        lazy = false,
        config = function()
            -- Install parsers
            require("nvim-treesitter").install({
                "python", "php", "bash", "c", "cpp", "rust", "lua",
                "javascript", "typescript", "swift", "dart", "sql",
                "json", "make", "markdown", "css", "html", "go",
            })

            -- Enable treesitter highlighting for supported languages
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "python", "php", "bash", "c", "cpp", "rust", "lua",
                    "javascript", "typescript", "swift", "dart", "sql",
                    "json", "make", "markdown", "css", "html", "go",
                },
                callback = function()
                    vim.treesitter.start()
                end,
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        config = function()
            require("treesitter-context").setup()
        end,
    },
}
