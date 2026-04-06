/// 注释：缓存Key
/// 时间：2024/1/11 10:54
/// 作者：作者名
class LyCacheKey {
  //Token
  static String appToken = "app_token";

  //用户信息
  static String useInfo = "user_info";

  //版本信息
  static String versionInfo = "version_info";

  //更新版本
  static String updateVersion = "update_version";
}

/// 注释：配置
/// 时间：2024/1/11 10:54
/// 作者：作者名
class LyConfig {
  //当前客户详情报告Id
  static String? reportId = "";

  //当前客户详情跟进记录 Id
  static String? recordId = "";

  //设备 Id
  static String? deviceId = "";

  //设备类型
  static String? deviceType = "";

  //推送Token
  static String? pushToken = "";

  //是否登录
  static bool isLogin = false;

  //是否是对接用户
  static bool isPilotUser = false;
}

/// 注释：文件类型
/// 时间：2024/1/11 10:54
/// 作者：作者名
class FileTypeSuffix {
  static String png = "png";
  static String jpeg = "jpeg";
  static String mp3 = "mp3";
  static String mp4 = "mp4";
  static String wav = "wav";

  // 常见文档
  static List<String> docSuffix = [
    "pdf", "doc", "docx", "txt", "ppt", "pptx", "xsl", "xsls", "apk", "zip", "rar",
  ];

  // 图片后缀
  static List<String> imgSuffix = [
    "jpg", "png", "jpeg", "gif", "bmp", "tiff", "webp", "svg", "ico",
  ];

  // 视频后缀
  static List<String> videoSuffix = [
    "mp4", "avi", "mov", "wmv", "flv", "mkv", "3gp", "webm",
  ];
}
