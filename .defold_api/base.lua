---@class vector3
---@field x number
---@field y number
---@field z number
---@operator add(vector3): vector3
---@operator sub(vector3): vector3
---@operator div(number): vector3
---@operator mul(number): vector3

---@class vector4
---@field x number
---@field y number
---@field z number
---@field w number
---@operator add(vector4): vector4
---@operator sub(vector4): vector4
---@operator div(number): vector4
---@operator mul(number): vector4

---@class quaternion
---@field x number
---@field y number
---@field z number
---@field w number

---@alias quat quaternion

---@class url
---@field socket hash
---@field path hash
---@field fragment hash

---@alias hash userdata
---@alias constant userdata
---@alias bool boolean
---@alias float number
---@alias object userdata
---@alias matrix4 userdata
---@alias node userdata

--mb use number instead of vector4
---@alias vector vector4

--luasocket
---@alias master userdata
---@alias unconnected userdata
---@alias client userdata

--render
---@alias constant_buffer userdata
---@alias render_target userdata
---@alias predicate userdata

--- Calls error if the value of its argument `v` is false (i.e., **nil** or
--- **false**); otherwise, returns all its arguments. In case of error,
--- `message` is the error object; when absent, it defaults to "assertion
--- failed!"
---@generic ANY
---@overload fun(v:any):any
---@param v ANY
---@param message string
---@return ANY
function assert(v,message) return v end