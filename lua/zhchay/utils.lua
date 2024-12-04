local M = {}

M.border = "single"

M.icons = {
  File = "󰈙",
  Module = "",
  Namespace = "",
  Package = "",
  Class = "",
  Method = "",
  Property = "",
  Field = "",
  Constructor = "",
  Enum = "",
  Interface = "",
  Function = "",
  Variable = "",
  Constant = "",
  String = "",
  Number = "",
  Boolean = "",
  Array = "",
  Object = "",
  Key = "",
  Null = "",
  EnumMember = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}

-- handle adding keybinds to which-key before it is loaded
local wk = {}
local wkLoaded = false

M.wkAdd = function(entry)
  if not wkLoaded then
    table.insert(wk, entry)
  else
    require("which-key").add(entry)
  end
end

M.wkInit = function()
  wkLoaded = true
  require("which-key").add(wk)
end

-- check if module exists
M.moduleExists = function(name)
  if package.loaded[name] then
    return true
  else
    for _, searcher in ipairs(package.searchers or package.loaders) do
      local loader = searcher(name)
      if type(loader) == 'function' then
        package.preload[name] = loader
        return true
      end
    end
    return false
  end
end

return M
