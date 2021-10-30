local h = require("null-ls.helpers")
local methods = require("null-ls.methods")
local utils = require("null-ls.utils")

local COMPLETION = methods.internal.COMPLETION

local M = {}

M.tags = h.make_builtin({
    method = COMPLETION,
    filetypes = {},
    name = "tags",
    generator = {
        fn = function(params, done)
            local tags = vim.fn.taglist(params.word_to_complete)
            local words = {}
            local items = {}
            for _, tag in ipairs(tags) do
                table.insert(words, tag.name)
            end
            words = utils.tbl_uniq(words)
            for _, word in ipairs(words) do
                table.insert(items, {
                    label = word,
                    insertText = word,
                })
            end

            done(items)
        end,
        async = true,
        use_cache = true,
    },
})

return M
