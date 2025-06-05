import 'package:bloc_todo/screens/home.screen.dart';
import 'package:bloc_todo/screens/welcome.screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/auth_button.dart';
import '../theme/app.colors.dart';
import '../views/app.view.dart';
import '../views/auth/sign_in_form.dart';
import '../views/auth/sign_up_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    if (!_signUpFormKey.currentState!.validate()) return;
    
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    // TODO: Implement sign up logic
    await Future.delayed(const Duration(seconds: 2)); // Mock API call
    
    setState(() => _isLoading = false);
    Get.snackbar(
      'Success', 
      'Account created!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.greenColor,
      colorText: Colors.white,
      borderRadius: 10,
      margin: EdgeInsets.all(10),
    );
  }

  Future<void> _handleSignIn() async {
  if (!_signInFormKey.currentState!.validate()) return;

  setState(() {
    _isLoading = true;
    _errorMessage = null;
  });

  // TODO: Implement actual sign in logic
  await Future.delayed(const Duration(seconds: 2)); // Simulated API call

  setState(() => _isLoading = false);

  Get.snackbar(
    'Success',
    'Logged in!',
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: AppColors.greenColor,
    colorText: Colors.white,
    borderRadius: 10,
    margin: const EdgeInsets.all(10),
  );

  // Navigate to HomeScreen after successful login
  Get.offAll(() => const HomeScreen());
}

  @override
  Widget build(BuildContext context) {
    return AppView(
      body: Scaffold(
        backgroundColor: AppColors.bodyBackgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              // Header with tabs
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back, color: AppColors.textGray),
                            onPressed: () {
                              Get.offUntil(
                                GetPageRoute(page: () => WelcomeScreen()),
                                (route) => false,
                              );
                            },
                          ),
                          Expanded(
                            child: Text(
                              "Welcome",
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(width: 48), // Balance the back button
                        ],
                      ),
                    ),
                    TabBar(
                      controller: _tabController,
                      indicatorColor: AppColors.primaryColor,
                      indicatorWeight: 3,
                      labelStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      labelColor: AppColors.primaryColor,
                      unselectedLabelColor: AppColors.textGray,
                      tabs: const [
                        Tab(text: 'Sign Up'),
                        Tab(text: 'Sign In'),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Tab content
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Sign Up Tab
                    _buildSignUpTab(),
                    
                    // Sign In Tab
                    _buildSignInTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpTab() {
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
                formKey: _signUpFormKey,
                nameController: _nameController,
                emailController: _emailController,
                passwordController: _passwordController,
                confirmPasswordController: _confirmPasswordController,
                onSubmit: _handleSignUp,
                isLoading: _isLoading,
                errorMessage: _errorMessage,
              ),
            ),
            SizedBox(height: 24),
            AuthButton(
              text: 'Create Account',
              onPressed: _handleSignUp,
              isLoading: _isLoading,
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
                    _tabController.animateTo(1);
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

  Widget _buildSignInTab() {
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
                formKey: _signInFormKey,
                emailController: _emailController,
                passwordController: _passwordController,
                onSubmit: _handleSignIn,
                isLoading: _isLoading,
                errorMessage: _errorMessage,
              ),
            ),
            SizedBox(height: 24),
            AuthButton(
              text: 'Sign In',
              onPressed: _handleSignIn,
              isLoading: _isLoading,
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
                    _tabController.animateTo(0);
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
