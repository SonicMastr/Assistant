-- sheet.lua: max()
-- Returns the maximum within data or n of them

local growTable = utils.growTable
return function(data, n)
  if not n then return math.max(unpack(data)) end
  local t = (function() local a={} for k,v in next, data, nil do a[k]=v end return a end)()
  table.sort(t, function(at, of) return at > of end)
  local min = growTable(t, n)
  return min
end