# Claude Skills

<div align="center">

![Claude](https://img.shields.io/badge/Claude-AI%20Assistant-blueviolet?style=for-the-badge&logo=anthropic&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge&logo=license&logoColor=white)
![Status](https://img.shields.io/badge/Status-Active-success?style=for-the-badge&logo=github&logoColor=white)

**🚀 生产级项目脚手架工具集 | 一键生成让你的开发快人一步**

*基于 Claude Code Skills 打造的高效开发工具，专注于快速初始化和质量保障*

</div>

---

## ✨ 核心特性

| 特性 | 说明 |
|------|------|
| 🛠️ **一键初始化** | 告别繁琐的项目搭建，快速生成生产级项目结构 |
| 📦 **业界主流技术栈** | 集成业界最优解的框架和工具链 |
| 📋 **统一代码规范** | 内置编码规范、注释模板、日志规范 |
| 🎨 **完整 UI 组件库** | 开箱即用的通用业务组件 |
| 📚 **详尽文档注释** | 代码即文档，注释规范统一 |
| 🔄 **可复用模板** | 抽取通用模块，减少重复开发 |

---

## 🚀 快速开始

### 安装所有技能

```bash
# Flutter 项目脚手架
npx skills add RmondJone/claude_skills@flutter-project-scaffold -g -y

# Spring Boot 项目脚手架
npx skills add RmondJone/claude_skills@springboot-project-scaffold -g -y
```

### 使用方式

当你在 Claude Code 中描述以下场景时，技能将自动激活：

| 触发词 | 对应技能 |
|--------|----------|
| `初始化 Flutter 项目` / `创建 Flutter 项目骨架` | flutter-project-scaffold |
| `初始化项目` / `创建项目骨架` / `快速启动 Spring Boot` | springboot-project-scaffold |

---

## 📦 技能列表

### flutter-project-scaffold

<div align="left">

**Flutter 项目脚手架初始化工具**

```bash
npx skills add RmondJone/claude_skills@flutter-project-scaffold -g -y
```

</div>

#### 触发词

> `初始化 Flutter 项目` · `创建 Flutter 项目骨架` · `快速启动 Flutter 项目` · `创建一个新 Flutter 项目` · `项目结构初始化` · `基于 Flutter 创建新项目`

#### 技术栈

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat-square&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=flat-square&logo=dart&logoColor=white)
![GetX](https://img.shields.io/badge/GetX-4.7.3-blue?style=flat-square)
![Dio](https://img.shields.io/badge/Dio-5.9.0-blue?style=flat-square)
![Hive](https://img.shields.io/badge/Hive-2.2.3-orange?style=flat-square)

#### 核心能力

| 模块 | 说明 |
|------|------|
| **状态管理** | GetX 完整集成，包含生命周期管理 |
| **路由框架** | flutter_tc_router，支持拦截器、权限控制 |
| **网络层** | Dio 封装，统一响应处理、Token 刷新 |
| **本地存储** | Hive 封装，缓存工具类 |
| **事件总线** | EventBus 解耦业务逻辑 |
| **UI 组件库** | 弹窗、搜索框、标签、按钮等通用组件 |
| **代码规范** | 方法行数限制、命名规范、注释模板 |
| **调试工具** | Dokit 集成，支持性能监控 |

#### 包含模板

```
lib/
├── main.dart                     # 应用入口
├── routers.dart                 # 路由配置
├── interceptor.dart             # 路由拦截器
├── defines/                     # 常量定义
│   ├── constants.dart          # 缓存Key、配置类
│   ├── colors.dart             # 颜色常量
│   ├── fonts.dart              # 字体常量
│   └── styles.dart             # 样式常量
├── http/                        # 网络层
│   ├── ly_http.dart           # Dio 封装
│   └── models/                 # 响应模型
├── events/                      # 事件总线
├── utils/                       # 工具类
│   ├── ly_cache.dart          # 缓存封装
│   ├── ly_utils.dart          # 通用工具
│   ├── text_utils.dart        # 文本工具
│   └── time_utils.dart        # 时间工具
├── widgets/                     # 通用组件
│   ├── ly_dialog.dart         # 弹窗
│   ├── ly_search.dart         # 搜索框
│   ├── ly_tag.dart            # 标签
│   └── empty_data_widget.dart # 空数据
└── pages/                       # 页面模块
```

---

### springboot-project-scaffold

<div align="left">

**Spring Boot 项目骨架初始化工具**

```bash
npx skills add RmondJone/claude_skills@springboot-project-scaffold -g -y
```

</div>

#### 触发词

> `初始化项目` · `创建项目骨架` · `快速启动 Spring Boot 项目` · `创建一个新 Spring Boot 项目` · `项目结构初始化` · `基于 Spring Boot 创建新项目`

#### 技术栈

![Java](https://img.shields.io/badge/Java-17-orange?style=flat-square&logo=openjdk&logoColor=white)
![Spring Boot](https://img.shields.io/badge/Spring_Boot-3.2-6DB33F?style=flat-square&logo=springboot&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-8.0-4479A1?style=flat-square&logo=mysql&logoColor=white)
![Redis](https://img.shields.io/badge/Redis-DC382D?style=flat-square&logo=redis&logoColor=white)
![RabbitMQ](https://img.shields.io/badge/RabbitMQ-FF6600?style=flat-square&logo=rabbitmq&logoColor=white)
![MyBatisPlus](https://img.shields.io/badge/MyBatis%20Plus-3.5-red?style=flat-square)

#### 核心能力

| 模块 | 说明 |
|------|------|
| **ORM 框架** | MyBatis Plus，强大的 CRUD 增强能力 |
| **数据库** | MySQL + Flyway 数据库版本管理 |
| **缓存** | Redis 集成，支持分布式缓存 |
| **消息队列** | RabbitMQ 异步消息处理 |
| **认证授权** | JWT Token 安全认证 |
| **接口文档** | SpringDoc OpenAPI 3.0 自动生成 |
| **构建工具** | Gradle 依赖管理 |
| **代码规范** | RESTful 接口设计，所有参数通过 @RequestBody |

#### 项目结构

```
src/main/java/com/example/
├── controller/                  # 控制层
│   └── xxxController.java      # RESTful 接口
├── service/                     # 服务层
│   ├── impl/                   # 服务实现
│   └── IxxxService.java
├── mapper/                      # 数据访问层
│   └── XxxMapper.java
├── entity/                      # 实体类
│   ├── Xxx.java               # 数据库实体
│   ├── XxxDTO.java            # 数据传输对象
│   └── XxxVO.java             # 视图对象
├── config/                      # 配置类
│   ├── RedisConfig.java
│   ├── RabbitMQConfig.java
│   └── SecurityConfig.java
└── common/                      # 通用模块
    ├── R.java                  # 统一响应结构
    └── BaseEntity.java         # 基础实体
```

---

## 🎯 使用示例

### Flutter 项目初始化

```
用户: 帮我初始化一个 Flutter 项目，项目名叫 flutter_demo
Claude: (自动激活 flutter-project-scaffold 技能)
→ 生成完整项目结构
→ 配置 pubspec.yaml 依赖
→ 生成路由、网络层、工具类
→ 提供代码规范说明
```

### Spring Boot 项目初始化

```
用户: 快速启动一个 Spring Boot 项目
Claude: (自动激活 springboot-project-scaffold 技能)
→ 生成标准项目结构
→ 配置 MySQL、Redis、RabbitMQ
→ 生成 CRUD 模板代码
→ 配置 JWT 认证
→ 生成 OpenAPI 接口文档
```

---

## 📊 技术栈总览

### Flutter 技术栈

<p align="left">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter"/>
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart"/>
  <img src="https://img.shields.io/badge/GetX-4.7.3?style=for-the-badge&logo=state-management&logoColor=white" alt="GetX"/>
  <img src="https://img.shields.io/badge/Dio-5.9.0?style=for-the-badge&logo=networking&logoColor=white" alt="Dio"/>
  <img src="https://img.shields.io/badge/Hive-2.2.3?style=for-the-badge&logo=database&logoColor=white" alt="Hive"/>
</p>

### Spring Boot 技术栈

<p align="left">
  <img src="https://img.shields.io/badge/Java-17-orange?style=for-the-badge&logo=openjdk&logoColor=white" alt="Java"/>
  <img src="https://img.shields.io/badge/Spring_Boot-3.2-6DB33F?style=for-the-badge&logo=springboot&logoColor=white" alt="Spring Boot"/>
  <img src="https://img.shields.io/badge/MySQL-8.0-4479A1?style=for-the-badge&logo=mysql&logoColor=white" alt="MySQL"/>
  <img src="https://img.shields.io/badge/Redis-DC382D?style=for-the-badge&logo=redis&logoColor=white" alt="Redis"/>
  <img src="https://img.shields.io/badge/RabbitMQ-FF6600?style=for-the-badge&logo=rabbitmq&logoColor=white" alt="RabbitMQ"/>
</p>

---

## 📄 许可证

本项目基于 [MIT License](LICENSE) 许可证开源。

---

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

<div align="center">

** Made with ❤️ by RmondJone**

</div>
