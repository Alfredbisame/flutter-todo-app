import 'package:bloc_todo/utils/dimensions.dart';
import 'package:flutter/material.dart';

import '../enums/dialog.variants.dart';
import '../theme/app.font.size.dart';
import '../views/content.container.dart';
import 'custom.dialog.icon.dart';

class ResponseModal extends StatelessWidget {
  final DialogVariant? variant;
  final String? message;

  const ResponseModal({
    super.key,
    this.variant = DialogVariant.Error,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: Colors.white,
      children: [
        ContentContainer(
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomDialogIcon(isError: variant != DialogVariant.Success),
                ],
              ),
              SizedBox(height: 15.height),
              Text(
                message ?? "",
                textAlign: TextAlign.center,
                style: AppFontSize.fontSizeMedium(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.fontSize,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
