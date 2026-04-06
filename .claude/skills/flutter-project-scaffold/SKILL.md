---
name: flutter-project-scaffold
description: Flutter 项目脚手架初始化工具。当用户提到"初始化 Flutter 项目"、"创建 Flutter 项目骨架"、"快速启动 Flutter 项目"、"创建一个新 Flutter 项目"、"项目结构初始化"、"基于 Flutter 创建新项目"时使用此 skill。包含完整的项目架构：状态管理(GetX)、路由(flutter_tc_router)、网络层(Dio封装)、本地存储(Hive)、UI组件库、EventBus、埋点等。
version: 1.0.0
---

# Flutter 项目脚手架初始化

本 skill 用于快速初始化 Flutter 项目，集成以往项目中使用的主流框架和工具链。

## 项目信息

- Dart SDK: ^3.9.0
- 屏幕适配基准: 375x812 (iPhone X)
- 包名格式: `flutter_{项目名}`

---

## 代码规范

### 一、方法约束

#### 1.1 方法行数限制

**单个方法不超过 80 行**，超过则需要抽离成独立函数。

- 复杂逻辑抽取为私有方法（`_handleXxx`）
- 重复 UI 抽取为独立方法（`renderXxxItem`）

#### 1.2 renderXXX 局部 UI 函数

**命名规则**：`render` 开头 + 描述性名称 + 返回 `Widget`

```dart
/// 注释：绘制待办事项视图
/// 时间：2026/1/31 17:33
/// 作者：郭翰林
Widget renderToDoEventView() { ... }

/// 注释：绘制待办 Item
/// 时间：2026/2/3 11:11
/// 作者：郭翰林
Widget renderTodoListItem(TodoListItem item) { ... }
```

### 二、GetX Controller 生命周期

#### 2.1 Controller 注册与删除

```dart
class CustomFollowPageState extends State<CustomFollowPage> {
  CustomFollowController pageController = Get.put(CustomFollowController());

  @override
  void initState() {
    super.initState();
    // ...
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<CustomFollowController>(); // 页面销毁时删除 Controller
  }
}
```

#### 2.2 EventBus 订阅注册与删除

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
  Get.delete<CustomFollowController>();
}
```

### 三、注释规范

```dart
/// 注释：类的简要描述
/// 时间：2024/1/5 0005 16:42
/// 作者：郭翰林
class LyHttp {
  /// 注释：方法的功能描述
  /// 时间：2024/1/5 0005 16:42
  /// 作者：郭翰林
  static Future<void> post() async {
    // ...
  }
}
```

### 四、命名规范

| 类型 | 规范 | 示例 |
|------|------|------|
| 工具类 | 大写开头驼峰 + Utils | `TextUtils`, `LyUtils` |
| 组件类 | 大写开头驼峰 | `LySearchBar`, `LyTag` |
| 页面类 | 大写开头驼峰 + Page | `LoginPage`, `HomePage` |
| 控制器 | 大写开头驼峰 + Controller | `AppController`, `HomeController` |
| 常量类 | Ly开头 + 大写驼峰 | `LyColors`, `LyFonts`, `LyCacheKey` |
| 公开方法 | 小写开头驼峰 | `isEmpty`, `getData` |
| 私有方法 | 下划线前缀 | `_handleData` |
| 公开变量 | 小写开头驼峰 | `userId`, `isLogin` |
| 私有变量 | 下划线前缀 | `_box`, `_instance` |

### 五、Import 顺序

```dart
import 'dart:xxx';                    // Dart 标准库
import 'package:xxx';                  // 第三方包
import 'package:flutter_marvin/xxx';  // 本项目包
// 分组之间留空行
```

### 六、日志规范

| 级别 | 方法名 | 用途 |
|------|--------|------|
| Debug | `loggerDebug()` | 开发调试 |
| Info | `loggerInfo()` | 一般信息 |
| Warn | `loggerWarn()` | 警告信息 |
| Error | `loggerError()` | 错误信息 |

### 七、规范速查表

| 场景 | 规范 |
|------|------|
| 方法行数 | 单个方法不超过 80 行 |
| UI 函数 | 以 `render` 开头命名 |
| Controller 注册 | `Get.put()` 在 initState，`Get.delete()` 在 dispose |
| EventBus 订阅 | 保存 subscription，在 dispose 中 cancel |
| 类注释 | `/// 注释：xxx \n/// 时间：yyyy/M/d HH:mm \n/// 作者：姓名` |

