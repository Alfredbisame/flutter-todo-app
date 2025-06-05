import 'package:bloc_todo/utils/dimensions.dart';
import 'package:flutter/material.dart';

import '../theme/app.colors.dart';

class CustomInput extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? minLines;
  final int? maxLines;
  final Widget? prefix;
  final Widget? suffix;
  final String? Function(String?)? validator; 
  const CustomInput({
    super.key,
    this.controller,
    this.label,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.minLines,
    this.maxLines,
    this.prefix,
    this.suffix,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null)
            Text(
              label!,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
          if (label != null) SizedBox(height: 8),
          TextField(
            controller: controller,
            minLines: minLines,
            maxLines: maxLines,
            style: TextStyle(fontSize: 18),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: Colors.grey.shade800,
                  width: 0.35,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: Dimensions.getWidth(0.35),
                  color: Colors.grey.shade800,
                ),
                borderRadius: BorderRadius.circular(Dimensions.getWidth(10)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: Dimensions.getWidth(0.85),
                  color: AppColors.primaryColor,
                ),
                borderRadius: BorderRadius.circular(Dimensions.getWidth(10)),
              ),
              hintText: hintText,
            ),
          ),
        ],
      ),
    );
  }
}
