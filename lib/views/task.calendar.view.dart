import 'package:bloc_todo/components/calendar.item.card.dart';
import 'package:flutter/material.dart';

import '../theme/app.colors.dart';

class TaskCalendarView extends StatelessWidget {
  const TaskCalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    var items = [
      "8 AM",
      "9 AM",
      "10 AM",
      "11 AM",
      "12 PM",
      "1 PM",
      "2 PM",
      "3 PM",
      "4 PM",
      "5 PM",
    ];
    return Container(
      decoration: BoxDecoration(color: AppColors.bodyBackgroundColor),
      child: Column(
        children: [
          //hour display
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                //is last item and first item
                bool isFirstItem = index == 0;
                return Column(
                  children: [
                    if (!isFirstItem)
                      SizedBox(
                        height: 30,
                        child: Row(
                          children: [
                            Text(""),
                            Expanded(child: Divider(color: Color(0xffD7D7D7))),
                          ],
                        ),
                      ),
                    Container(
                      height: 80,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            items[index],
                            style: TextStyle(
                              color: Color(0xff5D6065),
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: CalendarItemCard(
                              isActivePeriod: isFirstItem,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
