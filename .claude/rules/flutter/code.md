# Flutter 代码规范

## 方法约束

- 按功能模块划分，一个功能封装到一个方法
- 单个方法不超过 **100 行**
- 超过 100 行且**有通用性** → 抽离成独立函数/组件
- 超过 100 行但**无通用性** → 按功能拆分成更小的方法
- 复杂逻辑用私有方法（`_handleXxx`）
- 重复 UI 用 `renderXxxItem` 命名抽取

## renderXXX 局部 UI 函数

```dart
/// 注释：绘制待办事项视图
/// 时间：2026/1/31 17:33
/// 作者：郭翰林
Widget renderToDoEventView() { ... }
```

## GetX Controller 生命周期

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

## EventBus 订阅生命周期

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

## 注释规范

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

## 命名规范

| 类型 | 规范 | 示例 |
|------|------|------|
| 工具类 | 大写开头驼峰 + Utils | `TextUtils`, `LyUtils` |
| 组件类 | 大写开头驼峰 | `LySearchBar`, `LyTag` |
| 页面类 | 大写开头驼峰 + Page | `LoginPage`, `HomePage` |
| 控制器 | 大写开头驼峰 + Controller | `AppController`, `HomeController` |
| 常量类 | Ly开头 + 大写驼峰 | `LyColors`, `LyFonts`, `LyCacheKey` |
| 公开方法/变量 | 小写开头驼峰 | `isEmpty`, `userId` |
| 私有方法/变量 | 下划线前缀 | `_handleData`, `_box` |

## Import 顺序

```dart
import 'dart:xxx';                    // Dart 标准库
import 'package:xxx';                  // 第三方包
import 'package:flutter_marvin/xxx';    // 本项目包
// 分组之间留空行
```

## 日志规范

| 级别 | 方法名 | 用途 |
|------|--------|------|
| Debug | `loggerDebug()` | 开发调试 |
| Info | `loggerInfo()` | 一般信息 |
| Warn | `loggerWarn()` | 警告信息 |
| Error | `loggerError()` | 错误信息 |

## 规范速查表

| 场景 | 规范 |
|------|------|
| 方法行数 | 单个方法不超过 100 行 |
| 方法 > 100 行 + 通用性 | 抽离成独立函数/组件 |
| 方法 > 100 行 + 无通用性 | 按功能拆分成更小的方法 |
| UI 函数 | 以 `render` 开头命名 |
| Controller 注册 | `Get.put()` 在 initState，`Get.delete()` 在 dispose |
| EventBus 订阅 | 保存 subscription，在 dispose 中 cancel |