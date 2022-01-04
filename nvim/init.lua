local cmd = vim.cmd
local set = vim.opt
local g = vim.g
local keymap = vim.api.nvim_set_keymap
local opts = { noremap=true, silent=true }

g.mapleader = ' '

require 'options'
require 'keymaps'
require 'treesitter'

local nvim_lsp = require('lspconfig')

require('plugins')
require'lspconfig'.rust_analyzer.setup{}
require'lspconfig'.pyright.setup{
  settings = {
    python = {
      analysis = {
        autoImportCompletions = false,
      }
    }
  }
}
require'lspconfig'.tailwindcss.setup{}
require('rust-tools').setup({})
require'lspconfig'.tsserver.setup{}
require'lspconfig'.vuels.setup{}
require'nvim-tree'.setup {}

local config = {
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    style = 'minimal',
    border = 'rounded',
    source = 'always',
    header = '',
  },
}

vim.diagnostic.config(config)


vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'rounded',
})

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = 'rounded',
})

-- Add additional capabilities supported by nvim-cmp
local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
        augroup lsp_document_highlight
          autocmd! * <buffer>
          autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
          autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
      ]],
      false
    )
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  lsp_highlight_document(client)
end

local servers = { 'pyright', 'rust_analyzer' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

-- nvim-cmp setup
local cmp = require 'cmp'
local kind_icons = {
  Text = '',
  Method = 'm',
  Function = '',
  Constructor = '',
  Field = '',
  Variable = '',
  Class = '',
  Interface = '',
  Module = '',
  Property = '',
  Unit = '',
  Value = '',
  Enum = '',
  Keyword = '',
  Snippet = '',
  Color = '',
  File = '',
  Reference = '',
  Folder = '',
  EnumMember = '',
  Constant = '',
  Struct = '',
  Event = '',
  Operator = '',
  TypeParameter = '',
}
cmp.setup {
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
  },
  formatting = {
    fields = { 'kind', 'abbr', 'menu' },
    format = function(entry, vim_item)
      vim_item.kind = string.format('%s', kind_icons[vim_item.kind])
      vim_item.menu = ({
        nvim_lsp = '[LSP]',
        nvim_lua = '[NVIM_LUA]',
        buffer = '[Buffer]',
        path = '[Path]',
      })[entry.source.name]
      return vim_item
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'buffer' },
    { name = 'path' },
  },
}

vim.g.vscode_style = 'dark'

set.shell = 'zsh --login'

