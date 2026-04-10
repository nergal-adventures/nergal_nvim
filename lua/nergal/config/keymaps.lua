-- Get termial buffer ID
local function get_terminal_buffer()
  local terminal_buffer_id

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

local function get_swift_context()
  local bufnr = 0

  -- 1. Ensure parser exists for this buffer
  local ok, parser = pcall(vim.treesitter.get_parser, bufnr, "swift")
  if not ok or not parser then
    return { error = "No Swift parser" }
  end

  -- 2. Force a parse to ensure the tree is ready
  local tree = parser:parse()[1]
  if not tree then
    return { error = "No parse tree" }
  end

  local root = tree:root()
  if not root then
    return { error = "No root node" }
  end

  -- 3. Get node at cursor
  local node = vim.treesitter.get_node({ bufnr = bufnr, lang = "swift" })
  if not node then
    return { error = "No node" }
  end

  local function_name = nil
  local class_name = nil

  -- Helper to extract the "name" field from a declaration node
  local function get_name_from_node(n)
    local name_nodes = n:field("name")
    if name_nodes and name_nodes[1] then
      return vim.treesitter.get_node_text(name_nodes[1], bufnr)
    end
    return nil
  end

  -- Walk up the tree looking for enclosing function and class/type
  while node do
    local t = node:type()

    if not function_name and t == "function_declaration" then
      function_name = get_name_from_node(node)
    end

    if not class_name and (
      t == "class_declaration" or
      t == "struct_declaration" or
      t == "enum_declaration" or
      t == "actor_declaration" or
      t == "extension_declaration"
    ) then
      class_name = get_name_from_node(node)
    end

    if function_name and class_name then
      break
    end

    node = node:parent()
  end

  return {
    function_name = function_name,
    class_name = class_name,
  }
end

local function run_xcode_integration_tests()
  local xcodeCmd = "xcodebuild test "
  local flag_sdk = "-sdk iphoneos "
  local flag_scheme = "-scheme YpsomedDC "
  local flag_test_plan = "-testPlan IntegrationTestPlan "
  local flag_destination = "-destination \"platform=iOS Simulator,name=iPhone 17 Pro Max\" "
  local swift_context = get_swift_context()
  local test_filter = "-only-testing \"IntegrationTests/" .. swift_context.class_name .. "\""
  local full_cmd = xcodeCmd .. flag_sdk .. flag_scheme .. flag_test_plan .. flag_destination .. test_filter

  local terminal_job_id = get_terminal_buffer()
  if terminal_job_id == nil then return end
  vim.fn.chansend(terminal_job_id, "clear" .. "\n")
  print("Command executed: ", "clear")
  vim.fn.chansend(terminal_job_id, full_cmd .. "\n")
  vim.fn.chansend(terminal_job_id, "\n")
  print("Command executed: ", full_cmd)
end

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set('n', '<leader>rr', function ()
  vim.cmd("source $MYVIMRC")
  vim.cmd("lua dofile(vim.env.MYVIMRC)")
  print("Config reloaded")
end, { desc = "Reload Config" })

vim.keymap.set('n', '<Esc>', '<Cmd>nohlsearch<CR>', { silent = true })

-- INVOKE A RIGHT SIDED TERMINAL
vim.keymap.set('n', '<leader>t',function ()
  local width = math.floor(vim.o.columns * 0.4)
  vim.cmd("vertical botright " .. width .. "vsplit | terminal")
end, { desc = "Open sided-terminal", noremap = true, silent = true })

-- Change to 'NORMAL' mode
vim.keymap.set('t', '<C-t>', [[<C-\><C-n>]], { silent = true, noremap = true, desc = "Switch to 'NORMAL' mode"})

-- Run 'C BUILD & TEST'
vim.keymap.set('n', '<leader>rc', function ()
  local cleanCmd = "clear"
  local makeCmd = "./build.sh && ./bin/tests"

  local terminal_job_id = get_terminal_buffer()

  if terminal_job_id == nil then
    return
  end

  vim.fn.chansend(terminal_job_id, cleanCmd .. "\n")
  print("Command executed: ", cleanCmd)
  vim.fn.chansend(terminal_job_id, makeCmd .. "\n")
  print("Command executed: ", makeCmd)
end, { desc = "C Build and test", noremap = true, silent = true })

vim.keymap.set('n', '<leader>rx', run_xcode_integration_tests, { desc = "XCode Integration tests", noremap = true, silent = true })

