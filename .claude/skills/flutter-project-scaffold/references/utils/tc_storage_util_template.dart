import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

/// 注释：Hive存储工具类
/// 时间：2022/12/5 0005 16:00
/// 作者：作者名
class TCStorageUtil {
  static TCStorageUtil? _instance;
  static TCStorageUtil get instance => _instance ??= TCStorageUtil._();

  TCStorageUtil._();

  Box? _box;

  Future<void> init() async {
    if (_box == null || !_box!.isOpen) {
      final appDocDir = await getApplicationDocumentsDirectory();
      _box = await Hive.openBox('app_storage', path: appDocDir.path);
    }
  }

  Future<bool> save({required String? key, required dynamic value}) async {
    try {
      await init();
      await _box?.put(key, value);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<T?> get<T>({required String? key}) async {
    try {
      await init();
      return _box?.get(key) as T?;
    } catch (e) {
      return null;
    }
  }

  Future<bool> delete({required String key}) async {
    try {
      await init();
      await _box?.delete(key);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> clearAll() async {
    try {
      await init();
      await _box?.clear();
    } catch (e) {
      // ignore
    }
  }
}
