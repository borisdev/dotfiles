return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        {'L3MON4D3/LuaSnip'},
        {'hrsh7th/cmp-buffer'},
        {'hrsh7th/cmp-nvim-lsp'},
        {'saadparwaiz1/cmp_luasnip'},
    },
    config = function()
        local cmp = require('cmp')
        local luasnip = require('luasnip')

        -- Set up gentle, eye-friendly colors for completion menu
        vim.api.nvim_set_hl(0, 'CmpNormal', { bg = '#2d2d2d', fg = '#d4d4d4' })
        vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { fg = '#569cd6', bold = true })
        vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { fg = '#569cd6' })
        vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { fg = '#dcdcaa' })
        vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { fg = '#dcdcaa' })
        vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { fg = '#9cdcfe' })
        vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { fg = '#569cd6' })
        vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { fg = '#9cdcfe' })
        vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { fg = '#b5cea8' })
        vim.api.nvim_set_hl(0, 'CmpItemMenu', { fg = '#808080', italic = true })
        vim.api.nvim_set_hl(0, 'CmpSel', { bg = '#404040', fg = '#ffffff' })

        cmp.setup({
            window = {
                completion = {
                    winhighlight = "Normal:CmpNormal,CursorLine:CmpSel,Search:None",
                    border = 'rounded',
                },
                documentation = {
                    border = 'rounded',
                    winhighlight = "Normal:CmpNormal",
                },
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
                -- Use Ctrl+j/k for completion navigation to avoid Tab conflict with Copilot
                ['<C-j>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<C-k>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                -- Keep Tab for snippet expansion only, allowing Copilot to handle Tab otherwise
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback() -- Let Copilot handle Tab
                    end
                end, { 'i', 's' }),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback() -- Let Copilot handle Shift+Tab
                    end
                end, { 'i', 's' }),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
            }, {
                { name = 'buffer' },
            }),
            formatting = {
                format = function(entry, vim_item)
                    vim_item.menu = ({
                        nvim_lsp = "[LSP]",
                        luasnip = "[Snip]",
                        buffer = "[Buf]",
                    })[entry.source.name]
                    return vim_item
                end
            },
        })

    end,
}