cache = true
codes = true
std = luajit
ignore = {
  "122", -- Indirectly setting a readonly global
  "111", -- Setting non-standard global variable
}
read_globals = {"vim", "use",}
exclude_files = {"**/packer_compiled.lua"}
