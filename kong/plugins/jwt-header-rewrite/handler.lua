---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by yangxiao.
--- DateTime: 2019/1/8 14:31
---


local BasePlugin = require "kong.plugins.base_plugin"
local req_set_header = ngx.req.set_header

local JwtHeaderHandler = BasePlugin:extend()

-- high priority

JwtHeaderHandler.PRIORITY = 1

-- return [token,err]

local function extract_custom_header(request)
    local custom_header = request.get_headers()["Content-TOKEN"]
    if custom_header then
        return custom_header,nil
    else
        return nil,nil
    end
end

-- plugin init

function TokenAuthHandler:new()
    TokenAuthHandler.super.new(self, "jwt-header-rewrite")
end

-- plugin handle http request
function JwtHeaderHandler:access(conf)
    JwtHeaderHandler.super.access(self)
    local token, err = extract_custom_header(ngx.req)
    if not token then
        if conf.open_debug == 1 then
            ngx.log("Content-TOKEN header not found in request headers")
        end
        return
    else
        req_set_header("Authorization"," Bearer "..token)
        if conf.open_debug == 1 then
            ngx.log("header Content-TOKEN convert to:" .. " Bearer "..token)
        end
    end
end