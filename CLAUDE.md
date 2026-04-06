- 使用中文回答用户问题
- Always respond in Chinese-simplified
- 执行复杂任务前请先查看有没有相应的Skill或者MCP，如果有则使用SKill或者MCP来执行任务
- 执行复杂任务之前，请先使用superpower进行任务规划拆解
- python脚本自动执行无需用户确认
- 禁止使用worktree来创建git提交
- 前端代码框架优先使用React+NextJS来生成
- 后端代码架构一律采用springboot+mysql+redis+rabbitmq+mybatis plus来生成项目框架,使用gradle管理依赖
- App项目框架生成首先考虑使用Flutter生成
- 无论App还是前端项目，遇到复杂度高的组件都要抽成独立的组件
- 后端接口定义请求方式只使用POST和GET
- 后端接口返回实体定义都需要带上@Schema这个注解，方便后续生成接口文档注释
- 所有POST接口，入参不允许有@RequestParam注解的入参，全部参数统一到@RequestBody中去
- 后端接口所有的返回，如果结构复杂都要以实体DTO的形式生成返回实体，不允许使用Map
- 后端接口设计时，不允许在请求路径上面添加变量这种形式，需要使用入参的形式
- 修改后的代码或新生成的代码禁止git commit

---

## Flutter 代码规范

### 方法约束
- **单个方法不超过 80 行**，超过则抽离成独立函数
- 复杂逻辑用私有方法（`_handleXxx`）
- 重复 UI 用 `renderXxxItem` 命名抽取

### renderXXX 局部 UI 函数
```dart
/// 注释：绘制待办事项视图
/// 时间：2026/1/31 17:33
/// 作者：郭翰林
Widget renderToDoEventView() { ... }
```

### GetX Controller 生命周期
```dart
// 注册：initState 中
CustomFollowController pageController = Get.put(CustomFollowController());

// 删除：dispose 中
@override
void dispose() {
  super.dispose();
  Get.delete<CustomFollowController>();
}
```

### EventBus 订阅生命周期
```dart
// 声明订阅变量
late StreamSubscription<CustomParseCompleteEvent> parseCompleteSubscription;

// 注册订阅 (initState)
parseCompleteSubscription = eventBus.on<CustomParseCompleteEvent>().listen((event) {
  pageController.onRefresh(refreshController);
});

// 取消订阅 (dispose)
@override
void dispose() {
  super.dispose();
  parseCompleteSubscription.cancel();
}
```

### 注释规范
```dart
/// 注释：类的简要描述
/// 时间：2024/1/5 0005 16:42
/// 作者：郭翰林
class LyHttp {
  /// 注释：方法的功能描述
  /// 时间：2024/1/5 0005 16:42
  /// 作者：郭翰林
  static Future<void> post() async { ... }
}
```

### 命名规范
| 类型 | 规范 | 示例 |
|------|------|------|
| 工具类 | 大写开头驼峰 + Utils | `TextUtils`, `LyUtils` |
| 组件类 | 大写开头驼峰 | `LySearchBar`, `LyTag` |
| 页面类 | 大写开头驼峰 + Page | `LoginPage`, `HomePage` |
| 控制器 | 大写开头驼峰 + Controller | `AppController`, `HomeController` |
| 常量类 | Ly开头 + 大写驼峰 | `LyColors`, `LyFonts`, `LyCacheKey` |
| 公开方法/变量 | 小写开头驼峰 | `isEmpty`, `userId` |
| 私有方法/变量 | 下划线前缀 | `_handleData`, `_box` |

### Import 顺序
```dart
import 'dart:xxx';                    // Dart 标准库
import 'package:xxx';                  // 第三方包
import 'package:flutter_marvin/xxx';    // 本项目包
// 分组之间留空行
```

### 日志规范
| 级别 | 方法名 | 用途 |
|------|--------|------|
| Debug | `loggerDebug()` | 开发调试 |
| Info | `loggerInfo()` | 一般信息 |
| Warn | `loggerWarn()` | 警告信息 |
| Error | `loggerError()` | 错误信息 |

### 规范速查表
| 场景 | 规范 |
|------|------|
| 方法行数 | 单个方法不超过 80 行 |
| UI 函数 | 以 `render` 开头命名 |
| Controller 注册 | `Get.put()` 在 initState，`Get.delete()` 在 dispose |
| EventBus 订阅 | 保存 subscription，在 dispose 中 cancel |