---

## 一、pubspec.yaml 依赖库

### 核心依赖

```yaml
dependencies:
  flutter:
    sdk: flutter

  # 状态管理
  get: 4.7.3

  # 网络请求
  dio: 5.9.0
  logger: 2.6.2

  # 路由框架 (本地路径依赖)
  flutter_tc_router:
    path: ./flutter_tc_router

  # 基础UI组件 (本地路径依赖)
  flutter_tc_base_ui:
    path: ./flutter_tc_base_ui
  flutter_tc_ui:
    path: ./flutter_tc_ui

  # Dialog组件 (本地路径依赖)
  flutter_tc_dialog:
    path: ./flutter_tc_dialog

  # 下载管理 (本地路径依赖)
  flutter_download_manager:
    path: ./flutter_download_manager

  # 本地存储
  hive: 2.2.3
  path_provider: 2.1.5

  # 屏幕适配
  flutter_screenutil: 5.9.3

  # Toast & Loading
  fluttertoast: 9.0.0
  flutter_easyloading: 3.0.5

  # 事件总线
  event_bus: 2.0.1

  # WebSocket
  stomp_dart_client: 3.0.1

  # 图片缓存
  cached_network_image: 3.4.1
  flutter_image_compress: 2.4.0

  # 国际化
  flutter_localizations:
    sdk: flutter

  # UI组件
  cupertino_icons: 1.0.8

  # 本地通知
  flutter_local_notifications: 19.5.0

  # 生物验证
  local_auth: 3.0.0
  local_auth_android: 2.0.3
  local_auth_darwin: 2.0.1

  # 权限申请
  permission_handler: 12.0.1

  # 图表
  fl_chart: 1.1.1

  # 文件选择
  file_picker: 10.3.7
  open_filex: 4.7.0

  # WebView
  webview_flutter: 4.13.0

  # 加密
  encrypt: 5.0.3

  # Markdown
  flutter_markdown_plus: 1.0.5

  # 埋点
  sensors_analytics_flutter_plugin: 4.2.1

  # 调试工具 (仅 debug)
  dokit:
    path: ./dokit

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: 6.0.0
```

## 二、项目目录结构

```
lib/
├── main.dart                    # 应用入口
├── routers.dart                 # 路由配置
├── interceptor.dart             # 路由拦截器
├── ly_base_state.dart          # 页面基类
├── defines/                     # 常量定义
│   ├── constants.dart          # 缓存Key、配置类、文件类型
│   ├── colors.dart             # 颜色常量
│   ├── fonts.dart              # 字体大小常量
│   └── styles.dart             # 样式常量
├── http/                        # 网络层
│   ├── ly_http.dart           # Dio 封装
│   └── models/
│       ├── response.dart      # 响应基类
│       ├── result.dart        # Result 接口
│       └── ly_base_bean.dart  # Bean 基类
├── events/                      # 事件总线
│   └── event_bus.dart
├── utils/                       # 工具类
│   ├── ly_cache.dart          # 缓存封装 (Hive)
│   ├── ly_utils.dart          # 通用工具
│   ├── ly_channel.dart        # Native 通信
│   ├── text_utils.dart        # 文本工具
│   ├── time_utils.dart        # 时间工具
│   ├── image_utils.dart       # 图片工具
│   ├── file_utils.dart        # 文件工具
│   ├── aes_encryption_util.dart # AES加密
│   ├── permission_utils.dart  # 权限工具
│   ├── notifications_helper.dart # 通知辅助
│   └── storage/
│       └── tc_storage_util.dart # 存储工具
├── widgets/                     # 通用组件
│   ├── ly_dialog.dart         # 弹窗
│   ├── ly_search.dart         # 搜索框
│   ├── ly_tag.dart            # 标签
│   ├── ly_badge.dart          # 角标
│   ├── ly_tab.dart            # 标签页
│   ├── empty_data_widget.dart # 空数据
│   ├── clear_btn_widget.dart  # 清除按钮
│   ├── button/                # 按钮组件
│   │   ├── ly_base_button.dart
│   │   ├── ly_common_button.dart
│   │   ├── ly_bottom_button.dart
│   │   └── ly_assist_button.dart
│   ├── charts/               # 图表组件
│   │   └── ly_line_chart.dart
│   ├── popup/                # 弹窗组件
│   │   ├── ly_base_popup.dart
│   │   ├── popup_window.dart
│   │   ├── select_item_list_pop.dart
│   │   └── widget/
│   ├── tabs/                 # 标签组件
│   │   └── ly_tab.dart
│   ├── assets/               # 资源组件
│   │   ├── chat_assets_perview.dart
│   │   └── chat_image_page_builder.dart
│   └── floating/             # 悬浮组件
│       └── floating_view.dart
├── pages/                     # 页面模块
│   ├── roots/                # 首页/根页面
│   │   ├── root_page.dart
│   │   ├── app_controller.dart
│   │   ├── models/
│   │   └── views/
│   ├── login/                # 登录模块
│   ├── workbench/            # 工作台
│   ├── customManager/        # 客户管理
│   ├── customerDetail/       # 客户详情
│   ├── intelligentRecommend/  # 智能推荐
│   └── question/             # 问答
└── dokits/                    # 调试工具
    ├── doraemon_manager.dart
    ├── ly_kit.dart
    └── tests/
```

