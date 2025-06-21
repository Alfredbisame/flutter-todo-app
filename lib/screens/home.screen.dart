import 'package:bloc_todo/api/controllers/auth.controller.dart';
import 'package:bloc_todo/api/controllers/tasks.controller.dart';
import 'package:bloc_todo/api/repositories/repository.dart';
import 'package:bloc_todo/components/bottom.sheet.container.dart';
import 'package:bloc_todo/components/day.of.week.card.dart';
import 'package:bloc_todo/components/home.appbar.dart';
import 'package:bloc_todo/components/loader.dart';
import 'package:bloc_todo/components/primary.button.dart';
import 'package:bloc_todo/components/task.summary.view.dart';
import 'package:bloc_todo/models/user.dart';
import 'package:bloc_todo/theme/app.colors.dart';
import 'package:bloc_todo/theme/app.font.size.dart';
import 'package:bloc_todo/utils/dimensions.dart';
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
  User? user;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
      _loadTasks();
    });
    super.initState();
  }

  //handle load data
  void _loadData() async {
    var repository = Get.find<Repository>();
    var userInfo = await repository.getAuthUser();
    if (userInfo?.user != null) {
      setState(() {
        user = userInfo?.user;
      });
    }
  }

  //handle load tasks
  void _loadTasks({int pageIndex = 0}) async {
    var taskController = Get.find<TasksController>();
    await taskController.getTasks(pageIndex: pageIndex);
  }

  Future<void> handleLogout() async {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return BottomSheetContainer(
          children: [
            Text(
              "Are you sure you want to logout?",
              style: AppFontSize.fontSizeMedium(
                fontSize: 22.width,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.height),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: PrimaryButton(
                    title: "Cancel",
                    onPressed: () {
                      Get.back();
                    },
                    bgColor: Colors.grey,
                  ),
                ),
                SizedBox(width: 15.width),
                Expanded(
                  child: PrimaryButton(
                    title: "Yes",
                    onPressed: () async {
                      Get.back();
                      var authController = Get.find<AuthController>();
                      await authController.handleSignOut();
                    },
                    bgColor: AppColors.redColor,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AuthController(repository: Get.find<Repository>()),
      builder: (authController) {
        return GetBuilder(
          init: TasksController(repository: Get.find<Repository>()),
          builder: (taskController) {
            return RefreshIndicator(
              child: Stack(
                children: [
                  AppView(
                    appBar:
                        user != null
                            ? HomeAppBar(
                              user: user!,
                              handleLogout: handleLogout,
                            )
                            : null,
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
                  ),
                  if (authController.loading || taskController.loading)
                    Loader(),
                ],
              ),
              onRefresh: () async {
                _loadTasks();
              },
            );
          },
        );
      },
    );
  }
}
