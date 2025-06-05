import 'package:bloc_todo/utils/utilities.dart';
import 'package:flutter/material.dart';

class DayOfWeekCard extends StatelessWidget {
  final int index;
  final Function()? onTap;
  const DayOfWeekCard({super.key, required this.index, this.onTap});

  @override
  Widget build(BuildContext context) {
    var currentDayOfWeek = DateTime.now().weekday;
    var bgColor =
        currentDayOfWeek == index + 1 ? Color(0xffFF9D00) : Colors.white;
    var textColor = currentDayOfWeek == index + 1 ? Colors.white : Colors.black;
    return Material(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      shadowColor: Colors.transparent,
      child: Ink(
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: 80,
            height: 100,
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${index + 1}",
                  //"${index + 1}",
                  style: TextStyle(
                    fontSize: 36,
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  (index + 1).dayOfWeekShortName,
                  style: TextStyle(
                    fontSize: 18,
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
