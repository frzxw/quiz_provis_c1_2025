import 'package:flutter/material.dart';
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

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Quiz 1: UI',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const HomeScreen()));
              },
              child: const Text('Halaman Depan'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ItemDetailScreen(item: sampleItems[0])));
              },
              child: const Text('Rincian Item'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ChatScreen()));
              },
              child: const Text('Chat'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const WishlistScreen()));
              },
              child: const Text('Wishlist'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CartScreen()));
              },
              child: const Text('Keranjang & Checkout'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PackagePurchaseScreen(
                          package: promotionPackages[0],
                        )));
              },
              child: const Text('Pembelian Paket'),
            ),
            const SizedBox(height: 20),
            Container(
              color: Colors.blue[100],
              padding: const EdgeInsets.all(16),
              constraints: BoxConstraints(maxWidth: 600),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Transaksi',
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const OrderMonitoringScreen(
                              orderNumber: '123456')));
                    },
                    child: const Text('Monitor Pesanan'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ReturnsScreen(
                                transaction: sampleTransactions[0],
                              )));
                    },
                    child: const Text('Pengembalian'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
