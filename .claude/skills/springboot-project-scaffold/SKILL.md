---
name: springboot-project-scaffold
description: |
  Spring Boot项目骨架初始化工具。当用户提到"初始化项目"、"创建项目骨架"、"快速启动Spring Boot项目"、"创建一个新Spring Boot项目"、"项目结构初始化"、"基于Spring Boot创建新项目"时使用此skill。
  提炼了Spring Boot 3.2 + MySQL + Redis + RabbitMQ + MyBatis Plus + JWT认证 + Flyway数据库迁移 + SpringDoc OpenAPI的完整技术架构。
triggers:
  - 初始化项目
  - 创建项目骨架
  - Spring Boot项目
  - 快速启动
  - 新项目框架
---

# Spring Boot 项目骨架初始化 Skill

## 概述

此Skill用于快速初始化一个生产级的Spring Boot后端项目骨架，基于 **Spring Boot 3.2.0 + Java 17**，整合了 **MySQL、Redis、RabbitMQ、MyBatis Plus、JWT认证、Flyway数据库迁移、SpringDoc OpenAPI** 等常用技术栈。

## 技术栈清单

| 分类 | 技术 | 版本 |
|------|------|------|
| 框架 | Spring Boot | 3.2.0 |
| 数据库 | MySQL | 8.0 |
| ORM | MyBatis Plus | 3.5.5 |
| 缓存 | Redis | 7 |
| 消息队列 | RabbitMQ | 3.12 |
| 数据库迁移 | Flyway | - |
| 认证 | JWT (jjwt) | 0.12.3 |
| 工具库 | Hutool | 5.8.25 |
| API文档 | SpringDoc OpenAPI | 2.3.0 |
| 日志 | Logstash Encoder | 7.4 |
| 构建工具 | Gradle | 8.5 |

## 项目目录结构

```
src/main/java/com/{company}/{project}/
├── {ProjectApplication}.java          # 启动类
├── config/                            # 配置类
│   ├── AppConfig.java                # 业务配置属性
│   ├── RedisConfig.java              # Redis配置
│   ├── SecurityConfig.java           # Spring Security配置
│   ├── MybatisPlusConfig.java        # MyBatis Plus配置
│   ├── JacksonConfig.java            # Jackson配置
│   └── OpenApiConfig.java            # Swagger配置
├── controller/                        # REST API控制器
│   ├── AuthController.java           # 认证接口示例
│   └── UserController.java          # 用户接口示例
├── service/                          # 业务逻辑层
│   ├── impl/                         # 业务实现
│   └── (Service接口)
├── mapper/                           # MyBatis Mapper接口
├── entity/                           # 数据库实体
├── dto/
│   ├── request/                      # 请求DTO
│   └── response/                     # 响应DTO
├── common/                           # 通用组件
│   ├── Result.java                   # 统一响应封装
│   ├── ResultCode.java              # 响应码枚举
│   └── exception/                   # 异常处理
│       ├── BusinessException.java
│       └── GlobalExceptionHandler.java
├── filter/                           # 过滤器
│   ├── TraceIdFilter.java           # 日志追踪ID
│   └── JwtAuthenticationFilter.java # JWT认证过滤器
├── advice/                           # 响应增强
│   └── TraceIdResponseBodyAdvice.java
└── util/                             # 工具类
    ├── JwtUtil.java                 # JWT工具类
    ├── RedisKeys.java               # Redis Key规范
    └── ValidationUtil.java           # 验证工具类

src/main/resources/
├── application.yml                   # 主配置文件
├── application-docker.yml           # Docker环境配置
├── logback-spring.xml               # 日志配置(Loki)
└── db/migration/                    # Flyway迁移脚本
    └── V1__init_schema.sql

src/test/java/                        # 测试代码
build.gradle                          # Gradle构建配置
settings.gradle                       # Gradle设置
docker-compose.yml                    # Docker容器编排
Dockerfile                            # Docker镜像构建
```

