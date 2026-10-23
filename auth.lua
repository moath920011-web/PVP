local KeyAuth = {
    _version = "1.0",
}

function KeyAuth.new(data)
    local self = setmetatable({}, { __index = KeyAuth })
    self.name = data.name
    self.ownerid = data.ownerid
    self.secret = data.secret
    self.version = data.version
    self.authenticated = false
    self.data = {}
    return self
end

function KeyAuth:init()
    local url = "https://keyauth.win/api/1.2/?name=" .. self.name .. "&ownerid=" .. self.ownerid .. "&type=init&ver=" .. self.version
    local success, response = pcall(function()
        return game:HttpGet(url)
    end)
    if success and response then
        -- Initialized successfully
    end
end

function KeyAuth:license(key)
    local url = "https://keyauth.win/api/1.2/?name=" .. self.name .. "&ownerid=" .. self.ownerid .. "&secret=" .. self.secret .. "&type=license&key=" .. key .. "&ver=" .. self.version
    local success, response = pcall(function()
        return game:HttpGet(url)
    end)
    if success and response then
        if string.find(response, '"success":true') then
            self.authenticated = true
            -- استخراج بيانات انتهاء الكي
            self.data.expires = os.time() + 86400 -- مثال افتراضي للصلاحية
        else
            self.authenticated = false
        end
    end
end

return KeyAuth
