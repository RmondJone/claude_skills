import 'package:flutter/material.dart';
import 'PACKAGE_NAME/defines/colors.dart';
import 'PACKAGE_NAME/defines/fonts.dart';
import 'PACKAGE_NAME/ly_base_state.dart';
import 'PACKAGE_NAME/pages/MODULE_NAME/controller/page_controller.dart';
import 'PACKAGE_NAME/widgets/empty_data_widget.dart';
import 'package:get/get.dart';

/// 注释：XXX页面
/// 时间：2024/1/5 0005 16:42
/// 作者：作者名
class PageNamePage extends StatefulWidget {
  const PageNamePage({Key? key}) : super(key: key);

  @override
  State<PageNamePage> createState() => _PageNamePageState();
}

class _PageNamePageState extends LyBaseState<PageNamePage> {
  final controller = Get.put(PageController());

  @override
  void onPageShow() {
    super.onPageShow();
    controller.refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LyColors.background,
      appBar: AppBar(
        title: const Text('页面标题'),
        backgroundColor: LyColors.white,
        foregroundColor: LyColors.text,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.isEmpty.value) {
          return const EmptyDataWidget(message: '暂无数据');
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.dataList.length,
          itemBuilder: (context, index) {
            return _buildItem(index);
          },
        );
      }),
    );
  }

  Widget _buildItem(int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: LyColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        'Item $index',
        style: const TextStyle(
          fontSize: LyFonts.font_15,
          color: LyColors.text,
        ),
      ),
    );
  }
}
