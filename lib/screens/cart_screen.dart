import '../models/product.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../widgets/cart_item_card.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // For demo purposes, we'll create some cart items
  final List<CartItem> _cartItems = [
    CartItem(
      item: sampleItems[0],
      quantity: 1,
      rentalStart: DateTime.now().add(const Duration(days: 3)),
      rentalEnd: DateTime.now().add(const Duration(days: 6)),
    ),
    CartItem(
      item: sampleItems[1],
      quantity: 2,
      rentalStart: DateTime.now().add(const Duration(days: 3)),
      rentalEnd: DateTime.now().add(const Duration(days: 6)),
    ),
  ];

  double get _subtotal => _cartItems.fold(
        0,
        (sum, item) => sum + item.totalPrice,
      );

  double get _tax => _subtotal * 0.11; // 10% tax
  double get _total => _subtotal + _tax;

  void _removeItem(int id) {
    setState(() {
      _cartItems.removeWhere((item) => item.item.id == id);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Item removed from cart'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _updateQuantity(int id, int quantity) {
    setState(() {
      final index = _cartItems.indexWhere((item) => item.item.id == id);
      if (index != -1) {
        _cartItems[index].quantity = quantity;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
      ),
      body: _cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 80,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Your cart is empty',
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Add some camping gear to your cart',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to home
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    child: const Text('Browse Items'),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                // Cart items list
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: _cartItems.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final item = _cartItems[index];
                      return CartItemCard(
                        cartItem: item,
                        onRemove: () => _removeItem(item.item.id),
                        onUpdateQuantity: (quantity) =>
                            _updateQuantity(item.item.id, quantity),
                      );
                    },
                  ),
                ),

                // Order summary
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 10,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order Summary',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Subtotal',
                            style: theme.textTheme.bodyLarge,
                          ),
                          Text(
                            'Rp${_subtotal.toStringAsFixed(2)}',
                            style: theme.textTheme.bodyLarge,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tax (11%)',
                            style: theme.textTheme.bodyLarge,
                          ),
                          Text(
                            'Rp${_tax.toStringAsFixed(2)}',
                            style: theme.textTheme.bodyLarge,
                          ),
                        ],
                      ),
                      const Divider(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Rp${_total.toStringAsFixed(2)}',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Proceed to checkout
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Proceeding to checkout...'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text('Proceed to Checkout'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
