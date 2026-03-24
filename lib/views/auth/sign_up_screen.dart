import 'package:flutter/material.dart';
import '../../widgets/base_text_field.dart';
import '../../widgets/base_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSignUp() {
    // TODO: Implement sign up logic
  }

  void _handleGoogleSignUp() {
    // TODO: Implement Google sign up
  }

  void _navigateToSignIn() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: 413.217),
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Header Section
                Column(
                  children: [
                    const Text(
                      'Create Account',
                      style: TextStyle(
                        fontFamily: 'Arimo',
                        fontSize: 30,
                        fontWeight: FontWeight.normal,
                        color: Color(0xFF4A5565),
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Sign up to get started',
                      style: TextStyle(
                        fontFamily: 'Arimo',
                        fontSize: 16,
                        color: Color(0xFF4A5565),
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Form Section
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Full Name Field
                      BaseTextField(
                        label: 'Full Name',
                        hintText: 'Enter your name',
                        controller: _nameController,
                        prefixIcon: Icons.person_outline,
                      ),
                      const SizedBox(height: 16),

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
                        hintText: 'Create a password',
                        controller: _passwordController,
                        prefixIcon: Icons.lock_outline,
                        obscureText: _obscurePassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: const Color(0xFF6A7282),
                            size: 20,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Confirm Password Field
                      BaseTextField(
                        label: 'Confirm Password',
                        hintText: 'Confirm your password',
                        controller: _confirmPasswordController,
                        prefixIcon: Icons.lock_outline,
                        obscureText: _obscureConfirmPassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirmPassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: const Color(0xFF6A7282),
                            size: 20,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword = !_obscureConfirmPassword;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Sign Up Button
                      BaseButton(
                        text: 'Sign Up',
                        onPressed: _handleSignUp,
                        isPrimary: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Divider with text
                Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        color: Color(0xFFD1D5DC),
                        thickness: 1.15,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(
                          fontFamily: 'Arimo',
                          fontSize: 14,
                          color: Color(0xFF6A7282),
                          height: 1.43,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Divider(
                        color: Color(0xFFD1D5DC),
                        thickness: 1.15,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Google Sign Up Button
                BaseButton(
                  text: 'Sign up with Google',
                  onPressed: _handleGoogleSignUp,
                  isPrimary: false,
                  icon: Image.asset(
                    'assets/images/icons/google_favicon.png',
                    width: 20,
                    height: 20,
                  ),
                ),
                const SizedBox(height: 24),

                // Sign In Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account?',
                      style: TextStyle(
                        fontFamily: 'Arimo',
                        fontSize: 16,
                        color: Color(0xFF4A5565),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: _navigateToSignIn,
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                          fontFamily: 'Arimo',
                          fontSize: 16,
                          color: Color(0xFF00B8DB),
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
