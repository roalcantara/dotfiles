--- Inspect a table contents
--- @param t table The table to inspect
local function tbl_inspect(t)
  if type(t) ~= 'table' then
    print(tostring(t))
    return
  end

  local result = "{"
  local count = 0
  for k, v in pairs(t) do
    if count > 0 then result = result .. ", " end
    if type(k) == 'number' then
      result = result .. "[" .. k .. "] = " .. tostring(v)
    else
      result = result .. k .. " = " .. tostring(v)
    end
    count = count + 1
  end

  result = result .. "}"
  print(result)
end

return tbl_inspect
