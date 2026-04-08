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
- 使用pencli mcp完成UI绘制之后，让用户自己检查还原度情况，不要调用任何MCP来进行还原度测试

---

## React 代码规范

### 组件定义
- **复杂 UI 组件**：按功能模块划分，抽离成独立的可复用 hook 组件

### 方法约束
- 按功能模块划分，一个功能封装到一个方法
- 单个方法不超过 **100 行**
- 超过 100 行且**有通用性** → 抽离成独立函数/组件
- 超过 100 行但**无通用性** → 按功能拆分成更小的方法
- 复杂逻辑用私有方法（`_handleXxx`）
- 页面绘制代码用 `renderXxx` 命名

### renderXXX 函数规范
- 按功能模块划分，一个功能封装到一个 render 方法
- 单个 render 方法不超过 **100 行**
- 超过 100 行且**有通用性** → 抽离成独立的 hook 组件
- 超过 100 行但**无通用性** → 按功能拆分成更小的 render 方法

### 函数定义规范
- **使用函数声明**：统一使用 `function fn() {}` 形式，不使用箭头函数 `const fn = () => {}`
- **函数提升**：函数声明会提升到作用域顶部，允许在定义前调用
- **私有方法前缀**：复杂逻辑用 `_handleXxx` 命名

### renderXXX 局部 UI 函数
```tsx
// 注释：绘制待办事项视图
// 时间：2026/4/8 10:00
// 作者：郭翰林
function renderToDoEventView() {
  return <div>...</div>;
}

// 事件处理函数
// 注释：处理删除操作
// 时间：2026/4/8 10:00
// 作者：郭翰林
function _handleDelete(id) {
  console.log('delete', id);
}
```

### 组件注释规范
```tsx
// 注释：首页组件
// 时间：2026/4/8 10:00
// 作者：郭翰林
export default function HomePage() {
  // 注释：渲染头部
  // 时间：2026/4/8 10:00
  // 作者：郭翰林
  function renderHeader() {
    return <header>...</header>;
  }

  return (
    <div>
      {renderHeader()}
      <button onClick={() => _handleDelete(1)}>删除</button>
    </div>
  );
}
```

### React Hook 组件抽离标准
| 条件 | 动作 |
|------|------|
| render 方法 ≤ 100 行 | 保持原样 |
| render 方法 > 100 行 + 有通用性 | 抽离成独立的 hook 组件 |
| render 方法 > 100 行 + 无通用性 | 按功能拆分成更小的 render 方法 |

---

## Flutter 代码规范

### 方法约束
- 按功能模块划分，一个功能封装到一个方法
- 单个方法不超过 **100 行**
- 超过 100 行且**有通用性** → 抽离成独立函数/组件
- 超过 100 行但**无通用性** → 按功能拆分成更小的方法
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
| 方法行数 | 单个方法不超过 100 行 |
| 方法 > 100 行 + 通用性 | 抽离成独立函数/组件 |
| 方法 > 100 行 + 无通用性 | 按功能拆分成更小的方法 |
| UI 函数 | 以 `render` 开头命名 |
| Controller 注册 | `Get.put()` 在 initState，`Get.delete()` 在 dispose |
| EventBus 订阅 | 保存 subscription，在 dispose 中 cancel |