## 三、核心代码模板

### 3.1 main.dart 入口文件

```dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tc_router/tc_flutter_router.dart';
import 'package:get/get.dart';

import 'routers.dart';
import 'interceptor.dart';
import 'ly_base_state.dart';
import 'utils/logger_utils.dart';

void main() {
  initApp();
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // 添加路由表
    TcFlutterRouter.instance.addPages(LyRouters.routes);
    // 添加路由拦截器
    TcFlutterRouter.instance.addRouterIntercept(LyInterceptor());
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) {
        return GetMaterialApp(
          title: "AppName",
          navigatorKey: appNavigatorKey,
          theme: ThemeData(
            primaryIconTheme: const IconThemeData(color: Colors.black),
            platform: TargetPlatform.iOS,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          home: const SplashPage(),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('zh', 'CN'),
            Locale('en', 'US'),
          ],
          locale: const Locale('zh', 'CN'),
          builder: EasyLoading.init(
            builder: (_, child) {
              return GestureDetector(
                onTap: () => _hideKeyboard(context),
                child: child,
              );
            },
          ),
          initialBinding: InitBinding(),
          navigatorObservers: [
            TcFlutterRouterObserver.init(),
            routeObserver,
          ],
        );
      },
    );
  }
}

void initApp() {
  // 锁定竖屏
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // 沉浸式状态栏
  if (Platform.isAndroid) {
    SystemUiOverlayStyle style = const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    );
    SystemChrome.setSystemUIOverlayStyle(style);
  }
}

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AppController>(AppController());
  }
}

void _hideKeyboard(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}

final GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();
```

### 3.2 路由配置 (routers.dart)

```dart
import 'package:flutter/material.dart';
import 'package:flutter_tc_router/tc_flutter_router.dart';
import 'package:logger/logger.dart';

class LyRouters {
  // 路由常量
  static const String rootPage = "app/home";
  static const String loginPage = "app/login";

  static Map<String, TcFlutterPageBuilder> routes = {
    rootPage: (params) => const RootPage(),
    loginPage: (params) => const LoginPage(),
    // 添加新页面...
  };

  // 路由跳转
  static Future push(BuildContext context, String uri, {Map<String, dynamic>? params}) async {
    return await TcFlutterRouter.instance.push(context, uri, params: params);
  }

  static void pop(BuildContext context) {
    TcFlutterRouter.instance.pop(context);
  }

  static void popTo(BuildContext context, String uri) {
    TcFlutterRouter.instance.popTo(context, uri);
  }

  static Future pushAndRemoveUntil(BuildContext context, String uri, {Map<String, dynamic>? params}) async {
    return await TcFlutterRouter.instance.pushAndRemoveUntil(
      context,
      uri,
      (route) => route.isFirst,
      params: params,
    );
  }
}

final Logger logger = Logger();
void loggerDebug(String msg) => logger.d(msg);
void loggerInfo(String msg) => logger.i(msg);
void loggerError(String msg) => logger.e(msg);
```

### 3.3 路由拦截器 (interceptor.dart)

```dart
import 'package:flutter/material.dart';
import 'package:flutter_tc_router/tc_flutter_router.dart';
import 'routers.dart';

class LyInterceptor implements TcFlutterRouterIntercept {
  @override
  Future<bool> willPush(
    BuildContext context,
    String routeName,
    String? customName,
    Map<String, dynamic>? params,
  ) async {
    switch (routeName) {
      case LyRouters.loginPage:
        // 登录拦截逻辑
        break;
      case LyRouters.rootPage:
        // 首页拦截逻辑
        break;
    }
    return true;
  }

  @override
  Future<bool> willPushReplacement(
    BuildContext context,
    String routeName,
    String? customName,
    Map<String, dynamic>? params,
  ) async {
    return Future.value(true);
  }
}
```

