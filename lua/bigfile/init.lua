local M = {}

local config = require 'bigfile.config'

local function bigfiletype(ft)
  if not ft or ft == '' then
    return 'bigfile'
  else
    return 'bigfile-' .. ft
  end
end

local DETECTING = bigfiletype('_detecting_')

function M.setup(opts)
  config.setup(opts)

  vim.filetype.add({
    pattern = {
      [".*"] = {
        function(path, buf)
          local bo = vim.bo[buf]
          return bo and bo.filetype ~= DETECTING
              and path and vim.fn.getfsize(path) > config.min_size_limit
              and DETECTING or nil
        end,
      },
    },
  })

  vim.api.nvim_create_autocmd({ 'FileType' }, {
    group = vim.api.nvim_create_augroup('nvim-bigfile', { clear = true }),
    pattern = DETECTING,
    callback = function(ev)
      local ft = vim.filetype.match({ buf = ev.buf }) or ''
      local size = vim.fn.getfsize(ev.file)
      local size_limit = config.options.ft_size_limits[ft] or config.options.size_limit

      if size > size_limit then
        if config.options.notification then
          local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(ev.buf), ':p:~:.')
          vim.notify(('Big file detected: %s'):format(name), vim.log.levels.INFO)
        end
        vim.bo[ev.buf].filetype = bigfiletype(ft)
        if config.options.syntax then
          vim.schedule(function()
            vim.bo[ev.buf].syntax = ft
          end)
        end
        if type(config.options.hook) == "function" then
          config.options.hook(ev.buf, ft)
        end
      else
        vim.bo[ev.buf].filetype = ft
      end
    end,
  })
end

return M
