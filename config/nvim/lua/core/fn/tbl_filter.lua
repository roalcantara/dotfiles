local has_tbl_filter, vi_tbl_filter = pcall(require, 'vim.tbl_filter')

if has_tbl_filter then
  return vi_tbl_filter
end

--- Filter a table
--- @param tbl table The table to filter
--- @param fn function The function to filter the table
--- @return table The filtered table
local function tbl_filter(tbl, fn)
  local filtered = {}
  for _, v in pairs(tbl) do
    if fn(v) then
      filtered[#filtered + 1] = v
    end
  end

  return filtered
end

return tbl_filter
