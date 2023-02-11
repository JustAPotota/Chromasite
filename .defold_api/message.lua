---Messaging API documentation
---Functions for passing messages and constructing URL objects.
---@class msg
msg = {}
---Post a message to a receiving URL. The most common case is to send messages
---to a component. If the component part of the receiver is omitted, the message
---is broadcast to all components in the game object.
---The following receiver shorthands are available:
---
---
--- * "." the current game object
---
--- * "#" the current component
---
--- There is a 2 kilobyte limit to the message parameter table size.
---@param receiver string|url|hash The receiver must be a string in URL-format, a URL object or a hashed string.
---@param message_id string|hash The id must be a string or a hashed string.
---@param message table|nil a lua table with message parameters to send.
function msg.post(receiver, message_id, message) end

---@return url
---@overload fun(urlstring: string): url
---@overload fun(socket: string|hash|nil, path: string|hash|nil, fragment: string|hash|nil): url
function msg.url() end




return msg