# Flutter 网络请求规范

> 本文件描述 Flutter + Dio 网络请求框架规范。类比 iOS：相当于对 Alamofire 的封装。

## 目录结构

### HTTP 框架层

```
lib/http/
├── ly_http.dart           # HTTP 封装（LyHttp）
├── models/
│   ├── result.dart        # 结果接口抽象
│   ├── response.dart      # 响应基类（BaseResponse）
│   └── ly_base_bean.dart  # 基础实体（LyBaseBean）
└── controller/
    └── net_work_contorller.dart  # 网络状态控制器
```

### 业务模块层（实体放这里）

```
lib/pages/{module}/
├── {module}_page.dart      # 页面 Widget
├── controllers/            # GetX Controller
├── models/                 # 【出参解析实体放这里】
│   └── {api_name}_response.dart
└── views/                  # 子视图组件
```

## 实体放置规范

**出参解析实体必须放到各功能模块的 `models/` 目录下**，不能放在 `lib/http/models/` 中。

```dart
/// 注释：用户信息响应实体
/// 时间：2023/12/25 0025 9:24
/// 作者：郭翰林
class UserInfoResponse extends BaseResponse {
  UserInfoResponse({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  factory UserInfoResponse.fromJson(Map json) => UserInfoResponse(
        id: json["id"],
        name: json["name"],
      );

  @override
  getData(Map responseMap) => UserInfoResponse.fromJson(responseMap);
}
```

**错误示例** ❌
```dart
// 不要放在 lib/http/models/ 下
lib/http/models/user_info.dart  // 错误
```

**正确示例** ✅
```dart
// 应该放在功能模块的 models/ 下
lib/pages/user/models/user_info_response.dart  // 正确
```

## API 返回格式规范

项目统一 API 返回格式：`{ code: 0, msg: "", data: {} | [] }`

| code | 含义 | 处理方式 |
|------|------|----------|
| 0 | 成功 | 正常解析 data |
| 9001 | 登录失效 | 清除 token 并跳转登录页 |
| 其他 | 业务错误 | 解析 data，返回错误信息 |

## 响应模型规范

### 1. Result 接口

```dart
/// 注释：结果接口抽象类
/// 时间：2022/11/5 0005 20:17
/// 作者：郭翰林
abstract class Result<T> {
  T get data;
}
```

### 2. BaseResponse 抽象类

```dart
/// 注释：返回实体抽象类
/// 时间：2022/11/5 0005 20:17
/// 作者：郭翰林
abstract class BaseResponse<T> implements Result<T> {
  Map responseMap = {};
  int code = -1;
  String msg = "";

  void setResponse(Map responseMap);
  void setCode(int code);
  void setMsg(String msg);
  bool isSuccess() => code == 0;
  String getDataMsg() => msg;

  /// 注释：获取数据 - 子类实现
  /// 时间：2022/11/5 0005 20:14
  /// 作者：郭翰林
  getData(Map responseMap);
}
```

### 3. 具体实体类

```dart
/// 注释：用户信息实体
/// 时间：2023/12/25 0025 9:24
/// 作者：郭翰林
class UserInfo extends BaseResponse {
  UserInfo({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  factory UserInfo.fromJson(Map<dynamic, dynamic> json) => UserInfo(
        id: json["id"],
        name: json["name"],
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  @override
  getData(Map<dynamic, dynamic> responseMap) {
    return UserInfo.fromJson(responseMap);
  }
}
```

## HTTP 请求封装规范

### LyHttp 静态类方法

```dart
class LyHttp {
  // 环境配置
  static String baseUri = baseApiTest2;

  // 成功 code
  static const int successCode = 0;

  /// 注释：post通用方法
  /// 时间：2022/11/5 0005 16:53
  /// 作者：郭翰林
  static Future<dynamic> post<T extends BaseResponse>(
    String path,
    T key, {
    Map? params,
    String? baseUrl,
    String? body,
    String? contentType,
    bool originalResponse = false,
    int successCode = successCode,
    File? file,
  }) async { ... }

  /// 注释：get通用方法
  /// 时间：2022/11/5 0005 16:53
  /// 作者：郭翰林
  static Future<dynamic> get<T extends BaseResponse>(
    String path,
    T key, {
    Map<String, dynamic>? params,
    String? baseUrl,
    bool originalResponse = false,
    int successCode = successCode,
  }) async { ... }

  /// 注释：下载文件
  /// 时间：2024/1/11 0011 10:00
  /// 作者：郭翰林
  static void downLoadFile(...) async { ... }
}
```

