import 'package:flutter/material.dart';

class PackagePurchaseScreen extends StatelessWidget {
  const PackagePurchaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Purchase Package'),
      ),
      body: const Center(
        child: Text('Package Purchase Screen Content'),
      ),
    );
  }
}
