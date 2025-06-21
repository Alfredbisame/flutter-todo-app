import 'package:flutter/material.dart';

import '../theme/app.colors.dart';
import '../theme/app.font.size.dart';
import '../utils/dimensions.dart';

class CustomDropdown<T> extends StatelessWidget {
  final List<T> items; // List of items of generic type T
  final T? selectedValue; // Currently selected value
  final String? label; // Label text for the dropdown
  final ValueChanged<T?>? onChanged; // Callback when an item is selected
  final String Function(T) itemLabel; // Function to extract label from item
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const CustomDropdown({
    Key? key,
    required this.items,
    required this.selectedValue,
    this.label,
    required this.onChanged,
    required this.itemLabel,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: const BoxConstraints.expand().maxWidth,
      child: DropdownButtonFormField<T>(
        isExpanded: true,
        hint: Text(
          hintText ?? "",
          style: AppFontSize.fontSizeMedium(
            color: Colors.black.withOpacity(0.5),
            fontFamily: "Nunito Sans",
          ),
        ),
        value: selectedValue,
        items:
            items.map((T value) {
              return DropdownMenuItem<T>(
                value: value,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width - 100,
                  ),
                  child: Text(
                    itemLabel(value),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                ),
              );
            }).toList(),
        style: AppFontSize.fontSizeMedium(),
        onChanged: onChanged,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          fillColor: AppColors.inputFillColor,
          labelStyle: AppFontSize.fontSizeMedium(
            color: AppColors.primaryColor,
            fontFamily: "Nunito Sans",
            fontWeight: FontWeight.w600,
            fontSize: 18.fontSize,
          ),
          filled: true,
          labelText: label,
          contentPadding: EdgeInsets.symmetric(
            vertical: 18.width,
            horizontal: 14.width,
          ),
          // Default border
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: AppColors.outlineColor,
              width: 0.35.width,
            ),
          ),
          // Border when enabled and not focused
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: AppColors.outlineColor, // Change color here
              width: 0.35.width,
            ),
          ),
          // Border when focused
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color:
                  AppColors.primaryColor, // Change color here for focused state
              width: 0.35.width,
            ),
          ),
          // Border when there's an error
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.red, // Change color here for error state
              width: 0.35.width,
            ),
          ),
          // Border when focused and there's an error
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.red, // Change color here for focused error state
              width: 0.35.width,
            ),
          ),
        ),
      ),
    );
  }
}
