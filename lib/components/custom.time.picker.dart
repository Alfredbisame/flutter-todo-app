import 'package:flutter/material.dart';

import '../utils/dimensions.dart';

class CustomTimePicker extends StatelessWidget {
  final String? label;
  final String? hintText;
  final Function(TimeOfDay? time)? handleChange;
  final String? value;

  const CustomTimePicker({
    super.key,
    this.label,
    this.hintText,
    this.handleChange,
    this.value,
  });

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.purple, // your desired primary color
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            timePickerTheme: const TimePickerThemeData(
              backgroundColor: Colors.white,
              hourMinuteTextColor: Colors.black,
              dialHandColor: Colors.purple,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      if (handleChange != null) {
        handleChange!(pickedTime);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label!,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        if (label != null) const SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            _selectTime(context);
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
                    value ?? "12:00 AM",
                    style: TextStyle(
                      fontSize: Dimensions.getFontSize(18),
                      color: Colors.black,
                    ), // test with direct style
                  ),
                ),
                Icon(Icons.access_time, color: Colors.grey.shade900),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
