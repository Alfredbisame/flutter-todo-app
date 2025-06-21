import 'package:bloc_todo/api/repositories/repository.dart';
import 'package:bloc_todo/resources/resources.dart';
import 'package:bloc_todo/routes/app.routes.dart';
import 'package:bloc_todo/views/app.view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      handleLoadData();
    });
  }

  void handleLoadData() {
    Future.delayed(const Duration(seconds: 2), () async {
      var repository = Get.find<Repository>();
      var authUser = await repository.getAuthUser();
      if (authUser == null) {
        return Get.offAllNamed(AppRoutes.authScreen);
      }
      Get.offAllNamed(AppRoutes.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppView(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(image: AssetImage(Resources.welcomeBanner)),
              SizedBox(height: 20),
              Text(
                "Manage your Tasks",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Welcome to the Todo App, where you can manage your tasks efficiently and effectively.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
