import 'package:flutter/material.dart';

import '../theme/app.colors.dart';
import '../utils/dimensions.dart';

class CustomDialogIcon extends StatelessWidget {
  final bool isError;

  const CustomDialogIcon({super.key, this.isError = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45.width,
      height: 45.width,
      decoration: BoxDecoration(
        color: isError ? AppColors.redColor : AppColors.primaryColor,
        borderRadius: BorderRadius.circular(100.width),
      ),
      child: Center(
        child: Icon(
          isError ? Icons.close : Icons.check,
          color: Colors.white,
          size: 28.iconSize,
        ),
      ),
    );
  }
}
