-- Install lazylazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Fixes Notify opacity issues
vim.o.termguicolors = true

-- load gemini api key
local file = io.open("/Users/illusion/Documents/Creds/gemini.txt", "r")
if file then
  local gemini_api_key = file:read("*all")
  file:close()
else
  -- File opening failed, handle the error
  print("Failed to open gemini.txt!")
  local gemini_api_key = ''
end

require('lazy').setup({
  {
    "supermaven-inc/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup({
        keymaps = {
          accept_suggestion = "<M-;>",
          clear_suggestion = "<M-c>",
          accept_word = "<C-j>",
        },
        ignore_filetypes = { env = true }, -- or { "cpp", }
        color = {
          suggestion_color = "#ff0000",
          cterm = 244,
        },
        log_level = "info", -- set to "off" to disable logging completely
        disable_inline_completion = false, -- disables inline completion for use with cmp
        disable_keymaps = false, -- disables built in keymaps for more manual control
        condition = function()
          return false
        end -- condition to check for stopping supermaven, `true` means to stop supermaven when the condition is true.
      })
    end,
  },
  -- {
  --   'Exafunction/codeium.vim',
  --   config = function ()
  --     vim.g.codeium_disable_bindings = 1
  --     -- Change '<C-g>' here to any keycode you like.
  --     vim.keymap.set('i', '<M-;>', function () return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
  --     vim.keymap.set('i', '<c-n>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true, silent = true })
  --     vim.keymap.set('i', '<c-p>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true, silent = true })
  --     vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
  --     enable_chat = true
  --   end
  -- },
  'onsails/lspkind.nvim',
  'folke/zen-mode.nvim',
  {
    "olimorris/codecompanion.nvim",
    branch = "main",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- The following are optional:
      -- { "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } },
    },
    config = function()
      require("codecompanion").setup({
        adapters = {
          ollama = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              env_replaced = {
                -- owui
                url = "http://100.109.37.59:8080/api",
                model = "google_genai.gemini-2.0-flash-thinking-exp-1219",
                api_key = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImI0MDk1ZWVmLTBmZDEtNGQ0MS1iNGEyLWEzMjRjNDk1NWZlMSJ9.mkpWXBKxuI0fDutOCR8EyUiB4wcPncXOmA-3MHyOsd8",

                -- glhf
                url = "https://glhf.chat/api/openai",
                model = "hf:Qwen/Qwen2.5-Coder-32B-Instruct",

                -- pc
                -- url = "http://100.95.18.138:42069",
                -- model = "qwen2.5.1-coder-7b-instruct"

                -- llama cpp
                -- url = "http://localhost:42070",
              },
            })
          end,
        },
        -- display = {
        --   action_palette = {
        --     provider = "telescope",
        --   },
        -- },
        strategies = {
          chat = {
            adapter = "ollama",
            slash_commands = {
              ["buffer"] = {
                opts = {
                  provider = "telescope",
                }
              },
              ["fetch"] = {
                opts = {
                  provider = "telescope",
                }
              },
              ["file"] = {
                opts = {
                  provider = "telescope",
                }
              },
              ["symbols"] = {
                opts = {
                  provider = "telescope",
                }
              },
            },
          }
        },
        vim.api.nvim_set_keymap("n", "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true }),
        vim.api.nvim_set_keymap("v", "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true }),
        vim.api.nvim_set_keymap("n", "<LocalLeader>a", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true }),
        vim.api.nvim_set_keymap("v", "<LocalLeader>a", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true }),
        vim.api.nvim_set_keymap("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true }),
      })
    end,
  },

  -- Tree
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    requires = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {
        update_focused_file = {
          enable = true,
        },
      }
    end,
  },
  'ThePrimeagen/git-worktree.nvim',
  'tpope/vim-surround',
  'xiyaowong/nvim-transparent',
  { 
    'numToStr/FTerm.nvim',
    config = function()
      local map = vim.api.nvim_set_keymap
      local opts = { noremap = true, silent = true }
      require 'FTerm'.setup({
        blend = 5,
        dimensions = {
          height = 0.90,
          width = 0.90,
          x = 0.5,
          y = 0.5
        }
      })
    end
  },

  {
    'rmagatti/goto-preview',
    config = function()
      require('goto-preview').setup {
        width = 120; -- Width of the floating window
        height = 15; -- Height of the floating window
        border = {"↖", "─" ,"┐", "│", "┘", "─", "└", "│"}; -- Border characters of the floating window
        default_mappings = true;
        debug = false; -- Print debug information
        opacity = nil; -- 0-100 opacity level of the floating window where 100 is fully transparent.
        resizing_mappings = false; -- Binds arrow keys to resizing the floating window.
        post_open_hook = nil; -- A function taking two arguments, a buffer and a window to be ran as a hook.
        references = { -- Configure the telescope UI for slowing the references cycling window.
          telescope = require("telescope.themes").get_dropdown({ hide_preview = false })
        };
        -- These two configs can also be passed down to the goto-preview definition and implementation calls for one off "peak" functionality.
        focus_on_open = true; -- Focus the floating window when opening it.
        dismiss_on_move = false; -- Dismiss the floating window when moving the cursor.
        force_close = true, -- passed into vim.api.nvim_win_close's second argument. See :h nvim_win_close
        bufhidden = "wipe", -- the bufhidden option to set on the floating window. See :h bufhidden
        stack_floating_preview_windows = true, -- Whether to nest floating windows
        preview_window_title = { enable = true, position = "left" }, -- Whether 
      }
    end
  },

  {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  },

  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    lazy = false,
    config = function()
      require("todo-comments").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  },

  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup({
        background_colour = "#000000",
        enabled = false,
      })
    end
  },   

  {
    "folke/noice.nvim",
    config = function()
      require("noice").setup({
        -- add any options hereG
        routes = {
          {
            filter = {
              event = 'msg_show',
              any = {
                { find = '%d+L, %d+B' },
                { find = '; after #%d+' },
                { find = '; before #%d+' },
                { find = '%d fewer lines' },
                { find = '%d more lines' },
              },
            },
            opts = { skip = true },
          }
        },
      })
    end,
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    }
  },

  'ray-x/go.nvim',
  'ray-x/guihua.lua',
  { "catppuccin/nvim", as = "catppuccin" },
  {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
  },

  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      'j-hui/fidget.nvim',
    }
  },
  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    }
  },

  -- Git related plugins
  'lewis6991/gitsigns.nvim',
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional - Diff integration
      "nvim-telescope/telescope.nvim", -- optional
    },
    config = true
  },

  'navarasu/onedark.nvim', -- Theme inspired by Atom
  'nvim-lualine/lualine.nvim', -- Fancier statusline
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
  'numToStr/Comment.nvim', -- "gc" to comment visual regions/lines 
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' }},
  'nvim-telescope/telescope-symbols.nvim',
  'ThePrimeagen/harpoon',

  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', cond = vim.fn.executable 'make' == 1 },
  {
    "folke/twilight.nvim",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
  {
    "karb94/neoscroll.nvim",
    config = function ()
      require('neoscroll').setup {}
    end
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
  {
    "almo7aya/openingh.nvim"
  },
  -- {
  --   "ellisonleao/glow.nvim", config = true, cmd = "Glow"
  -- },
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
  {
    "LunarVim/bigfile.nvim",
  },
  {
    "petertriho/nvim-scrollbar",
    config = function()
      require("scrollbar").setup()
    end
  },
  -- {
  --   "nvim-neorg/neorg",
  --   version = "v7.0.0",
  --   ft = "norg",
  --   run = ":Neorg sync-parsers", -- This is the important bit!
  --   config = function()
  --     require('neorg').setup {
  --       load = {
  --         ["core.defaults"] = {},
  --         ["core.concealer"] = {},
  --         ["core.integrations.treesitter"] = {},
  --         ["core.esupports.indent"] = {},
  --         ["core.summary"] = {},
  --         ["core.completion"] = {
  --           config = {
  --             engine = "nvim-cmp",
  --           }
  --         },
  --         ["core.export.markdown"] = {},
  --         ["core.export"] = {},
  --       }
  --     }
  --   end,
  -- },

  -- Note taking
  {
    "epwalsh/obsidian.nvim",
    -- branch = "main",
    -- version = "*",  -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",

    keys = {
      { "<leader>on", "<cmd>ObsidianNew<cr>", desc = "New Obsidian note", mode = "n" },
      { "<leader>oo", "<cmd>ObsidianSearch<cr>", desc = "Search Obsidian notes", mode = "n" },
      { "<leader>os", "<cmd>ObsidianQuickSwitch<cr>", desc = "Quick Switch", mode = "n" },
      { "<leader>ob", "<cmd>ObsidianBacklinks<cr>", desc = "Show location list of backlinks", mode = "n" },
      { "<leader>ot", "<cmd>ObsidianTemplate<cr>", desc = "Follow link under cursor", mode = "n" },
      { "<leader>oc", "<cmd>ObsidianToggleCheckbox<cr>", desc = "Toggle checkbox", mode = "n" },

    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  -- {
  --     "OXY2DEV/markview.nvim",
  --     lazy = false,      -- Recommended
  --     -- ft = "markdown" -- If you decide to lazy-load anyway
  --
  --     dependencies = {
  --         "nvim-treesitter/nvim-treesitter",
  --         "nvim-tree/nvim-web-devicons"
  --     }
  -- },
  -- {
  --   "MeanderingProgrammer/markdown.nvim",
  --   main = "render-markdown",
  --   opts = { enabled = true },
  --   dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  -- },
  {
    "marcussimonsen/let-it-snow.nvim",
    cmd = "LetItSnow", -- Wait with loading until command is run
    opts = {},
  },

  -- Themes
  { "arturgoms/moonbow.nvim" },
  { "ellisonleao/gruvbox.nvim", priority = 1000 , opts = ...},
  { "rose-pine/neovim", name = "rose-pine" },
  { "oxfist/night-owl.nvim" },
  { "EdenEast/nightfox.nvim" },
  { 'loctvl842/monokai-pro.nvim' },
  { "adrian5/oceanic-next-vim"},
  { 
    "phha/zenburn.nvim",
    config = function() 
      require("zenburn").setup() 
    end
  },
  {"neanias/everforest-nvim"},
  {"luisiacc/gruvbox-baby"},
  {"slugbyte/lackluster.nvim"},
  {
    "wincent/base16-nvim",
    lazy = false, -- load at start
    priority = 1000, -- load first
    config = function()
      vim.cmd([[colorscheme gruvbox]])
      vim.o.background = 'dark'
      -- XXX: hi Normal ctermbg=NONE
      -- Make comments more prominent -- they are important.
      local bools = vim.api.nvim_get_hl(0, { name = 'Boolean' })
      vim.api.nvim_set_hl(0, 'Comment', bools)
      -- Make it clearly visible which argument we're at.
      local marked = vim.api.nvim_get_hl(0, { name = 'PMenu' })
      vim.api.nvim_set_hl(0, 'LspSignatureActiveParameter', { fg = marked.fg, bg = marked.bg, ctermfg = marked.ctermfg, ctermbg = marked.ctermbg, bold = true })
      -- XXX
      -- Would be nice to customize the highlighting of warnings and the like to make
      -- them less glaring. But alas
      -- https://github.com/nvim-lua/lsp_extensions.nvim/issues/21
      -- call Base16hi("CocHintSign", g:base16_gui03, "", g:base16_cterm03, "", "", "")
    end
  },
  { 'RRethy/nvim-base16' },
  { 'gambhirsharma/vesper.nvim' }
}
  -- {
  --   defaults = {
  --     lazy = true,
  --   }
  -- }
)


