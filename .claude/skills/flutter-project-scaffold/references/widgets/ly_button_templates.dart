import 'package:flutter/material.dart';
import 'DEFINES_PATH/colors.dart';
import 'DEFINES_PATH/fonts.dart';

/// 注释：通用按钮
/// 时间：2022/11/24 14:30
/// 作者：作者名
class LyCommonButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isEnabled;
  final bool isLoading;
  final double? width;
  final double height;
  final Color? backgroundColor;
  final Color? textColor;

  const LyCommonButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.isEnabled = true,
    this.isLoading = false,
    this.width,
    this.height = 48,
    this.backgroundColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isEnabled && !isLoading ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? LyColors.appMain,
          disabledBackgroundColor: LyColors.disable,
          foregroundColor: textColor ?? LyColors.white,
          disabledForegroundColor: LyColors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(height / 2),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(LyColors.white),
                ),
              )
            : Text(
                text,
                style: TextStyle(
                  fontSize: LyFonts.font_16,
                  fontWeight: FontWeight.w600,
                  color: textColor ?? LyColors.white,
                ),
              ),
      ),
    );
  }
}

/// 注释：底部固定按钮
/// 时间：2022/11/24 14:30
/// 作者：作者名
class LyBottomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isEnabled;
  final double height;

  const LyBottomButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.isEnabled = true,
    this.height = 80,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).padding.bottom > 0
            ? MediaQuery.of(context).padding.bottom
            : 20,
        top: 12,
      ),
      decoration: const BoxDecoration(
        color: LyColors.white,
        border: Border(
          top: BorderSide(color: LyColors.line, width: 0.5),
        ),
      ),
      child: LyCommonButton(
        text: text,
        onPressed: onPressed,
        isEnabled: isEnabled,
      ),
    );
  }
}
