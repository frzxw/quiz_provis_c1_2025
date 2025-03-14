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
  runApp(const CampingGearRentalApp());
}

class CampingGearRentalApp extends StatelessWidget {
  const CampingGearRentalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camping Gear Rental',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const NavigationScreen(),
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