require('lualine').setup({
  options = {
    theme = 'vscode',
  },
  sections = {
    lualine_a = {{'filename', path = 2}},
    lualine_b = {'branch', 'diff'},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
})

require('formatter').setup(  -- run black on save for Python files
  {
    filetype = {
      python = {
        function()
          return {
            exe = 'black',
            stdin = false,
          }
        end
      }
    }
  }
)

-- bufferline
local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
  return
end

bufferline.setup {
  options = {
    numbers = 'none',
    close_command = 'Bdelete! %d',
    right_mouse_command = 'Bdelete! %d',
    left_mouse_command = 'buffer %d',
    middle_mouse_command = nil,
    -- NOTE: this plugin is designed with this icon in mind,
    -- and so changing this is NOT recommended, this is intended
    -- as an escape hatch for people who cannot bear it for whatever reason
    indicator_icon = '▎',
    buffer_close_icon = '',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    max_name_length = 30,
    max_prefix_length = 30,
    tab_size = 21,
    diagnostics = false, -- | 'nvim_lsp'
    diagnostics_update_in_insert = false,
    -- diagnostics_indicator = function(count, level, diagnostics_dict, context)
    --   return '('..count..')'
    -- end,
    -- NOTE: this will be called a lot so don't do any heavy processing here
    -- custom_filter = function(buf_number)
    --   -- filter out filetypes you don't want to see
    --   if vim.bo[buf_number].filetype ~= '<i-dont-want-to-see-this>' then
    --     return true
    --   end
    --   -- filter out by buffer name
    --   if vim.fn.bufname(buf_number) ~= '<buffer-name-I-dont-want>' then
    --     return true
    --   end
    --   -- filter out based on arbitrary rules
    --   -- e.g. filter out vim wiki buffer from tabline in your work repo
    --   if vim.fn.getcwd() == '<work-repo>' and vim.bo[buf_number].filetype ~= 'wiki' then
    --     return true
    --   end
    -- end,
    offsets = { { filetype = 'NvimTree', text = '', padding = 1 } },
    show_buffer_icons = true,
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    persist_buffer_sort = true,
    separator_style = 'thin', -- | 'thick' | 'thin' | { 'any', 'any' },
    enforce_regular_tabs = true,
    always_show_bufferline = true,
    -- sort_by = 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
    --   -- add custom logic
    --   return buffer_a.modified > buffer_b.modified
    -- end
  },
  highlights = {
    fill = {
      guifg = { attribute = 'fg', highlight = '#ff0000' },
      guibg = { attribute = 'bg', highlight = 'TabLine' },
    },
    background = {
      guifg = { attribute = 'fg', highlight = 'TabLine' },
      guibg = { attribute = 'bg', highlight = 'TabLine' },
    },

    -- buffer_selected = {
    --   guifg = {attribute='fg',highlight='#ff0000'},
    --   guibg = {attribute='bg',highlight='#0000ff'},
    --   gui = 'none'
    --   },
    buffer_visible = {
      guifg = { attribute = 'fg', highlight = 'TabLine' },
      guibg = { attribute = 'bg', highlight = 'TabLine' },
    },

    close_button = {
      guifg = { attribute = 'fg', highlight = 'TabLine' },
      guibg = { attribute = 'bg', highlight = 'TabLine' },
    },
    close_button_visible = {
      guifg = { attribute = 'fg', highlight = 'TabLine' },
      guibg = { attribute = 'bg', highlight = 'TabLine' },
    },
    -- close_button_selected = {
    --   guifg = {attribute='fg',highlight='TabLineSel'},
    --   guibg ={attribute='bg',highlight='TabLineSel'}
    --   },

    tab_selected = {
      guifg = { attribute = 'fg', highlight = 'Normal' },
      guibg = { attribute = 'bg', highlight = 'Normal' },
    },
    tab = {
      guifg = { attribute = 'fg', highlight = 'TabLine' },
      guibg = { attribute = 'bg', highlight = 'TabLine' },
    },
    tab_close = {
      -- guifg = {attribute='fg',highlight='LspDiagnosticsDefaultError'},
      guifg = { attribute = 'fg', highlight = 'TabLineSel' },
      guibg = { attribute = 'bg', highlight = 'Normal' },
    },

    duplicate_selected = {
      guifg = { attribute = 'fg', highlight = 'TabLineSel' },
      guibg = { attribute = 'bg', highlight = 'TabLineSel' },
      gui = 'italic',
    },
    duplicate_visible = {
      guifg = { attribute = 'fg', highlight = 'TabLine' },
      guibg = { attribute = 'bg', highlight = 'TabLine' },
      gui = 'italic',
    },
    duplicate = {
      guifg = { attribute = 'fg', highlight = 'TabLine' },
      guibg = { attribute = 'bg', highlight = 'TabLine' },
      gui = 'italic',
    },

    modified = {
      guifg = { attribute = 'fg', highlight = 'TabLine' },
      guibg = { attribute = 'bg', highlight = 'TabLine' },
    },
    modified_selected = {
      guifg = { attribute = 'fg', highlight = 'Normal' },
      guibg = { attribute = 'bg', highlight = 'Normal' },
    },
    modified_visible = {
      guifg = { attribute = 'fg', highlight = 'TabLine' },
      guibg = { attribute = 'bg', highlight = 'TabLine' },
    },

    separator = {
      guifg = { attribute = 'bg', highlight = 'TabLine' },
      guibg = { attribute = 'bg', highlight = 'TabLine' },
    },
    separator_selected = {
      guifg = { attribute = 'bg', highlight = 'Normal' },
      guibg = { attribute = 'bg', highlight = 'Normal' },
    },
    -- separator_visible = {
    --   guifg = {attribute='bg',highlight='TabLine'},
    --   guibg = {attribute='bg',highlight='TabLine'}
    --   },
    indicator_selected = {
      guifg = { attribute = 'fg', highlight = 'LspDiagnosticsDefaultHint' },
      guibg = { attribute = 'bg', highlight = 'Normal' },
    },
  },
}
