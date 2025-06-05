import 'package:bloc_todo/views/auth/auth_input.dart';
import 'package:flutter/material.dart';
import '../../theme/app.colors.dart';

class SignUpForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final VoidCallback onSubmit;
  final bool isLoading;
  final String? errorMessage;

  const SignUpForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.onSubmit,
    this.isLoading = false,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Form title
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Text(
              "Create your account",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textGray,
              ),
            ),
          ),
          
          // Name field
          AuthInput(
            label: 'Full Name',
            hintText: 'Enter your full name',
            controller: nameController,
            prefixIcon: Icon(Icons.person_outline, color: AppColors.textGray),
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          
          // Email field
          AuthInput(
            label: 'Email Address',
            hintText: 'Enter your email',
            controller: emailController,
            prefixIcon: Icon(Icons.email_outlined, color: AppColors.textGray),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          
          // Password field
          AuthInput(
            label: 'Password',
            hintText: 'Create a strong password',
            controller: passwordController,
            prefixIcon: Icon(Icons.lock_outline, color: AppColors.textGray),
            obscureText: true,
            textInputAction: TextInputAction.next,
            helperText: 'Must be at least 6 characters',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          
          // Confirm Password field
          AuthInput(
            label: 'Confirm Password',
            hintText: 'Confirm your password',
            controller: confirmPasswordController,
            prefixIcon: Icon(Icons.lock_outline, color: AppColors.textGray),
            obscureText: true,
            textInputAction: TextInputAction.done,
            onEditingComplete: onSubmit,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password';
              }
              if (value != passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
          
          // Error message
          if (errorMessage != null)
          Container(
            margin: const EdgeInsets.only(top: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.redColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.redColor.withOpacity(0.3),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.error_outline, color: AppColors.redColor, size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    errorMessage!,
                    style: TextStyle(
                      color: AppColors.redColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Terms and conditions
          Padding(
            padding: const EdgeInsets.only(top: 24, bottom: 8),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  color: AppColors.textGray,
                  fontSize: 13,
                ),
                children: [
                  TextSpan(
                    text: 'By signing up, you agree to our ',
                  ),
                  TextSpan(
                    text: 'Terms of Service',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: ' and ',
                  ),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
