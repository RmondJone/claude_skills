import 'package:flutter/material.dart';
import 'DEFINES_PATH/colors.dart';
import 'DEFINES_PATH/fonts.dart';

/// 注释：空数据组件
/// 时间：2022/11/24 14:30
/// 作者：作者名
class EmptyDataWidget extends StatelessWidget {
  final String? message;
  final String? imagePath;
  final VoidCallback? onTap;

  const EmptyDataWidget({
    Key? key,
    this.message = '暂无数据',
    this.imagePath,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (imagePath != null) ...[
              Image.asset(
                imagePath!,
                width: 120,
                height: 120,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 16),
            ] else ...[
              const Icon(
                Icons.inbox_outlined,
                size: 60,
                color: LyColors.text_w8,
              ),
              const SizedBox(height: 16),
            ],
            Text(
              message ?? '暂无数据',
              style: const TextStyle(
                fontSize: LyFonts.font_15,
                color: LyColors.text_w8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