### 3.4 网络层 (ly_http.dart)

```dart
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../defines/constants.dart';
import '../utils/ly_cache.dart';
import '../utils/ly_utils.dart';
import '../main.dart';
import 'models/response.dart';

class LyHttp {
  // 环境配置
  static const String baseApiTest = "https://api-test.example.com";
  static const String baseApiRelease = "https://api.example.com";

  static String baseUri = baseApiTest;
  static const int successCode = 0;

  // POST 请求
  static Future<dynamic> post<T extends BaseResponse>(
    String path,
    T key, {
    Map? params,
    String? baseUrl,
    bool originalResponse = false,
    int successCode = successCode,
  }) async {
    String uri = '${baseUrl ?? baseUri}$path';
    var token = await LyCache.get<String>(key: LyCacheKey.appToken);

    Map<String, dynamic> paramMap = {...params ?? {}};
    paramMap.removeWhere((key, value) => value == null || value == "");

    try {
      BaseOptions baseOptions = BaseOptions(
        validateStatus: (int? status) => status != null,
      );
      var dio = Dio(baseOptions);

      Response dioResponse = await dio.post(
        uri,
        data: paramMap,
        options: Options(
          sendTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          headers: {
            'Authorization': token,
            "X-App-Version": await LyUtils.getAppVersion(),
            "X-Api-Version": "1.0",
            "Content-Type": "application/json",
          },
        ),
      );

      if (dioResponse.statusCode != 200) {
        key.setCode(-1);
        return key;
      }

      Map<String, dynamic> response = json.decode(dioResponse.toString());
      if (originalResponse) return response;

      key.setCode(response['code'] ?? -1);
      key.setMsg(response['msg'] ?? "");

      // 登录失效处理
      if (response['code'] == 9001) {
        loginTokenValid(response);
        return key;
      }

      return parseResponse(key, response);
    } catch (e) {
      key.setCode(-1);
      return key;
    }
  }

  // GET 请求
  static Future<dynamic> get<T extends BaseResponse>(
    String path,
    T key, {
    Map<String, dynamic>? params,
    String? baseUrl,
    bool originalResponse = false,
  }) async {
    String uri = '${baseUrl ?? baseUri}$path';
    var token = await LyCache.get<String>(key: LyCacheKey.appToken);

    Map<String, dynamic> paramMap = {...params ?? {}};
    paramMap.removeWhere((key, value) => value == null || value == "");

    try {
      var dio = Dio();
      Response dioResponse = await dio.get(
        uri,
        queryParameters: paramMap,
        options: Options(
          headers: {
            'Authorization': token,
            "X-App-Version": await LyUtils.getAppVersion(),
          },
        ),
      );

      Map<String, dynamic> response = json.decode(dioResponse.toString());
      key.setCode(response['code'] ?? -1);
      return parseResponse(key, response);
    } catch (e) {
      key.setCode(-1);
      return key;
    }
  }

  static Future<dynamic> parseResponse<T extends BaseResponse>(
    T key,
    Map<String, dynamic> response,
  ) async {
    if (response['data'] is List) {
      if ((response['data'] as List).isEmpty) return <T>[];
      return List<T>.from(
        response["data"]!.map((x) {
          key.setResponse(x);
          return key.data;
        }),
      );
    } else if (response['data'] is Map) {
      key.setResponse(response['data']);
      return key.data;
    }
    return key;
  }

  static void loginTokenValid(Map<String, dynamic> response) {
    BuildContext? context = appNavigatorKey.currentState?.overlay?.context;
    if (context != null) {
      // 显示登录失效弹窗
    }
  }
}
```

### 3.5 响应基类 (response.dart)

```dart
import 'package:flutter_marvin/http/models/result.dart';

abstract class BaseResponse<T> implements Result<T> {
  Map responseMap = {};
  int code = -1;
  String msg = "";

  void setResponse(Map responseMap) {
    this.responseMap = responseMap;
  }

  void setCode(int code) {
    this.code = code;
  }

  void setMsg(String msg) {
    this.msg = msg;
  }

  bool isSuccess() => code == 0;

  String getDataMsg() => msg;

  @override
  get data {
    BaseResponse response = getData(responseMap);
    response.setCode(code);
    response.setMsg(msg);
    response.setResponse(responseMap);
    return response as T;
  }

  getData(Map responseMap);
}
```