## 核心组件说明

### 1. 统一响应格式 (Result<T>)

所有API响应使用统一的`Result<T>`格式：

```java
@Data
public class Result<T> {
    private Integer code;       // 状态码
    private String message;     // 消息
    private T data;            // 数据
    private String traceId;    // 日志追踪ID
}
```

**使用示例：**
```java
// 成功响应
return Result.success(data);
return Result.success("操作成功");
return Result.success("操作成功", data);

// 错误响应
return Result.error("操作失败");
return Result.error(400, "参数错误");
```

### 2. 响应码枚举 (ResultCode)

定义系统级响应码：

```java
public enum ResultCode {
    SUCCESS(200, "操作成功"),
    BAD_REQUEST(400, "请求参数错误"),
    UNAUTHORIZED(401, "用户未登录，请先登录"),
    FORBIDDEN(403, "用户没有权限，禁止访问"),
    NOT_FOUND(404, "请求路径不存在"),
    INTERNAL_ERROR(500, "服务器内部错误"),
    // 业务错误码 1xxx
    USER_NOT_FOUND(1001, "用户不存在"),
    USER_ALREADY_EXISTS(1002, "用户已存在"),
    // ...更多业务码
}
```

### 3. 业务异常 (BusinessException)

```java
throw new BusinessException(ResultCode.USER_NOT_FOUND);
throw new BusinessException(1001, "自定义错误信息");
```

### 4. 全局异常处理器 (GlobalExceptionHandler)

自动处理以下异常并返回统一格式：
- `BusinessException` - 业务异常
- `MethodArgumentNotValidException` - 参数校验异常
- `BindException` - 绑定异常
- `NoHandlerFoundException` - 404异常
- `Exception` - 其他系统异常

### 5. JWT认证流程

**JwtAuthenticationFilter** 负责从请求头解析JWT Token：
```java
// 请求头格式
Authorization: Bearer <token>
// 或直接传token
Authorization: <token>
```

**JWT Payload包含：**
```json
{
  "userId": "用户唯一ID",
  "username": "用户名",
  "role": 0,
  "iat": 1234567890,
  "exp": 1234567890
}
```

**安全配置要点：**
- 密码使用 `BCryptPasswordEncoder` 加密
- 无状态Session (`STATELESS`)
- `USER`角色访问普通接口
- `ADMIN`角色访问`/api/admin/**`接口

### 6. Redis Key规范 (RedisKeys)

```
code:{type}:{value}                    # 验证码
code:register:{type}:{value}           # 注册验证码
user:token:{token}                    # 用户Token
user:info:{userId}                    # 用户信息缓存
token:blacklist:{token}               # Token黑名单
resetpwd:{type}:{value}                # 重置密码限制
product:like:{productId}:{userId}     # 产品点赞
comment:like:{commentId}:{userId}      # 评论点赞
```

### 7. 数据库迁移 (Flyway)

迁移脚本命名规范：`V{版本号}__{描述}.sql`

```sql
-- V1__init_schema.sql
CREATE TABLE IF NOT EXISTS `user` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `user_id` VARCHAR(32) NOT NULL COMMENT '用户唯一标识',
    `username` VARCHAR(50) NOT NULL COMMENT '用户名',
    -- ...
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

## 配置文件模板

### application.yml 核心配置

```yaml
spring:
  application:
    name: ${PROJECT_NAME}
  profiles:
    active: dev
  jackson:
    date-format: yyyy-MM-dd HH:mm:ss
    time-zone: GMT+8
  datasource:
    driver-class-name: com.mysql.cj.jdbc.Driver
    url: jdbc:mysql://localhost:3306/${DB_NAME}?useUnicode=true&characterEncoding=utf8&serverTimezone=Asia/Shanghai&useSSL=false
    username: root
    password: ${DB_PASSWORD}
  data:
    redis:
      host: localhost
      port: 6379
      password: ${REDIS_PASSWORD}
  rabbitmq:
    host: localhost
    port: 5672
    username: guest
    password: guest

