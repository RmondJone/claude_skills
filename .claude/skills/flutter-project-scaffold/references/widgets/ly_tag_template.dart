import 'package:flutter/material.dart';
import 'DEFINES_PATH/colors.dart';
import 'DEFINES_PATH/fonts.dart';

/// 注释：通用标签组件
/// 时间：2022/11/24 14:30
/// 作者：作者名
class LyTag extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;

  const LyTag({
    Key? key,
    required this.text,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
    this.padding,
    this.borderRadius = 4,
  }) : super(key: key);

  /// 蓝色标签
  const LyTag.blue({
    Key? key,
    required this.text,
    this.borderRadius = 4,
    this.fontSize,
    this.padding,
  })  : backgroundColor = const Color(0xFFE2EBFF),
        textColor = const Color(0xFF004BFA),
        super(key: key);

  /// 灰色标签
  const LyTag.gray({
    Key? key,
    required this.text,
    this.borderRadius = 4,
    this.fontSize,
    this.padding,
  })  : backgroundColor = const Color(0xFFF2F2F2),
        textColor = const Color(0xFF888888),
        super(key: key);

  /// 绿色标签
  const LyTag.green({
    Key? key,
    required this.text,
    this.borderRadius = 4,
    this.fontSize,
    this.padding,
  })  : backgroundColor = const Color(0xFFE8F8EA),
        textColor = const Color(0xFF69D157),
        super(key: key);

  /// 红色标签
  const LyTag.red({
    Key? key,
    required this.text,
    this.borderRadius = 4,
    this.fontSize,
    this.padding,
  })  : backgroundColor = const Color(0xFFFFEAEA),
        textColor = const Color(0xFFF27C94),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize ?? LyFonts.font_13,
          color: textColor ?? LyColors.text,
        ),
      ),
    );
  }
}
