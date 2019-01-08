
### 插件顺序

jwt-header-rewrite -> jwt | sign-verify -> quota-check -> charge-msg-produce

### 插件级别

jwt-header-rewrite(global) -> jwt | sign-verify(route) -> quota-check(route) -> charge-msg-produce(route)


### quota-check主要功能

基于全局共享缓存ngx-sharr-DICT实现，当计费系统发现账户余额不足，调用网关的admin-api更新数据库以及全局缓存，实现客户quota不足的访问控制


### jwt-header-rewrite主要功能

将吉荣数网关的定制jwtToken转换为kong中的Bearer类型表示比如

```
Content-TOKEN:eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJkOTg0ZDg5MDMzZmE0MDE0OTQ2YThhYTE4MjA5NDc1YiIsImV4cCI6MTU0ODE3NTU2Nn0.mRPVYmGS0l9ZCA-i28PA9JCi_vkKRqzpr6vno-Sd69U

```
表示为：

```
Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJkOTg0ZDg5MDMzZmE0MDE0OTQ2YThhYTE4MjA5NDc1YiIsImV4cCI6MTU0ODE3NTU2Nn0.mRPVYmGS0l9ZCA-i28PA9JCi_vkKRqzpr6vno-Sd69U

```
即：Authorization: Bearer <token> 的表示形式


### sign签名验证

实现老接口的sign签名方法，兼容老接口

### charge-msg-produce

基于kafka 发送计费消息，实现网关统一的计费.

