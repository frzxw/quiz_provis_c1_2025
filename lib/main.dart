import 'package:flutter/material.dart';
import 'screens/navigation_screen.dart';
import 'screens/home_screen.dart';
import 'screens/item_details_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/wishlist_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/checkout_screen.dart';
import 'screens/package_purchase_screen.dart';
import 'screens/order_monitoring_screen.dart';
import 'screens/returns_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Navigation Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const NavigationScreen(),
        '/home': (context) => const HomeScreen(),
        '/itemDetails': (context) => const ItemDetailsScreen(itemId: 1),
        '/chat': (context) => const ChatScreen(),
        '/wishlist': (context) => const WishlistScreen(),
        '/cart': (context) => const CartScreen(),
        '/checkout': (context) => const CheckoutScreen(),
        '/packagePurchase': (context) => const PackagePurchaseScreen(),
        '/orderMonitoring': (context) => const OrderMonitoringScreen(),
        '/returns': (context) => const ReturnsScreen(),
      },
    );
  }
}
