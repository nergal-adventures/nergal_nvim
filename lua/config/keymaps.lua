vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<leader>pv', vim.cmd.Ex, { desc = 'Open [E]xplorer' })

--- Telescope ---
require('telescope').setup({})
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = "File finder"})
vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = "Git files" })
vim.keymap.set('n', '<leader>pws', function ()
	local word = vim.fn.expand("<cword>")
	builtin.grep_string({ search = word })
end, { desc = "Search for current word" })
vim.keymap.set('n', '<leader>pWs', function ()
	local word = vim.fn.expand("<cWORD>")
	builtin.grep_string({ search = word })
end, { desc = "Search for current unspaced WORD" })
vim.keymap.set('n', '<leader>ps', function ()
	builtin.grep_string({ search = vim.fn.input("Grep > ")})
end, { desc = "Grep search" })
vim.keymap.set('n', '<leader>vh', builtin.help_tags, { desc = "Help files" })

-- OPEN RIGHT SIDED-TERMINAL
local function open_terminal()
  local terminal_buffer_id
	local width = math.floor(vim.o.columns * 0.5)
  
  for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buffer].buftype == "terminal" then
      vim.api.nvim_buf_delete(buffer, { force = true, unload = true })
      print("TERMINAL id = " .. buffer .. " KILLED")
    end
  end

	vim.cmd("vertical botright " .. width .. "vsplit | terminal")
  vim.cmd.wincmd("W")
end

-- GET TERMINAL BUFFER
local function get_terminal_buffer()
  local terminal_buffer_id

  open_terminal()

  for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buffer].buftype == "terminal" then
      terminal_buffer_id = vim.b[buffer].terminal_job_id
    end
  end

  if terminal_buffer_id then
    return terminal_buffer_id
  else
    print("No terminal buffer found")
    return nil
  end
end

vim.keymap.set('n', '<leader>t', open_terminal, { desc = "Open sided-terminal", noremap = true, silent = true })

-- --------------------------------------------------
-- C SHORTCUTS
-- --------------------------------------------------
-- BUILD
local function build_in_terminal()
  local cleanTerm = "clear"
  local mkClean = "make clean"
  local makeBuild = "make"

  local terminal_job_id = get_terminal_buffer()

  if terminal_job_id == nil then
    open_terminal()
    terminal_job_id = get_terminal_buffer()
  end

  vim.fn.chansend(terminal_job_id, mkClean .. "\n")
  print("Command executed: ", mkClean)
  vim.fn.chansend(terminal_job_id, cleanTerm .. "\n")
  print("Command executed: ", cleanTerm)
  vim.fn.chansend(terminal_job_id, makeBuild .. "\n")
  print("Command executed: ", makeBuild)
end

local function flash_in_terminal()
  local makeFlash = "make flash"

  build_in_terminal()
  local terminal_job_id = get_terminal_buffer()

  vim.fn.chansend(terminal_job_id, makeFlash .. "\n")
  print("Command executed: ", makeFlash)
end

-- BUILD C
vim.keymap.set('n', '<leader>cc', build_in_terminal, { desc = "C clean & build", noremap = true, silent = true })
-- BUILD AND FLASH C
vim.keymap.set('n', '<leader>cf', flash_in_terminal, { desc = "C clean, build & flash", noremap = true, silent = true })

