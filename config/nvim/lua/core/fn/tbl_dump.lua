--- Dump a table for debugging purposes
--- @param t table The table to dump
--- @param indent string The indent to use
local function dump_table(t, indent)
  indent = indent or ""
  if type(t) ~= "table" then
    print(indent .. tostring(t))
    return
  end

  print(indent .. "{")
  for k, v in pairs(t) do
    local key = type(k) == "number" and "[" .. k .. "]" or k
    if type(v) == "table" then
      print(indent .. "  " .. key .. " = {")
      dump_table(v, indent .. "    ")
      print(indent .. "  }")
    else
      print(indent .. "  " .. key .. " = " .. tostring(v))
    end
  end
  print(indent .. "}")
end

return dump_table