### 3.6 缓存工具 (ly_cache.dart)

```dart
import 'package:flutter_marvin/utils/storage/tc_storage_util.dart';

class LyCache {
  static Future<bool> put({required String? key, required dynamic value}) {
    return TCStorageUtil.instance.save(key: key, value: value);
  }

  static Future<T?> get<T>({required String? key}) async {
    return await TCStorageUtil.instance.get(key: key);
  }

  static Future<bool> remove({required String key}) async {
    return await TCStorageUtil.instance.delete(key: key);
  }

  static Future<void> removeAll() async {
    await TCStorageUtil.instance.clearAll();
  }
}
```

### 3.7 事件总线 (event_bus.dart)

```dart
import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

// 定义事件
class UpdateParserEvent {}

class SeeRecommendEvent {}

class SeeHistoryParseEvent {}

// 触发事件
eventBus.fire(UpdateParserEvent());

// 监听事件
eventBus.on<UpdateParserEvent>().listen((event) {
  // 处理事件
});
```

### 3.8 页面基类 (ly_base_state.dart)

```dart
import 'package:flutter/cupertino.dart';
import 'package:flutter_tc_router/tc_flutter_router.dart';

class LyBaseState<T extends StatefulWidget> extends State<T>
    with WidgetsBindingObserver {
  late _RouteAwareObserver _awareObserver;

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }

  @override
  void initState() {
    _awareObserver = _RouteAwareObserver(this);
    Future(() => routeObserver.subscribe(
        _awareObserver, ModalRoute.of(context) as PageRoute));
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    routeObserver.unsubscribe(_awareObserver);
    WidgetsBinding.instance?.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) onBackground();
    if (state == AppLifecycleState.resumed) onForeground();
  }

  void onPageShow() {}
  void onPageHide() {}
  void onPageDestroy() {}
  void onForeground() {}
  void onBackground() {}
}

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class _RouteAwareObserver implements RouteAware {
  final LyBaseState state;
  _RouteAwareObserver(this.state);

  @override
  void didPop() => state.onPageDestroy();
  @override
  void didPopNext() => state.onPageShow();
  @override
  void didPush() => state.onPageShow();
  @override
  void didPushNext() => state.onPageHide();
}
```

### 3.9 常量定义 (constants.dart)

```dart
class LyCacheKey {
  static String appToken = "app_token";
  static String useInfo = "user_info";
  static String versionInfo = "version_info";
}

class LyConfig {
  static String? reportId = "";
  static String? recordId = "";
  static bool isLogin = false;
}

class FileTypeSuffix {
  static List<String> docSuffix = ["pdf", "doc", "docx", "txt", "ppt", "pptx"];
  static List<String> imgSuffix = ["jpg", "png", "jpeg", "gif", "bmp", "webp"];
  static List<String> videoSuffix = ["mp4", "avi", "mov", "wmv", "mkv"];
}
```

### 3.10 颜色常量 (colors.dart)

```dart
import 'package:flutter/material.dart';

class LyColors {
  static void setAppmain(Color main) => appMain = main;

  static Color appMain = const Color(0xFF004BFA);
  static const Color text = Color(0xFF222222);
  static const Color text_w5 = Color(0xFF555555);
  static const Color text_w6 = Color(0xFF666666);
  static const Color text_w8 = Color(0xFF888888);
  static const Color text_wb = Color(0xFFBBBBBB);
  static const Color background = Color(0xFFF2F2F2);
  static const Color background2 = Color(0xFFF7F9FA);
  static const Color inputBg = Color(0xFFF0F1F2);
  static const Color line = Color(0xFFE3E3E3);
  static const Color border = Color(0xFFDCDEE0);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Color(0x00FFFFFF);
}
```

### 3.11 GetX Controller 模板

```dart
import 'package:get/get.dart';

class PageController extends GetxController {
  // 响应式状态
  var dataList = <dynamic>[].obs;
  var isLoading = false.obs;
  var isEmpty = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    isLoading.value = true;
    try {
      // 请求数据
      // final result = await LyHttp.post('/api/path', Model());
      // dataList.value = result;
      isEmpty.value = dataList.isEmpty;
    } finally {
      isLoading.value = false;
    }
  }
}
```

### 3.12 API 模型定义模板

