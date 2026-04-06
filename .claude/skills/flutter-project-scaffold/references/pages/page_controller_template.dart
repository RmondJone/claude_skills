import 'package:get/get.dart';
import 'PACKAGE_NAME/http/ly_http.dart';
import 'PACKAGE_NAME/pages/MODULE_NAME/models/MODEL_NAME.dart';

/// 注释：XXX页面控制器
/// 时间：2024/1/5 0005 16:42
/// 作者：作者名
class PageController extends GetxController {
  // 数据列表
  var dataList = <dynamic>[].obs;

  // 加载状态
  var isLoading = false.obs;

  // 是否为空
  var isEmpty = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  /// 注释：加载数据
  /// 时间：2024/1/5 0005 16:42
  /// 作者：作者名
  Future<void> loadData() async {
    isLoading.value = true;
    try {
      var result = await LyHttp.post(
        '/api/path',
        Model(),
        params: {},
      );
      if (result.isSuccess()) {
        dataList.value = result;
        isEmpty.value = dataList.isEmpty;
      }
    } finally {
      isLoading.value = false;
    }
  }

  /// 注释：刷新数据
  /// 时间：2024/1/5 0005 16:42
  /// 作者：作者名
  Future<void> refreshData() async {
    await loadData();
  }
}
