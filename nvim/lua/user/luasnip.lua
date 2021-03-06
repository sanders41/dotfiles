local status_ok, ls = pcall(require, 'luasnip')
if not status_ok then
  print('error loading luasnip')
  return
end

local types = require "luasnip.util.types"
local snippet = ls.snippet

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

ls.add_snippets("python", {
  snippet("ifname", {
    ls.text_node({"def main() -> int:", "    return 0", "", "", 'if __name__ == "__main__":', "    raise SystemExit(main())"}),
  })
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
