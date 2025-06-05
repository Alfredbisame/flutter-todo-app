import 'package:bloc_todo/components/day.of.week.card.dart';
import 'package:bloc_todo/components/home.appbar.dart';
import 'package:bloc_todo/components/primary.button.dart';
import 'package:bloc_todo/components/task.summary.view.dart';
import 'package:bloc_todo/views/app.view.dart';
import 'package:bloc_todo/views/task.calendar.view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'task.create.screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return AppView(
      appBar: HomeAppBar(),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TaskSummaryView(), SizedBox(height: 15),
            //horizontal list view of the days of the week,
            SizedBox(height: 15),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                itemBuilder: (context, index) {
                  return DayOfWeekCard(
                    index: index,
                    onTap: () {
                      print("Day of week ${index + 1} tapped");
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 25),

            Expanded(child: TaskCalendarView()),
            SizedBox(height: 15),
            // add task button
            PrimaryButton(
              title: "Add New Task",
              onPressed: () {
                Get.to(() => TaskCreateScreen());
              },
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
