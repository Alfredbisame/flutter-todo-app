import 'package:bloc_todo/api/controllers/auth.controller.dart';
import 'package:bloc_todo/api/controllers/auth.form.controller.dart';
import 'package:bloc_todo/api/repositories/repository.dart';
import 'package:bloc_todo/components/loader.dart';
import 'package:bloc_todo/dtos/auth.request.dto.dart';
import 'package:bloc_todo/views/auth/signin.content.view.dart';
import 'package:bloc_todo/views/auth/signup.content.view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/app.colors.dart';
import '../views/app.view.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? _errorMessage;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _signUpFormKey.currentState?.dispose();
    _signInFormKey.currentState?.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    if (_signUpFormKey.currentState != null &&
        !_signUpFormKey.currentState!.validate()) {
      return;
    }
    var formController = Get.find<AuthFormController>();
    var authRequest = AuthRequestDto(
      name: formController.nameController.text,
      email: formController.emailController.text,
      password: formController.passwordController.text,
    );
    var authController = Get.find<AuthController>();
    await authController.handleSignUp(authRequest);
  }

  Future<void> _handleSignIn() async {
    if (_signInFormKey.currentState != null &&
        !_signInFormKey.currentState!.validate()) {
      return;
    }
    var formController = Get.find<AuthFormController>();
    var authRequest = AuthRequestDto(
      name: formController.nameController.text,
      email: formController.emailController.text,
      password: formController.passwordController.text,
    );
    var authController = Get.find<AuthController>();
    await authController.handleSignIn(authRequest);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AuthController(repository: Get.find<Repository>()),
      builder: (authController) {
        return GetBuilder(
          init: AuthFormController(),
          builder: (authFormController) {
            return Stack(
              children: [
                AppView(
                  body: CustomScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    slivers: [
                      SliverAppBar(
                        backgroundColor: AppColors.bodyBackgroundColor,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _tabController.index == 0 ? "Sign In" : "Sign Up",
                            ),
                          ],
                        ),
                      ),
                      SliverFillRemaining(
                        child: Column(
                          children: [
                            // Header with tabs
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.05),
                                    blurRadius: 10,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(children: []),
                            ),

                            // Tab content
                            Expanded(
                              child: TabBarView(
                                controller: _tabController,
                                children: [
                                  SignInContentView(
                                    onTabChange: (int tabIndex) {
                                      _tabController.animateTo(tabIndex);
                                    },
                                    signInFormKey: _signInFormKey,
                                    emailController:
                                        authFormController.emailController,
                                    passwordController:
                                        authFormController.passwordController,
                                    isLoading: authController.loading,
                                    errorMessage: _errorMessage,
                                    handleSignIn: _handleSignIn,
                                  ),
                                  // Sign Up Tab
                                  SignUpContentView(
                                    onTabChange: (int tabIndex) {
                                      _tabController.animateTo(tabIndex);
                                    },
                                    signUpFormKey: _signUpFormKey,
                                    nameController:
                                        authFormController.nameController,
                                    emailController:
                                        authFormController.emailController,
                                    passwordController:
                                        authFormController.passwordController,
                                    confirmPasswordController:
                                        authFormController
                                            .confirmPasswordController,
                                    isLoading: authController.loading,
                                    errorMessage: _errorMessage,
                                    handleSignUp: _handleSignUp,
                                    tabController: _tabController,
                                  ),

                                  // Sign In Tab
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (authController.loading) Loader(),
              ],
            );
          },
        );
      },
    );
  }
}
