###### 修改用户密码：注意使用md5工具类存取密码，使用@PatchMapping注解声明请求方式更新实体类部分字段，@RequestBody解析请求体生成map；
###### 修改用户头像链接：请求参数校验@URL标注合法格式，获取ThreadLocal用户id信息；
###### 实体参数校验：实体类成员变量添加注解，接口方法的实体参数添加@Valicated注解；
###### 获取用户信息：ThreadLocal线程隔离，提前在Interceptor保存用户信息；
###### 获取用户信息：application配置文件开启驼峰命名和下划线的自动转换数据库字段到user字段，哪怕因为格式问题不对应；
###### 获取用户信息：postman在Pre-request Script统一添加token到header；
###### 获取用户信息：spring查询结果转换User为json时，忽略某字段；
###### 登录功能：访问页面前验证token：interceptor实现&注册&过滤接口；
###### 登录功能：登录认证token生成和解析；
###### 注册功能：全局异常处理器；
###### 注册功能：invadation参数校验；
###### 注册功能：lombok生成实体类辅助方法；
###### big_event项目创建结构目录+maven依赖配置；
###### postman安装；
###### MySQL安装+IDEA配置数据库；
###### IntelliJIDEA安装+破解；