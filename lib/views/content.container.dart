import 'package:bloc_todo/utils/dimensions.dart';
import 'package:flutter/material.dart';

class ContentContainer extends StatelessWidget {
  final Widget? child;
  final EdgeInsetsGeometry? padding;

  const ContentContainer({super.key, this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.all(20.width),
      child: child,
    );
  }
}
