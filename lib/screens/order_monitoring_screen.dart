import 'package:flutter/material.dart';

class OrderMonitoringScreen extends StatelessWidget {
  const OrderMonitoringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Monitoring'),
      ),
      body: Center(
        child: const Text('Order Monitoring Content'),
      ),
    );
  }
}