# nvim-bigfile

Automatically detect and handle big files in Neovim by reducing features (preventing setting the filetype to disable features like TreeSitter and LSP) for better performance.

Based on [bigfile in folke/snacks.nvim](https://github.com/folke/snacks.nvim/blob/main/lua/snacks/bigfile.lua). Added support for per-filetype size limits.

## Features

- Configurable default size limit and per-filetype size limits
- Basic syntax highlighting while reducing other features like LSP and TreeSitter
- Optional notifications and custom hook function when big files are detected

## Installation

-   [lazy.nvim](https://github.com/folke/lazy.nvim):

    ```lua
    {
        'ouuan/nvim-bigfile',
        opts = {},
    }
    ```

-   [vim-plug](https://github.com/junegunn/vim-plug)

    ```vim
    Plug 'ouuan/nvim-bigfile'
    ```

## Configuration

```lua
require('bigfile').setup {
  -- Default size limit in bytes
  size_limit = 5 * 1024 * 1024, -- 5MB

  -- Per-filetype size limits
  ft_size_limits = {
    -- javascript = 100 * 1024, -- 100KB for javascript files
  },

  -- Show notifications when big files are detected
  notification = true,

  -- Enable basic syntax highlighting (not TreeSitter) for big files
  -- (tips: it will be automatically disabled if too slow)
  syntax = true,

  -- Custom additional hook function to run when big files are detected
  hook = nil,
  -- hook = function(buf, ft)
  --   vim.b.minianimate_disable = true
  -- end,
}
```
