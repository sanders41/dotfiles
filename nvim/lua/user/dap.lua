local dap, dap_python, dapui = require("dap"), require("dap-python"), require("dapui")

dapui.setup()

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end

dap_python.setup("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")
dap_python.test_runner = "pytest"

vim.keymap.set("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>")
vim.keymap.set("n", "<leader>ds", "<cmd> DapStepInto <CR>")
vim.keymap.set("n", "<leader>dso", "<cmd> DapStepOver <CR>")
vim.keymap.set("n", "<leader>dpt", function()
  -- This crazyness is because dap can't run at the same time as coverage. So first check if it is
  -- installed (it will error when disabling otherwise) and disable coverge if it is present.
  local env = os.getenv("VIRTUAL_ENV")
  if env then
    local result = io.popen(env .. '/bin/python -m pip freeze | grep coverage')
    if result ~= nil then
      local found = false
      for _ in result:lines() do  -- luacheck: ignore 512
        found = true
        break
      end
      result:close()
      if found then
        dap_python.test_method({config = { args = { "--no-cov" }}})
      else
        dap_python.test_method()
      end
    else
      dap_python.test_method()
    end
  else
    dap_python.test_method()
  end
end)
vim.keymap.set("n", "<leader>dpc", function()
  -- This crazyness is because dap can't run at the same time as coverage. So first check if it is
  -- installed (it will error when disabling otherwise) and disable coverge if it is present.
  local env = os.getenv("VIRTUAL_ENV")
  if env then
    local result = io.popen(env .. '/bin/python -m pip freeze | grep coverage')
    if result ~= nil then
      local found = false
      for _ in result:lines() do  -- luacheck: ignore 512
        found = true
        break
      end
      result:close()
      if found then
        dap_python.test_class({config = { args = { "--no-cov" }}})
      else
        dap_python.test_class()
      end
    else
      dap_python.test_class()
    end
  else
    dap_python.test_class()
  end
end)
vim.keymap.set("n", "<leader>dt", function()
  dapui.toggle()
end)
