import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:point_sale/providers/cart_provider.dart';
import 'package:point_sale/ui/views/checkout_screen.dart';
import 'package:point_sale/ui/views/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
        title: 'Point Sale',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00B8D0)),
          useMaterial3: true,
        ),
        routes: {
          '/': (context) => const HomeScreen(),
          '/checkout': (context) => const CheckoutScreen(),
        },
      ),
    );
  }
}
