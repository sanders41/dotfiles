cache = true
codes = true
std = luajit
ignore = {
  "122", -- Indirectly setting a readonly global
}
read_globals = {"vim", "use",}
exclude_files = {"**/packer_compiled.lua"}
