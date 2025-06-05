import 'package:bloc_todo/views/auth/auth_input.dart';
import 'package:flutter/material.dart';
import '../../theme/app.colors.dart';

class SignInForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onSubmit;
  final bool isLoading;
  final String? errorMessage;
 
  const SignInForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.onSubmit,
    this.isLoading = false,
    this.errorMessage,
  });

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Form title
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Text(
              "Welcome back",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textGray,
              ),
            ),
          ),
          
          // Email field
          AuthInput(
            label: 'Email Address',
            hintText: 'Enter your email',
            controller: widget.emailController,
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
            hintText: 'Enter your password',
            controller: widget.passwordController,
            prefixIcon: Icon(Icons.lock_outline, color: AppColors.textGray),
            obscureText: true,
            textInputAction: TextInputAction.done,
            onEditingComplete: widget.onSubmit,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          
          // Error message
          if (widget.errorMessage != null)
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
                  Icon(
                    Icons.error_outline,
                    color: AppColors.redColor,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.errorMessage!,
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
          
          // Remember me checkbox
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: InkWell(
              onTap: () {
                setState(() {
                  _rememberMe = !_rememberMe;
                });
              },
              borderRadius: BorderRadius.circular(4),
              child: Row(
                children: [
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: Checkbox(
                      value: _rememberMe,
                      onChanged: (value) {
                        setState(() {
                          _rememberMe = value ?? false;
                        });
                      },
                      activeColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Remember me',
                    style: TextStyle(
                      color: AppColors.textGray,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Security note
          Padding(
            padding: const EdgeInsets.only(top: 24, bottom: 8),
            child: Row(
              children: [
                Icon(
                  Icons.security,
                  size: 16,
                  color: AppColors.greenColor,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Your connection is secure and your data is protected',
                    style: TextStyle(
                      color: AppColors.textGray,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
