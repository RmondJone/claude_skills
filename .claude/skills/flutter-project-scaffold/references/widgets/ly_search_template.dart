import 'package:flutter/material.dart';
import 'DEFINES_PATH/colors.dart';
import 'DEFINES_PATH/fonts.dart';

/// 注释：通用搜索框
/// 时间：2022/11/24 14:30
/// 作者：作者名
class LySearchBar extends StatefulWidget {
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final bool readOnly;
  final TextEditingController? controller;

  const LySearchBar({
    Key? key,
    this.hintText = '请输入搜索内容',
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.readOnly = false,
    this.controller,
  }) : super(key: key);

  @override
  State<LySearchBar> createState() => _LySearchBarState();
}

class _LySearchBarState extends State<LySearchBar> {
  late TextEditingController _controller;
  bool _showClear = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _showClear = _controller.text.isNotEmpty;
    });
    widget.onChanged?.call(_controller.text);
  }

  void _clear() {
    _controller.clear();
    widget.onChanged?.call('');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: LyColors.inputBg,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          const SizedBox(width: 12),
          const Icon(Icons.search, color: LyColors.text_w8, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _controller,
              readOnly: widget.readOnly,
              onTap: widget.onTap,
              onSubmitted: widget.onSubmitted,
              style: const TextStyle(
                fontSize: LyFonts.font_15,
                color: LyColors.text,
              ),
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: const TextStyle(
                  fontSize: LyFonts.font_15,
                  color: LyColors.text_w8,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          if (_showClear)
            GestureDetector(
              onTap: _clear,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.clear, color: LyColors.text_w8, size: 18),
              ),
            ),
          const SizedBox(width: 12),
        ],
      ),
    );
  }
}
