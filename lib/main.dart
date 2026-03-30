import 'package:flutter/material.dart';
import 'package:point_sale/providers/stock_provider.dart';
import 'package:point_sale/providers/transaction_provider.dart';
import 'package:point_sale/providers/order_provider.dart';
import 'package:point_sale/providers/product_inventory_provider.dart';
import 'package:point_sale/routes/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:point_sale/providers/cart_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => StockProvider()),
        ChangeNotifierProvider(create: (_) => TransactionProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => ProductInventoryProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Point Sale',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00B8D0)),
          useMaterial3: true,
        ),
        routes: AppRoutes.routes
    );
  }
}
