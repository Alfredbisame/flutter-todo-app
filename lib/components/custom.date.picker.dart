import 'package:bloc_todo/theme/app.colors.dart';
import 'package:bloc_todo/utils/dimensions.dart';
import 'package:flutter/material.dart';

class CustomDatePicker extends StatelessWidget {
  final String? label;
  final String? hintText;
  final Function(DateTime? dt)? handleChange;
  final String? value;

  const CustomDatePicker({
    super.key,
    this.label,
    this.hintText,
    this.handleChange,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
          ),
        if (label != null) SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              builder: (context, child) {
                return Theme(
                  data: ThemeData.light().copyWith(
                    colorScheme: ColorScheme.light(
                      primary:
                          AppColors.primaryColor, // change to match your theme
                      onPrimary: Colors.white,
                      surface: Colors.white,
                      onSurface: Colors.black,
                    ),
                    dialogTheme: DialogThemeData(backgroundColor: Colors.white),
                  ),
                  child: child!,
                );
              },
            );
            if (date != null) {
              handleChange?.call(date);
            }
          },

          child: Container(
            width: double.infinity,
            height: Dimensions.getHeight(48),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(width: 0.35, color: Colors.grey.shade800),
              color: Colors.transparent,
            ),
            alignment: Alignment.centerLeft, // ✅ add this
            padding: EdgeInsets.symmetric(horizontal: 10), // ✅ optional
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    value ?? "2025-01-01",
                    style: TextStyle(
                      fontSize: Dimensions.getFontSize(18),
                      color: Colors.black,
                    ), // test with direct style
                  ),
                ),
                Icon(Icons.calendar_month, color: Colors.grey.shade900),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
