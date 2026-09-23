 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#000000',
    base01 = '#131314',
    base02 = '#1e1e1f',
    base03 = '#8f9096',
    base04 = '#c6c6cc',
    base05 = '#e5e2e3',
    base06 = '#e5e2e3',
    base07 = '#e5e2e3',
    base08 = '#ffb4ab',
    base09 = '#d6c0d1',
    base0A = '#c5c6cd',
    base0B = '#c0c6d7',
    base0C = '#d6c0d1',
    base0D = '#c0c6d7',
    base0E = '#c5c6cd',
    base0F = '#e1e2e9',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#e5e2e3',          bg = '#000000' })
  hi('TelescopeBorder',         { fg = '#8f9096',             bg = '#000000' })
  hi('TelescopePromptNormal',   { fg = '#e5e2e3',          bg = '#000000' })
  hi('TelescopePromptBorder',   { fg = '#8f9096',             bg = '#000000' })
  hi('TelescopePromptPrefix',   { fg = '#c0c6d7',             bg = '#000000' })
  hi('TelescopePromptCounter',  { fg = '#c6c6cc',  bg = '#000000' })
  hi('TelescopePromptTitle',    { fg = '#000000',             bg = '#c0c6d7' })
  hi('TelescopePreviewTitle',   { fg = '#000000',             bg = '#c5c6cd' })
  hi('TelescopeResultsTitle',   { fg = '#000000',             bg = '#d6c0d1' })
  hi('TelescopeSelection',      { fg = '#e5e2e3',          bg = '#1e1e1f' })
  hi('TelescopeSelectionCaret', { fg = '#c0c6d7',             bg = '#1e1e1f' })
  hi('TelescopeMatching',       { fg = '#c0c6d7',             bold = true })
end

-- Register a signal handler for SIGUSR1 (matugen updates).
-- The handler re-requires this module, which re-runs the code below, so the
-- previous handle is stopped first; otherwise handlers double on every signal.
if _G.__matugen_signal then
  _G.__matugen_signal:stop()
  _G.__matugen_signal:close()
end

local signal = vim.uv.new_signal()
_G.__matugen_signal = signal
signal:start(
  'sigusr1',
  vim.schedule_wrap(function()
    package.loaded['matugen'] = nil
    require('matugen').setup()
  end)
)

return M