```dart
import 'package:flutter_marvin/http/models/response.dart';

class UserInfo extends BaseResponse<UserInfo> {
  String? userId;
  String? userName;
  String? avatar;

  @override
  getData(Map responseMap) {
    return UserInfo()
      ..userId = responseMap['userId']
      ..userName = responseMap['userName']
      ..avatar = responseMap['avatar'];
  }
}
```

## 四、flutter_tc_router 使用说明

### 路由格式
- URI格式: `focus://page/flutter/{routePath}?pageParam={json}`

### 初始化
```dart
// main.dart
TcFlutterRouter.instance.addPages(LyRouters.routes);
TcFlutterRouter.instance.addRouterIntercept(LyInterceptor());
```

### 路由注册
```dart
static Map<String, TcFlutterPageBuilder> routes = {
  'app/home': (params) => const RootPage(),
  'app/detail': (params) => DetailPage(
    id: params['id'],
    name: params['name'],
  ),
};
```

### 路由跳转
```dart
// 普通跳转
LyRouters.push(context, 'app/detail', params: {'id': '123'});

// 返回
LyRouters.pop(context);

// 返回到指定页
LyRouters.popTo(context, 'app/home');

// 跳转并清除栈
LyRouters.pushAndRemoveUntil(context, 'app/login');
```

## 五、本地模块依赖

需要同步的本地模块 (path dependencies):
- `flutter_tc_router` - 路由框架
- `flutter_tc_base_ui` - 基础UI组件
- `flutter_tc_ui` - 业务UI组件
- `flutter_tc_dialog` - 弹窗组件
- `flutter_download_manager` - 下载管理
- `dokit` - 调试工具

修改本地模块后无需额外 `flutter pub get`，Flutter 会自动识别变更。

## 六、DoKit 调试工具集成

### 初始化 main.dart

```dart
import 'package:dokit/dokit.dart';
import 'PACKAGE_NAME/dokits/doraemon_manager.dart';

void initApp() {
  // Dokit初始化
  DoKit.runApp(
    useInRelease: false,  // 仅在debug模式启用
    app: DoKitApp(const MyApp()),
    exceptionCallback: (exception, stack) {
      loggerError(exception.toString());
    },
  );
  DoKitManager.initDoKits();
  // ...
}
```

### DoKitManager 自定义工具

```dart
import 'package:dokit/kit/biz/biz.dart';

// 自定义工具类
class LyKit extends BizKit {
  LyKit(String name, String group, {String? icon, String? desc,
      KitPageBuilder? kitBuilder, String? key, Function? action})
      : super(icon, name, group, desc, kitBuilder, key, action);
}

class DoKitManager {
  static const MOUDLE_NAME = "业务开发";

  static initDoKits() {
    // 环境切换
    BizKitManager.instance.addBizKit(
      "环境切换",
      LyKit("环境切换", MOUDLE_NAME,
        icon: "assets/images/ic_dokit_http.png",
        action: () => changeNetWork()),
    );
  }

  static changeNetWork() async {
    BuildContext context = appNavigatorKey.currentState!.overlay!.context;
    DoKitBtn.doKitBtnKey.currentState?.closeDebugPage();
    LyBasePopup.showBottomPopup(
      context: context,
      child: NetWorkSettingPop(),
    );
  }
}
```

### 网络环境设置弹窗

```dart
class NetWorkSettingPop extends StatefulWidget {
  final String? netWorkUri;
  NetWorkSettingPop({Key? key, this.netWorkUri}) : super(key: key);
  // ...
}
```

### 代理设置弹窗

```dart
class ProxyPop extends StatefulWidget {
  final String? ip;
  final String? port;
  ProxyPop({Key? key, this.ip, this.port}) : super(key: key);
  // ...
}
```

### 目录结构

```
lib/
└── dokits/                      # DoKit调试工具
    ├── doraemon_manager.dart    # DoKit管理器
    ├── ly_kit.dart            # 自定义工具类
    ├── network_setting_pop.dart # 网络环境设置
    ├── proxy_pop.dart         # 代理设置
    └── web_test_pop.dart      # 网页测试
```

### pubspec.yaml 依赖

```yaml
# 调试工具 (仅 debug)
dokit:
  path: ./dokit
```

## 七、Build Commands

```bash
# 获取依赖
flutter pub get

# 运行应用
flutter run

# 构建 Release APK
flutter build apk --release

# iOS Release
cd ios && fastlane buildRelease

# 静态分析
flutter analyze

# 运行测试
flutter test
```
