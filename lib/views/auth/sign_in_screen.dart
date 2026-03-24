import 'package:flutter/material.dart';
import '../../widgets/base_text_field.dart';
import '../../widgets/base_button.dart';
import 'forgot_password_screen.dart';
import 'package:point_sale/core/constants/app_color.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteWithOpacity(0.95),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Header Section
                Column(
                  children: [
                    const Text(
                      'Welcome',
                      style: TextStyle(
                        fontFamily: 'Arimo',
                        fontSize: 30,
                        fontWeight: FontWeight.normal,
                        color: AppColor.textSecondary,
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontFamily: 'Arimo',
                          fontSize: 16,
                          color: AppColor.textSecondary,
                          height: 1.5,
                        ),
                        children: [
                          TextSpan(text: 'Sign in to your '),
                          TextSpan(
                            text: 'PointSale ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: 'account'),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const SizedBox(height: 64),

                // Form Section
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Email Field
                      BaseTextField(
                        label: 'Email',
                        hintText: 'Enter your email',
                        controller: _emailController,
                        prefixIcon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 16),

                      // Password Field
                      BaseTextField(
                        label: 'Password',
                        hintText: 'Enter your password',
                        controller: _passwordController,
                        prefixIcon: Icons.lock_outline,
                        obscureText: _obscurePassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            size: 19.989,
                            color: AppColor.textSecondary,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Sign In Button
                      BaseButton(
                        text: 'Sign In',
                        onPressed: () {
                          Navigator.pushNamed(context, '/');
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Forgot Password
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgotPasswordScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontFamily: 'Arimo',
                      fontSize: 14,
                      color: AppColor.primary,
                      height: 1.43,
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Divider with text
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: AppColor.whiteWithOpacity(0.8),
                          thickness: 1.15,
                        ),
                      ),
                      Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: const Text(
                          'Or continue with',
                          style: TextStyle(
                            fontFamily: 'Arimo',
                            fontSize: 14,
                            color: AppColor.textSecondary,
                            height: 1.43,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: AppColor.whiteWithOpacity(0.8),
                          thickness: 1.15,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Google Sign In Button
                BaseButton(
                  text: 'Sign in with Google',
                  onPressed: (){
                    // Handle Google sign in
                  },
                  isPrimary: false,
                  icon: Image.asset(
                    'assets/images/icons/google_favicon.png',
                    width: 20,
                    height: 20,
                  ),
                ),
                const SizedBox(height: 24),

                // Sign Up Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(
                        fontFamily: 'Arimo',
                        fontSize: 16,
                        color: Color(0xFF4A5565),
                        height: 1.5,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/sign_up',
                        );
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.only(left: 8),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                          fontFamily: 'Arimo',
                          fontSize: 16,
                          color: AppColor.primary,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
