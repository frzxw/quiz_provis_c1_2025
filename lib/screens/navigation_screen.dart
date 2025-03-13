import 'package:flutter/material.dart';
import '../main.dart';
import 'promotions_screen.dart';
import 'reviews_screen.dart';
import 'notifications_screen.dart';
import 'home_screen.dart';
import 'item_detail_screen.dart';
import 'chat_screen.dart';
import 'wishlist_screen.dart';
import 'cart_screen.dart';
import 'package_purchase_screen.dart';
import 'order_monitoring_screen.dart';
import 'returns_screen.dart';
import '../models/product.dart';
import '../models/transaction.dart';
import '../models/review.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;
            final buttonWidth = screenWidth > 600 ? 300.0 : screenWidth * 0.8;

            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 800),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text(
                        'Quiz 1: UI',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Nomor Kelompok Praktikum: 66',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Anggota Kelompok:',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        '1. Fariz Wibisono',
                        style: TextStyle(fontSize: 16),
                      ),
                      const Text(
                        '2. Hasbi Haqqul Fikri',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      _buildButton(
                        context,
                        'Halaman Depan',
                        () => Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const HomeScreen())),
                        buttonWidth,
                      ),
                      const SizedBox(height: 16),
                      _buildButton(
                        context,
                        'Rincian Item',
                        () => Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                ItemDetailScreen(item: sampleItems[0]))),
                        buttonWidth,
                      ),
                      const SizedBox(height: 16),
                      _buildButton(
                        context,
                        'Chat',
                        () => Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ChatScreen())),
                        buttonWidth,
                      ),
                      const SizedBox(height: 16),
                      _buildButton(
                        context,
                        'Wishlist',
                        () => Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const WishlistScreen())),
                        buttonWidth,
                      ),
                      const SizedBox(height: 16),
                      _buildButton(
                        context,
                        'Keranjang & Checkout',
                        () => Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const CartScreen())),
                        buttonWidth,
                      ),
                      const SizedBox(height: 16),
                      _buildButton(
                        context,
                        'Pembelian Paket',
                        () => Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PackagePurchaseScreen(
                                package: promotionPackages[0]))),
                        buttonWidth,
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: buttonWidth,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Transaksi',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildButton(
                              context,
                              'Monitor Pesanan',
                              () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const OrderMonitoringScreen(
                                              orderNumber: '123456'))),
                              double.infinity,
                            ),
                            const SizedBox(height: 12),
                            _buildButton(
                              context,
                              'Pengembalian',
                              () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => ReturnsScreen(
                                          transaction: sampleTransactions[0]))),
                              double.infinity,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: buttonWidth,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Tambahan',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildButton(
                              context,
                              'Notifikasi',
                              () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const NotificationsScreen())),
                              double.infinity,
                            ),
                            const SizedBox(height: 12),
                            _buildButton(
                              context,
                              'Review',
                              () =>
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ReviewsScreen(
                                            item: sampleItems[0],
                                            reviews: getSampleReviews(1),
                                          ))),
                              double.infinity,
                            ),
                            const SizedBox(height: 12),
                            _buildButton(
                              context,
                              'Promosi',
                              () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const PromotionsScreen())),
                              double.infinity,
                            ),
                            const SizedBox(height: 12),
                            _buildButton(
                              context,
                              'Aplikasi Utama',
                              () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MainScreen())),
                              double.infinity,
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Catatan: Tidak ada tombol back saat masuk ke aplikasi utama, hanya bisa back via browser.',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildButton(
      BuildContext context, String text, VoidCallback onPressed, double width) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
