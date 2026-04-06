import 'dart:io';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'LY_CACHE_PATH' as app;

/// 注释：通用工具类
/// 时间：2022/11/24 14:30
/// 作者：作者名
class LyUtils {
  /// 注释：获取App版本
  /// 时间：2022/11/24 14:30
  /// 作者：作者名
  static Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  /// 注释：获取App构建号
  /// 时间：2022/11/24 14:31
  /// 作者：作者名
  static Future<String> getBuildNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.buildNumber;
  }

  /// 注释：获取文件类型
  /// 时间：2024/1/11 10:00
  /// 作者：作者名
  static String getFileType(String path) {
    String extension = path.split('.').last.toLowerCase();
    return extension;
  }

  /// 注释：创建临时文件
  /// 时间：2024/1/11 10:00
  /// 作者：作者名
  static Future<String> createTempFile({
    required String dir,
    required String name,
  }) async {
    final directory = await getTemporaryDirectory();
    final dirPath = '${directory.path}/$dir';
    final fileDir = Directory(dirPath);
    if (!await fileDir.exists()) {
      await fileDir.create(recursive: true);
    }
    return '$dirPath/$name';
  }

  /// 注释：判断是否为iOS
  /// 时间：2023/8/15 10:00
  /// 作者：作者名
  static bool isIOS() {
    return Platform.isIOS;
  }

  /// 注释：判断是否为Android
  /// 时间：2023/8/15 10:00
  /// 作者：作者名
  static bool isAndroid() {
    return Platform.isAndroid;
  }
}