### 请求头规范

自动添加以下 header：

```dart
Map<String, dynamic> headerMap = {
  'Authorization': token,           // 用户 Token
  "Content-Type": "application/json", // 默认 JSON
};
```

## 接口调用示例

### POST 请求

```dart
// 1. 定义请求参数
class LoginParams {
  final String account;
  final String password;

  LoginParams({required this.account, required this.password});

  Map<String, dynamic> toJson() => {
        "account": account,
        "password": password,
      };
}

// 2. 定义响应实体
class LoginResponse extends BaseResponse {
  LoginResponse({this.token, this.userId});

  String? token;
  String? userId;

  factory LoginResponse.fromJson(Map json) => LoginResponse(
        token: json["token"],
        userId: json["userId"],
      );

  @override
  getData(Map responseMap) => LoginResponse.fromJson(responseMap);
}

// 3. 发起请求
Future<LoginResponse> login(LoginParams params) async {
  final result = await LyHttp.post(
    '/api/login',
    LoginResponse(),
    params: params.toJson(),
  );
  return result as LoginResponse;
}
```

### GET 请求

```dart
// 1. 定义响应实体
class UserListResponse extends BaseResponse {
  UserListResponse({this.users});

  List<UserInfo>? users;

  factory UserListResponse.fromJson(Map json) => UserListResponse(
        users: (json["users"] as List?)
            ?.map((e) => UserInfo.fromJson(e))
            .toList(),
      );

  @override
  getData(Map responseMap) => UserListResponse.fromJson(responseMap);
}

// 2. 发起请求
Future<List<UserInfo>> getUserList({int page = 1}) async {
  final result = await LyHttp.get(
    '/api/users',
    UserListResponse(),
    params: {"page": page},
  );
  return result as List<UserInfo>;
}
```

### 文件上传

```dart
Future<String> uploadFile(File file) async {
  final result = await LyHttp.post(
    '/api/upload',
    LyBaseBean(),
    file: file,
    params: {"type": "image"},
    contentType: "multipart/form-data",
  );
  return result;
}
```

## 错误处理规范

### HTTP 层错误处理

登录失效（code=9001）由 HTTP 封装层统一拦截：

```dart
// 登录失效逻辑
if (response['code'] == 9001) {
  loginTokenValid(response);
}
```

登录失效时自动：
1. 弹窗提示用户
2. 清除本地 token（`LyCache.removeAll()`）
3. 跳转登录页

### 业务层错误处理

```dart
void fetchData() async {
  try {
    final response = await LyHttp.post('/api/data', DataResponse());
    if (response is BaseResponse) {
      if (response.isSuccess()) {
        // 成功处理
        final data = response.data;
      } else {
        // 业务错误提示
        showToast(response.msg);
      }
    } else {
      // 列表数据
      final list = response as List<DataResponse>;
    }
  } catch (e) {
    // 网络异常处理
    showToast('网络请求失败');
  }
}
```

## 日志规范

| 级别 | 方法 | 用途 |
|------|------|------|
| Debug | `loggerDebug()` | 请求 URL、Token、入参 |
| Info | `loggerInfo()` | 文件下载进度 |
| Error | `loggerError()` | 请求失败、异常 |
| Long | `loggerLong()` | 请求返回（长文本） |

## 环境切换

通过 `LyHttp.baseUri` 静态变量控制：

```dart
// 测试环境
static const String baseApiTest = "https://saleapp-p.focusaim.com";
static const String baseApiTest2 = "https://saleapp-p2.focusaim.com";

// 正式环境
static const String baseApiRelease = "https://saleapp.focusaim.com";

// 运行时切换
static String baseUri = baseApiTest2;
```

## 规范速查表

| 场景 | 规范 |
|------|------|
| 返回格式 | `{ code: 0, msg: "", data: {} \| [] }` |
| 响应模型 | 继承 `BaseResponse<T>`，实现 `getData(Map)` |
| 成功判断 | `code == 0` 或 `response.isSuccess()` |
| 登录失效 | code=9001，HTTP 层统一处理 |
| 请求头 | 自动添加 Authorization、X-App-Version、X-Api-Version |
| 空值过滤 | 自动过滤 `null` 和空字符串入参 |
| 超时时间 | 30 秒 |
