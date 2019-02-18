local utils = {}

-- Helper Functions
function utils.integer(boolean)
  return boolean and 1 or 0
end

return utils