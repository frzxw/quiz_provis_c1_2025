import 'package:flutter/material.dart';

class ItemDetailsScreen extends StatelessWidget {
  final int itemId;

  const ItemDetailsScreen({
    super.key,
    required this.itemId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Details'),
      ),
      body: Center(
        child: Text('Item ID: $itemId'),
      ),
    );
  }
}
