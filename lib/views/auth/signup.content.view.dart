import 'package:flutter/material.dart';

import '../../components/auth_button.dart';
import '../../theme/app.colors.dart';
import 'sign_up_form.dart';

class SignUpContentView extends StatelessWidget {
  final GlobalKey<FormState> signUpFormKey;
  final TextEditingController nameController;
  final Function(int tabIndex) onTabChange;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool isLoading;
  final String? errorMessage;
  final Function() handleSignUp;
  final TabController tabController;
  const SignUpContentView({
    super.key,
    required this.onTabChange,
    required this.signUpFormKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.isLoading,
    required this.errorMessage,
    required this.handleSignUp,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              padding: EdgeInsets.all(20),
              child: SignUpForm(
                formKey: signUpFormKey,
                nameController: nameController,
                emailController: emailController,
                passwordController: passwordController,
                confirmPasswordController: confirmPasswordController,
                onSubmit: handleSignUp,
                isLoading: isLoading,
                errorMessage: errorMessage,
              ),
            ),
            SizedBox(height: 24),
            AuthButton(
              text: 'Create Account',
              onPressed: handleSignUp,
              isLoading: isLoading,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account? ',
                  style: TextStyle(color: AppColors.textGray),
                ),
                GestureDetector(
                  onTap: () {
                    tabController.animateTo(0);
                  },
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
