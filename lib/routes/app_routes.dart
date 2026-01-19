import 'package:flutter/material.dart';
import 'package:point_sale/views/auth/forgot_password_screen.dart';
import 'package:point_sale/views/auth/sign_in_screen.dart';
import 'package:point_sale/views/auth/sign_up_screen.dart';
import 'package:point_sale/views/checkout_screen.dart';
import 'package:point_sale/views/home_screen.dart';
import 'package:point_sale/views/stock_management.dart';
import 'package:point_sale/views/transactions_view.dart';
import 'package:point_sale/views/analytics_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String checkout = '/checkout';
  static const String logout = '/logout';
  static const String signin = '/signin';
  static const String signup = '/signup';
  static const String forgetPassword = '/forget-password';
  static const String stockmanagement = '/stock';
  static const String transactions = '/transactions';
  static const String analytics = '/analytics';

  static Map<String, WidgetBuilder> routes = {
    signin: (context) => const SignInScreen(),
    signup: (context) => const SignUpScreen(),
    forgetPassword: (context) => const ForgotPasswordScreen(),
    home: (context ) => const HomeScreen(),
    checkout: (context) => const CheckoutScreen(),
    stockmanagement: (context) => const StockManagementView(),
    transactions: (context) => const TransactionsView(),
    analytics: (context) => const AnalyticsScreen(),
  };
}
