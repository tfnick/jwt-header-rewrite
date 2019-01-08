package = "jwt-header-rewrite"
version = "1.0-0"
local pluginName = "jwt-header-rewrite"

source = {
  url = "git://github.com/tfnick/jwt-header-rewrite.git",
}

description = {
  summary = "A Kong plugin jwt-header-rewrite",
  license = "Apache 2.0"
}
dependencies = {
  "lua ~> 5.1"
}
build = {
  type = "builtin",
  modules = {
    ["kong.plugins.jwt-header-rewrite.handler"] = "kong/plugins/jwt-header-rewrite/handler.lua",
    ["kong.plugins.jwt-header-rewrite.schema"]  = "kong/plugins/jwt-header-rewrite/schema.lua"
  }
}