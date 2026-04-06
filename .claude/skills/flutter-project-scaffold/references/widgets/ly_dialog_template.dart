import 'package:flutter/material.dart';
import 'package:flutter_tc_dialog/flutter_tc_dialog.dart';

/// 注释：通用弹窗封装
/// 时间：2022/11/24 14:30
/// 作者：作者名

/// 普通确认弹窗
void showLyNormalDialog({
  required BuildContext context,
  required String title,
  required String content,
  String cancelText = '取消',
  String doneText = '确定',
  bool showCancelButton = true,
  bool barrierDismissible = true,
  VoidCallback? onCancel,
  VoidCallback? onDone,
}) {
  showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (context) => LyConfirmDialog(
      title: title,
      content: content,
      cancelText: cancelText,
      doneText: doneText,
      showCancelButton: showCancelButton,
      onCancel: onCancel,
      onDone: onDone,
    ),
  );
}

/// 成功提示弹窗
void showLySuccessDialog({
  required BuildContext context,
  required String content,
  String doneText = '知道了',
  VoidCallback? onDone,
}) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => LySuccessDialog(
      content: content,
      doneText: doneText,
      onDone: onDone,
    ),
  );
}

/// 带输入框的弹窗
void showLyInputDialog({
  required BuildContext context,
  required String title,
  String? hintText,
  String cancelText = '取消',
  String doneText = '确定',
  ValueChanged<String>? onConfirm,
}) {
  showDialog(
    context: context,
    builder: (context) => LyInputDialog(
      title: title,
      hintText: hintText,
      cancelText: cancelText,
      doneText: doneText,
      onConfirm: onConfirm,
    ),
  );
}
