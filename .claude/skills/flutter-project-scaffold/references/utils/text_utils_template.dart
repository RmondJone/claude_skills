/// 注释：文本工具类
/// 时间：2022/11/24 0024 14:30
/// 作者：作者名
class TextUtils {
  /// 注释：判断字符串是否为空
  /// 时间：2022/11/24 14:30
  /// 作者：作者名
  static bool isEmpty(String? str) {
    return str == null || str.isEmpty;
  }

  /// 注释：判断字符串是否不为空
  /// 时间：2022/11/24 14:31
  /// 作者：作者名
  static bool isNoEmpty(String? str) {
    return str != null && str.isNotEmpty;
  }

  /// 注释：字符串相等比较
  /// 时间：2023/8/15 10:00
  /// 作者：作者名
  static bool equals(String? a, String? b) {
    if (a == null && b == null) return true;
    if (a == null || b == null) return false;
    return a == b;
  }

  /// 注释：手机号脱敏
  /// 时间：2023/8/15 10:00
  /// 作者：作者名
  static String phoneDesensitize(String? phone) {
    if (isEmpty(phone) || phone!.length < 7) return phone ?? '';
    return '${phone.substring(0, 3)}****${phone.substring(phone.length - 4)}';
  }
}
