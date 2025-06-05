import 'package:bloc_todo/resources/resources.dart';
import 'package:bloc_todo/screens/auth_screen.dart';
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
    //delay for 2 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAll(() => AuthScreen());
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
