local KeyAuth = {}

function KeyAuth.new(data)
    local self = setmetatable({}, { __index = KeyAuth })
    self.name = data.name
    self.ownerid = data.ownerid
    self.secret = data.secret
    self.version = data.version or "1.0"
    return self
end

function KeyAuth:validate(key)
    local url = string.format("https://keyauth.win/api/1.2/?name=%s&ownerid=%s&secret=%s&type=license&key=%s&ver=%s", 
        self.name, self.ownerid, self.secret, key, self.version)
    
    local success, response = pcall(function()
        return game:HttpGet(url)
    end)
    
    if success and response then
        if response:match('"success":true') or response:match('"success": "true"') then
            return true
        end
    end
    return false
end

return KeyAuth
