import 'package:flutter/material.dart';
import 'package:point_sale/features/stock/providers/stock_provider.dart';
import 'package:point_sale/features/transactions/providers/transaction_provider.dart';
import 'package:point_sale/features/orders/providers/order_provider.dart';
import 'package:point_sale/features/products/providers/product_inventory_provider.dart';
import 'package:point_sale/app/app_routes.dart';
import 'package:point_sale/features/auth/data/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:point_sale/features/cart/providers/cart_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final authService = AuthService();
  final isLoggedIn = await authService.isLoggedIn();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => StockProvider()),
        ChangeNotifierProvider(create: (_) => TransactionProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => ProductInventoryProvider()),
      ],
      child: MyApp(
        initialRoute: isLoggedIn ? AppRoutes.home : AppRoutes.signin,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Point Sale',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00B8D0)),
          useMaterial3: true,
        ),
        initialRoute: initialRoute,
        routes: AppRoutes.routes
    );
  }
}
