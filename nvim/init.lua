-- ~/.config/nvim/init.lua

------------------------------------------------------------------------------
-- NVIM SETTINGS
------------------------------------------------------------------------------

-- require('init')
require('plugins')

vim.wo.number = true
--vim.o.breakindent = true

--Set colorscheme (order is important here)
require("bluloco").setup({
  style = "auto",               -- "auto" | "dark" | "light"
  transparent = true,
  italics = false,
  terminal = vim.fn.has("gui_running") == 1, -- bluoco colors are enabled in gui terminals per default.
  guicursor   = true,
})

vim.opt.termguicolors = true
vim.cmd('colorscheme bluloco')

-- Set statusbar
vim.g.lightline = {
	colorscheme = 'bluloco',
	active = { left = { { 'mode', 'paste' }, { 'readonly', 'filename', 'modified' } } },
}

--Map blankline
vim.g.indent_blankline_char = '┊'
vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
vim.g.indent_blankline_char_highlight = 'LineNr'
vim.g.indent_blankline_show_trailing_blankline_indent = false

-- TAB
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.tabstop = 4 
vim.opt.shiftwidth = 4
vim.opt.autoindent = true

vim.opt.smartindent = true
vim.opt.colorcolumn = '100'

vim.opt.backspace = 'indent,eol,start'

-- vim.cmd 'filetype plugin indent on'


-- LSP settings
local nvim_lsp = require 'lspconfig'
local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

-- nvim-cmp supports additional completion capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities()

nvim_lsp.clangd.setup {
	on_attach = on_attach,
	cmd = {
		"clangd",
		"--background-index",
		"-j=8",
		"--header-insertion=never"
	},
	filetypes = {"c", "cpp", "objc", "objcpp"},
}

nvim_lsp.pylsp.setup {
    on_attach=on_attach,
    filetypes = {'python'},
    settings = {
        configurationSources = {"flake8"},
        formatCommand = {"black"},
        pylsp = {
            plugins = {
                pyflakes={enabled=true},
                pylint = {args = {'--ignore=E501,E231', '-'}, enabled=true, debounce=200},
                pylsp_mypy={enabled=false},
                pycodestyle={
                    enabled=true,
                    ignore={'E501', 'E231'},
                    maxLineLength=120
                },
                yapf={enabled=true}
            }
        }
    }
}

vim.lsp.set_log_level("trace")

-- Auto-recompile plugins on plugins.lua change
-- Colorscheme

-- Extra useful functions

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- luasnip setup
local luasnip = require 'luasnip'

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

local import_cmp, cmp = pcall(require, 'cmp')
if not import_cmp then return end

local import_luasnip, luasnip = pcall(require, 'luasnip')
if not import_luasnip then return end


cmp.setup({

	snippet = {
		expand = function(args) luasnip.lsp_expand(args.body) end,
	},

	formatting = {

		format = function(entry, vim_item)
			-- fancy icons and a name of kind
			local import_lspkind, lspkind = pcall(require, "lspkind")
			if import_lspkind then
				vim_item.kind = lspkind.presets.default[vim_item.kind]
			end

			-- limit completion width
			local ELLIPSIS_CHAR = '…'
			local MAX_LABEL_WIDTH = 35
			local label = vim_item.abbr
			local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)
			if truncated_label ~= label then
				vim_item.abbr = truncated_label .. ELLIPSIS_CHAR
			end

			-- set a name for each source
			vim_item.menu = ({
				buffer = "[Buff]",
				nvim_lsp = "[LSP]",
				luasnip = "[LuaSnip]",
				nvim_lua = "[Lua]",
				latex_symbols = "[Latex]",
			})[entry.source.name]
			return vim_item
		end,
	},

	sources = {
		{name = 'nvim_lsp'},
		{name = 'nvim_lsp_signature_help' },
		{name = 'nvim_lua'},
		{name = 'path'},
		{name = 'luasnip'},
		{name = 'buffer', keyword_length = 1},
	},

	window = {
		documentation = {
			border = {"┌", "─", "┐", "│", "┘", "─", "└", "│"},
		},
		completion = {
			border = {"┌", "─", "┐", "│", "┘", "─", "└", "│"},
		}
	},

})

cmp.setup({
	mapping = {
		['<C-Space>'] = cmp.mapping.complete({}),
		['<C-e>'] = cmp.mapping.close(),
		['<C-u>'] = cmp.mapping.scroll_docs(-4),
		['<C-d>'] = cmp.mapping.scroll_docs(4),
		['<CR>'] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		}),

		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, {"i", "s"}),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, {"i", "s"}),

	},
})
-- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'grc',
      node_decremental = 'grm',
    },
  },
  indent = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
}

local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope.find_files, {})
vim.keymap.set('n', '<leader>fg', telescope.live_grep, {})
vim.keymap.set('n', '<leader>fb', telescope.buffers, {})
vim.keymap.set('n', '<leader>fh', telescope.help_tags, {})
