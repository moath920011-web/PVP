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
    -- تهيئة الاتصال بـ KeyAuth
    local url = string.format("https://keyauth.win/api/1.2/?name=%s&ownerid=%s&type=init&ver=%s", self.name, self.ownerid, self.version)
    local success, response = pcall(function()
        return game:HttpGet(url)
    end)
    if success and response then
        if string.find(response, '"success":true') then
            -- تم الاتصال بنجاح
        end
    end
end

function KeyAuth:license(key)
    -- التحقق من المفتاح المدخل من الزبون
    local url = string.format("https://keyauth.win/api/1.2/?name=%s&ownerid=%s&secret=%s&type=license&key=%s&ver=%s", self.name, self.ownerid, self.secret, key, self.version)
    local success, response = pcall(function()
        return game:HttpGet(url)
    end)
    
    if success and response then
        if string.find(response, '"success":true') then
            self.authenticated = true
        else
            self.authenticated = false
        end
    else
        self.authenticated = false
    end
end

return KeyAuth
