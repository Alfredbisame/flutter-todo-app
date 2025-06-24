//extension on int to get the month name
import 'package:flutter/material.dart';

extension MonthName on int {
  String get monthName {
    switch (this) {
      case 1:
        return "January";
      case 2:
        return "February";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9:
        return "September";
      case 10:
        return "October";
      case 11:
        return "November";
      case 12:
        return "December";
      default:
        return "";
    }
  }
}

//int to day of the week short name
extension DayOfWeekShortName on int {
  String get dayOfWeekShortName {
    switch (this) {
      case 1:
        return "Mon";
      case 2:
        return "Tue";
      case 3:
        return "Wed";
      case 4:
        return "Thu";
      case 5:
        return "Fri";
      case 6:
        return "Sat";
      case 7:
        return "Sun";
      default:
        return "";
    }
  }
}

//extension on TimeOfDay? to output hh:mm a
extension TimeOfDayExtension on TimeOfDay? {
  String toFormattedString() {
    if (this == null) return "";
    final hour = this!.hour;
    final minute = this!.minute;
    final period = hour >= 12 ? 'PM' : 'AM';
    final formattedHour = hour % 12 == 0 ? 12 : hour % 12;
    return '$formattedHour:${minute.toString().padLeft(2, '0')} $period';
  }
}

//email validation extension
extension EmailValidation on String {
  bool isValidEmail() {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(this);
  }
}

//get last name from full name
extension LastNameFromFullName on String {
  String getLastName() {
    final parts = split(' ');
    if (parts.length > 1) {
      return parts.last;
    }
    return this; // If there's no last name, return the full name
  }
}
