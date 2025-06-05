import 'package:flutter/material.dart';

class CalendarItemCard extends StatelessWidget {
  final bool isActivePeriod;
  const CalendarItemCard({super.key, this.isActivePeriod = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
        //shadow
        boxShadow:
            isActivePeriod
                ? [
                  BoxShadow(
                    color: Color(0xff03B0BC).withOpacity(0.4),
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ]
                : null,
        gradient:
            isActivePeriod
                ? LinearGradient(
                  colors: [Color(0xff00F0FF), Color(0xff03B0BC)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
                : null,
      ),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      height: 70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Landing page design",
            style: TextStyle(
              fontSize: 16,
              color: isActivePeriod ? Colors.white : Color(0xff6C6868),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text(
            "10:00 AM - 11:00 AM",
            style: TextStyle(
              fontSize: 14,
              color: isActivePeriod ? Colors.white : Color(0xff6C6868),
            ),
          ),
        ],
      ),
    );
  }
}
