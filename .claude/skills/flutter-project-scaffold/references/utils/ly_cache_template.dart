import 'package:PROJECT_NAME/utils/storage/tc_storage_util.dart';

/// 注释：TCStorageUtil 封装
/// 时间：2022/12/6 14:48
/// 作者：作者名
class LyCache {
  /// 注释：存值
  /// 时间：2022/12/6 14:50
  /// 作者：作者名
  static Future<bool> put({required String? key, required dynamic value}) {
    return TCStorageUtil.instance.save(key: key, value: value);
  }

  /// 注释：取值
  /// 时间：2022/12/6 14:51
  /// 作者：作者名
  static Future<T?> get<T>({required String? key}) async {
    return await TCStorageUtil.instance.get(key: key);
  }

  /// 注释：移除
  /// 时间：2023/1/10 16:54
  /// 作者：作者名
  static Future<bool> remove({required String key}) async {
    return await TCStorageUtil.instance.delete(key: key);
  }

  /// 注释：移除所有
  /// 时间：2023/1/10 16:55
  /// 作者：作者名
  static Future<void> removeAll() async {
    String? appHost = await LyCache.get<String>(key: 'app_host');
    String? ip = await LyCache.get(key: 'proxy_ip');
    String? port = await LyCache.get(key: 'proxy_port');
    await TCStorageUtil.instance.clearAll();
    await LyCache.put(key: 'app_host', value: appHost);
    await LyCache.put(key: 'proxy_ip', value: ip);
    await LyCache.put(key: 'proxy_port', value: port);
  }
}
