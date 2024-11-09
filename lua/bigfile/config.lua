local M = {}

M.defaults = {
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

M.options = {}

function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", {}, M.defaults, opts or {})
  M.min_size_limit = M.options.size_limit
  for _, size in pairs(M.options.ft_size_limits) do
    M.min_size_limit = math.min(M.min_size_limit, size)
  end
end

return M
