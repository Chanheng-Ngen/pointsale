import 'package:flutter/material.dart';
import 'package:point_sale/views/auth/forgot_password_screen.dart';
import 'package:point_sale/views/auth/sign_in_screen.dart';
import 'package:point_sale/views/auth/sign_up_screen.dart';
import 'package:point_sale/views/checkout_screen.dart';
import 'package:point_sale/views/home_screen.dart';

import 'package:point_sale/views/about_us_view.dart';
import 'package:point_sale/views/stock_management.dart';
import 'package:point_sale/views/products_view.dart';
import 'package:point_sale/views/transactions_view.dart';
import 'package:point_sale/views/orders_view.dart';
import 'package:point_sale/views/analytics_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String checkout = '/checkout';
  static const String logout = '/logout';
  static const String signin = '/signin';
  static const String signup = '/signup';
  static const String forgetPassword = '/forget-password';
  static const String stockmanagement = '/stock';
  static const String about = '/about';
  static const String products = '/products';
  static const String transactions = '/transactions';
  static const String orders = '/orders';
  static const String analytics = '/analytics';

  static Map<String, WidgetBuilder> routes = {
    signin: (context) => const SignInScreen(),
    signup: (context) => const SignUpScreen(),
    forgetPassword: (context) => const ForgotPasswordScreen(),
    home: (context ) => const HomeScreen(),
    checkout: (context) => const CheckoutScreen(),
    stockmanagement: (context) => const StockManagementView(),
    about: (context) => const AboutUsView(),
    products: (context) => const ProductsView(),
    transactions: (context) => const TransactionsView(),
    orders: (context) => const OrdersView(),
    analytics: (context) => const AnalyticsScreen(),
  };
}
