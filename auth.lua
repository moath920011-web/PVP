local KeyAuth = {}

function KeyAuth.new(data)
    local self = setmetatable({}, { __index = KeyAuth })
    self.name = data.name
    self.ownerid = data.ownerid
    self.secret = data.secret
    self.version = data.version or "1.0"
    self.authenticated = false
    return self
end

function KeyAuth:init()
    local url = string.format("https://keyauth.win/api/1.2/?name=%s&ownerid=%s&type=init&ver=%s", self.name, self.ownerid, self.version)
    pcall(function()
        game:HttpGet(url)
    end)
end

function KeyAuth:license(key)
    local url = string.format("https://keyauth.win/api/1.2/?name=%s&ownerid=%s&secret=%s&type=license&key=%s&ver=%s", self.name, self.ownerid, self.secret, key, self.version)
    local success, response = pcall(function()
        return game:HttpGet(url)
    end)
    
    if success and response then
        -- التحقق المرن من رد سيرفر KeyAuth
        if response:match('"success":true') or response:match('"success": "true"') then
            self.authenticated = true
        else
            self.authenticated = false
        end
    else
        self.authenticated = false
    end
end

return KeyAuth
