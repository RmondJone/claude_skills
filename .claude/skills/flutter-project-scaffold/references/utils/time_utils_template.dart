import 'package:intl/intl.dart';

/// 注释：时间工具类
/// 时间：2022/11/24 14:30
/// 作者：作者名
class TimeUtils {
  /// 注释：格式化时间戳为日期字符串
  /// 时间：2022/11/24 14:30
  /// 作者：作者名
  static String getFormatDateByTimeStamp(int timestamp) {
    if (timestamp == 0) return '';
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
  }

  /// 注释：格式化时间戳为日期
  /// 时间：2022/11/24 14:31
  /// 作者：作者名
  static String getFormatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
  }

  /// 注释：获取当前时间戳
  /// 时间：2022/11/24 14:32
  /// 作者：作者名
  static int getCurrentTimeStamp() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  /// 注释：日期字符串转时间戳
  /// 时间：2023/8/15 10:00
  /// 作者：作者名
  static int dateStrToTimestamp(String dateStr) {
    try {
      var date = DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateStr);
      return date.millisecondsSinceEpoch;
    } catch (e) {
      return 0;
    }
  }

  /// 注释：获取友好时间显示
  /// 时间：2023/8/15 10:00
  /// 作者：作者名
  static String getFriendlyTime(int timestamp) {
    var now = DateTime.now().millisecondsSinceEpoch;
    var diff = now - timestamp;
    if (diff < 60000) {
      return '刚刚';
    } else if (diff < 3600000) {
      return '${diff ~/ 60000}分钟前';
    } else if (diff < 86400000) {
      return '${diff ~/ 3600000}小时前';
    } else if (diff < 604800000) {
      return '${diff ~/ 86400000}天前';
    } else {
      return getFormatDateByTimeStamp(timestamp);
    }
  }
}
