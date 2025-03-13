import 'package:flutter/material.dart';
import '../utils/app_theme.dart';
import '../screens/chat_screen.dart';
import 'screens/home_screen.dart';
import 'screens/wishlist_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/transactions_screen.dart';
import 'screens/navigation_screen.dart';
import 'widgets/bottom_navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camping Rental',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const NavigationScreen(),
      routes: {
        '/home': (context) => const MainScreen(),
        '/itemDetails': (context) =>
            const Placeholder(), // Replace with actual screen
        '/chat': (context) => const ChatScreen(),
        '/wishlist': (context) => const WishlistScreen(),
        '/cart': (context) => const CartScreen(),
        '/packagePurchase': (context) =>
            const Placeholder(), // Replace with actual screen
        '/orderMonitoring': (context) => const TransactionsScreen(),
        '/returns': (context) =>
            const Placeholder(), // Replace with actual screen
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const ChatScreen(),
    const CartScreen(),
    const WishlistScreen(),
    const TransactionsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: _screens[_selectedIndex],
            ),
          ),
          bottomNavigationBar: BottomNavigation(
            selectedIndex: _selectedIndex,
            onItemTapped: _onItemTapped,
          ),
        );
      },
    );
  }
}
