local has_tbl_map, vi_tbl_map = pcall(require, 'vim.tbl_map')
if has_tbl_map then
  return vi_tbl_map
end

--- Map a function over a table
--- @param tbl table The table to map over
--- @param fn function The function to map over the table
--- @return table The mapped table
local function tbl_map(tbl, fn)
  local mapped = {}
  for _, v in pairs(tbl) do
    mapped[#mapped + 1] = fn(v)
  end
  return mapped
end

return tbl_map
