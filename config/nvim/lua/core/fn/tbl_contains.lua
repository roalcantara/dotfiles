local has_tbl_contains, vi_tbl_contains = pcall(require, 'vim.tbl_contains')

if has_tbl_contains then
  return vi_tbl_contains
end

--- Check if a table contains a value
--- @param tbl table The table to check
--- @param value any The value to check for
--- @return boolean true if the value is in the table, false otherwise
local function tbl_contains(tbl, value)
  for _, v in ipairs(tbl) do
    if v == value then
      return true
    end
  end
  return false
end

return tbl_contains
