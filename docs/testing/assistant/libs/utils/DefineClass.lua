-- DefineClass.lua: define_class()
-- Checks if all the arguments passed to class:new() are of an accepted type.
-- Checks if required arguments (such as { data }) are missing

return function(name, property_types, arguments) -- Assert would make this "too hard" to read.
  local next = next
  local o = {}
  for _, vararg in pairs(arguments) do
    if type(vararg) == 'table' then
      for _, required_arg in pairs(property_types['required']) do
        if not vararg[required_arg] and not o[required_arg] then
          error(required_arg .. ' is a required argument for ' .. name)
        end
      end
      for property_index, property in pairs(vararg) do
        if property_types[property_index] == nil then 
          error(property_index .. ' is not a valid argument') 
        end
        if type(property) == property_types[property_index][1] then
          if not property or (property_types[property_index][1] == 'table' and next(property) == nil) then
            error(property_index .. " can't be nil or empty")
          end
          o[property_index] = property
          if type(property) == 'table' and property_types[property_index][2] == 'named_args' then
            for property_name, property_value in pairs(property) do
              if property_types[property_name] == nil then 
                error(property_name .. ' is not a valid argument') 
              end      
              if type(property_value) ~= tostring(property_types[property_name][1]) then
                error(property_name .. ' is not of valid type: ' .. property_types[property_name][1])
              end
            end
          end
        else
          error(property_index .. ' is not of valid type: ' .. property_types[property_index][1])
        end
      end
    else
      error('new() takes tables as named arguments')
    end
  end
  return o
end
