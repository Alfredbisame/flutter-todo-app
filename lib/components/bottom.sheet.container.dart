import 'package:flutter/material.dart';

import '../utils/dimensions.dart';

class BottomSheetContainer extends StatelessWidget {
  final List<Widget> children;
  final Color? backgroundColor;
  final double? height;
  final EdgeInsets? padding;
  const BottomSheetContainer({
    super.key,
    required this.children,
    this.backgroundColor,
    this.height,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: padding ?? EdgeInsets.all(20.width),
      width: const BoxConstraints.expand().maxWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.width),
        color: backgroundColor ?? Colors.white,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }
}
