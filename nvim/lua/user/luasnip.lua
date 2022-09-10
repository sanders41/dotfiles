local status_ok, ls = pcall(require, "luasnip")
if not status_ok then
  print("error loading luasnip")
  return
end

local types = require "luasnip.util.types"
local s = ls.snippet
-- local c = ls.choice_node
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local f = ls.function_node
-- local d = ls.dyncmic_node

ls.config.set_config {
  history = true,

  -- Update as you type
  updateevents = "TextChanged,TextChangedI",

  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "<- Current Choice" } },
      },
    },
  },
}

-- local same = function(index)
--   return f(function(arg)
--      return arg[1]
--   end, { index })
-- end

-- Python
ls.add_snippets("python", {
  s(
    "ifname",
    fmt([[
def main() -> int:
    {}

    return 0

if __name__ == "__main__":
    raise SystemExit(main())
    ]],
    {
      i(0),
    })),

  s(
    "def",
    fmt([[
def {}({}) -> {}:
    {}
    ]],
    {
      i(1),
      i(2),
      i(3),
      i(4)
    })),

  -- new method
  s(
    "defm",
    fmt([[
def {}(self{}) -> {}:
    {}
    ]],
    {
      i(1),
      i(2),
      i(3),
      i(4),
    })),

  s(
    "@classmethod",
    fmt([[
@classmethod
def {}(cls{}) -> {}:
    {}
    ]],
    {
      i(1),
      i(2),
      i(3),
      i(4),
    })),

  s(
    "@staticmethod",
    fmt([[
@staticmethod
def {}({}) -> {}:
    {}
    ]],
    {
      i(1),
      i(2),
      i(3),
      i(4),
    })),

  s(
    "class",
    fmt([[
class {}:
    def __init__(self{}) -> None:
        {}
  ]],
  {
    i(1),
    i(2),
    f(function(vars)
      local split_vars = vim.split(vars[1][1], ",", true)
      if split_vars == nil then
        return ""
      end
      local return_vars = {}
      for index, split in ipairs(split_vars) do
        -- Skipp the first index because it will be self
        if index > 1 then
          -- Remove : and after (type hint) and = and after (default value)
          local stripped = vim.split(vim.split(split, ":", true)[1], "=", true)[1]
          local trimmed = vim.trim(stripped)

          if trimmed ~= "" and trimmed ~= "*" and trimmed ~= "/" and trimmed ~= "*args" and trimmed ~= "**kwargs" then
            -- After the first variable the editor doesn't space so add the sapaces here.
            local v = "        self." .. trimmed .. " = " .. trimmed

            -- Index 2 is the first varialbe, 1 is self
            if index == 2 then
              v = "self." .. trimmed .. " = " .. trimmed
            end
            table.insert(return_vars, v)
          end
        end
      end

      if next(return_vars) == nil then
        return ""
      end

      return return_vars
    end, { 2 }),
  })),

  -- from __future__ import annotations
  s("future", {
    t({"from __future__ import annotations"}),
  }),
})

-- Rust
ls.add_snippets("rust", {
  s(
    "rt",
    fmt([[
#[cfg(test)]
mod tests {{
    {}
}}
    ]],
    {
      i(1),
    })),
})



-- Expand the current item or jump to the next item within a snippet
vim.keymap.set({ "i", "s" }, "<c-k>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

-- <c-j> is my jump backwards key.
-- this always moves to the previous item within the snippet
vim.keymap.set({ "i", "s" }, "<c-j>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })

-- <c-l> is selecting within a list of options.
-- This is useful for choice nodes (introduced in the forthcoming episode 2)
vim.keymap.set("i", "<c-l>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)

-- shorcut to source luasnips file again, which will reload snippets
vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/lua/user/luasnip.lua<CR>")
