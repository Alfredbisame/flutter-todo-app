import 'package:flutter/material.dart';

import '../../components/auth_button.dart';
import '../../theme/app.colors.dart';
import 'sign_in_form.dart';

class SignInContentView extends StatelessWidget {
  final Function(int tabIndex) onTabChange;
  final GlobalKey<FormState> signInFormKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isLoading;
  final String? errorMessage;
  final Function() handleSignIn;
  const SignInContentView({
    super.key,
    required this.onTabChange,
    required this.signInFormKey,
    required this.emailController,
    required this.passwordController,
    required this.isLoading,
    required this.errorMessage,
    required this.handleSignIn,
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
              child: SignInForm(
                formKey: signInFormKey,
                emailController: emailController,
                passwordController: passwordController,
                onSubmit: handleSignIn,
                isLoading: isLoading,
                errorMessage: errorMessage,
              ),
            ),
            SizedBox(height: 24),
            AuthButton(
              text: 'Sign In',
              onPressed: handleSignIn,
              isLoading: isLoading,
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                // TODO: Add forgot password logic
              },
              child: Text(
                'Forgot Password?',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don\'t have an account? ',
                  style: TextStyle(color: AppColors.textGray),
                ),
                GestureDetector(
                  onTap: () {
                    onTabChange(1);
                  },
                  child: Text(
                    'Sign Up',
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