server:
  port: ${APP_PORT:8080}
  servlet:
    context-path: /api

mybatis-plus:
  mapper-locations: classpath*:/mapper/**/*.xml
  type-aliases-package: com.${company}.${project}.entity
  configuration:
    map-underscore-to-camel-case: true

springdoc:
  api-docs:
    path: /v3/api-docs
  swagger-ui:
    path: /swagger-ui.html

app:
  jwt-secret: ${JWT_SECRET}
  jwt-issuer: ${PROJECT_NAME}
  enable-real-notification: false
```

### Docker Compose 模板

```yaml
services:
  app:
    build: .
    ports:
      - "${APP_PORT}:${APP_PORT}"
    environment:
      - SPRING_PROFILES_ACTIVE=docker
      - SPRING_DATASOURCE_URL=jdbc:mysql://mysql:3306/${DB_NAME}
      - SPRING_REDIS_HOST=redis
      - SPRING_RABBITMQ_HOST=rabbitmq
    depends_on:
      mysql:
        condition: service_healthy
      redis:
        condition: service_healthy

  mysql:
    image: mysql:8.0
    environment:
      - MYSQL_ROOT_PASSWORD=${MYSQL_PASSWORD}
      - MYSQL_DATABASE=${DB_NAME}
    healthcheck:
      test: ["CMD", "mysqladmin", "ping"]
    volumes:
      - mysql_data:/var/lib/mysql

  redis:
    image: redis:latest
    command: redis-server --requirepass ${REDIS_PASSWORD}
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]

volumes:
  mysql_data:
```

## API设计规范

### Controller规范

```java
@Tag(name = "用户接口", description = "用户相关操作")
@RestController
@RequestMapping("/user")
@RequiredArgsConstructor
public class UserController {

    @Operation(summary = "获取用户信息")
    @GetMapping("/info")
    public Result<UserResponse> getUserInfo(@AuthenticationPrincipal String userId) {
        // 使用@AuthenticationPrincipal获取当前登录用户ID
        return Result.success(userService.getUserInfo(userId));
    }
}
```

### DTO规范

**请求DTO** - 使用`@Valid`和`@RequestBody`：
```java
@Data
public class CreateUserRequest {
    @Schema(description = "用户名")
    @NotBlank(message = "用户名不能为空")
    @Size(min = 3, max = 50)
    private String username;

    @Schema(description = "邮箱")
    @NotBlank
    @Email
    private String email;
}
```

**响应DTO** - 使用`@Schema`注解生成文档：
```java
@Data
@Builder
public class UserResponse {
    @Schema(description = "用户ID")
    private String userId;

    @Schema(description = "用户名")
    private String username;

    @Schema(description = "邮箱")
    private String email;
}
```

### 接口路径规范

| 前缀 | 说明 | 认证 |
|------|------|------|
| `/auth/**` | 认证接口 | 否 |
| `/user/**` | 用户接口 | 是 |
| `/admin/**` | 管理接口 | 是(ADMIN) |
| `/api/public/**` | 公开接口 | 否 |

### 请求方式规范

- **GET**: 查询操作
- **POST**: 创建操作、更新操作、删除操作

**注意：POST接口禁止使用`@RequestParam`，所有参数统一使用`@RequestBody`**

## 使用流程

1. **分析需求** - 确定项目名称、模块、功能
2. **生成项目结构** - 创建目录和基础文件
3. **配置参数** - 填充数据库、Redis等配置
4. **实现业务代码** - 按照分层架构实现

## 注意事项

- 所有POST请求参数必须使用`@RequestBody`
- 响应实体必须使用`@Schema`注解
- 数据库表命名使用下划线，Java字段使用驼峰
- Redis Key统一使用`RedisKeys`工具类管理
- 日志必须包含`traceId`用于追踪
