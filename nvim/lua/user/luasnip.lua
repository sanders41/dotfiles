local status_ok, luasnip = pcall(require, 'luasnip')
if not status_ok then
  print('error loading luasnip')
  return
end

local types = require "luasnip.util.types"

luasnip.config.set_config {
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

luasnip.add_snippets("all", {
  luasnip.add_snippet.parser.parse_snippet("expand", "--hello world"),
})

luasnip.add_snippet("python", {
  luasnip.parser.parse_snippet("ifname", 'if __name__ == "__main__":\n    raise SystemExit(main())'),
})

-- Expand the current item or jump to the next item within a snippet
--vim.keymap.set({ "i", "s" }, "<c-k>", function()
vim.keymap.set({ "i", "s" }, "<c-k>", function()
  if luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  end
end, { silent = true })

-- <c-j> is my jump backwards key.
-- this always moves to the previous item within the snippet
vim.keymap.set({ "i", "s" }, "<c-j>", function()
  if luasnip.jumpable(-1) then
    luasnip.jump(-1)
  end
end, { silent = true })

-- <c-l> is selecting within a list of options.
-- This is useful for choice nodes (introduced in the forthcoming episode 2)
vim.keymap.set("i", "<c-l>", function()
  if luasnip.choice_active() then
    luasnip.change_choice(1)
  end
end)
