-- This file can be loaded by calling `lua require('plugins')` from your init.vim
--
vim.cmd [[echo 'Hello woodie']]

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

local packer = require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim' -- Package manager
  use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
  use 'saadparwaiz1/cmp_luasnip'
  use 'lukas-reineke/indent-blankline.nvim'
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}

  use 'joshdick/onedark.vim' -- Theme inspired by Atom
  use { "catppuccin/nvim", as = "catppuccin" }
  use 'sainnhe/sonokai'

  use {
  'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    requires = { 
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
    }
  }
  use {
    'uloco/bluloco.nvim',
    requires = { 'rktjmp/lush.nvim' }
  }
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.4',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {
    'NLKNguyen/papercolor-theme'
  }
  use {
    'sonph/onehalf'
  }
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }
  use {
    'linrongbin16/lsp-progress.nvim',
    config = function()
      require('lsp-progress').setup()
    end
  }
  use {
    'akinsho/bufferline.nvim',
    tag = "*",
    requires = 'nvim-tree/nvim-web-devicons'
  }
end)

return packer
