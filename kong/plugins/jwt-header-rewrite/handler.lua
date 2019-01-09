local BasePlugin = require "kong.plugins.base_plugin"
local req_set_header = ngx.req.set_header

local JwtHeaderHandler = BasePlugin:extend()


JwtHeaderHandler.PRIORITY = 9999


local function extract_custom_header(request)
    local custom_header = request.get_headers()["Content-TOKEN"]
    if custom_header then
        return custom_header,nil
    else
        return nil,nil
    end
end


function JwtHeaderHandler:new()
    JwtHeaderHandler.super.new(self, "jwt-header-rewrite")
end

function JwtHeaderHandler:access(conf)
    JwtHeaderHandler.super.access(self)
    local token, err = extract_custom_header(ngx.req)
    if not token then
        if conf.open_debug == 1 then
            ngx.log(ngx.ERR,"Content-TOKEN header","not found")
        end
        return
    else
        req_set_header("Authorization"," Bearer "..token)
        if conf.open_debug == 1 then
            ngx.log(ngx.ERR,"header Content-TOKEN convert to:"," Bearer "..token)
        end
    end
end

return JwtHeaderHandler