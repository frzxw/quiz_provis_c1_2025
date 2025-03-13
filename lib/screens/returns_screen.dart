import 'package:flutter/material.dart';

class ReturnsScreen extends StatelessWidget {
  const ReturnsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Returns'),
      ),
      body: const Center(
        child: Text('Returns Screen Content'),
      ),
    );
  }
}