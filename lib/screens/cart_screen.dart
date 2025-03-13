import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/product.dart';
import '../models/transaction.dart';
import '../widgets/cart_item_card.dart';
import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
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

  double get _tax => _subtotal * 0.11;
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

  void _proceedToCheckout() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckoutScreen(
          cartItems: _cartItems,
          subtotal: _subtotal,
          tax: _tax,
          total: _total,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final numberFormat = NumberFormat('#,##0', 'id_ID');
    final size = MediaQuery.of(context).size;

    final bool isSmallScreen = size.width < 360;
    final bool isTabletOrLarger = size.width >= 600;

    // Calculate responsive padding based on screen size
    final double horizontalPadding =
        isTabletOrLarger ? size.width * 0.05 : (isSmallScreen ? 12.0 : 16.0);

    // Calculate responsive font sizes
    final double titleFontSize =
        isSmallScreen ? 16.0 : (isTabletOrLarger ? 20.0 : 18.0);
    final double bodyFontSize =
        isSmallScreen ? 12.0 : (isTabletOrLarger ? 16.0 : 14.0);
    final double summaryTitleSize =
        isSmallScreen ? 15.0 : (isTabletOrLarger ? 19.0 : 17.0);

    // Create responsive text styles
    final TextStyle titleStyle = theme.textTheme.titleLarge!.copyWith(
      fontSize: titleFontSize,
      fontWeight: FontWeight.bold,
    );

    final TextStyle bodyStyle = theme.textTheme.bodyLarge!.copyWith(
      fontSize: bodyFontSize,
    );

    final TextStyle summaryTitleStyle = theme.textTheme.titleLarge!.copyWith(
      fontSize: summaryTitleSize,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Cart',
          style: TextStyle(fontSize: isSmallScreen ? 18 : 20),
        ),
      ),
      body: _cartItems.isEmpty
          ? Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: isSmallScreen ? 60 : 80,
                      color: Colors.grey.shade400,
                    ),
                    SizedBox(height: isSmallScreen ? 12 : 16),
                    Text(
                      'Your cart is empty',
                      style: titleStyle,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: isSmallScreen ? 6 : 8),
                    Text(
                      'Add some camping gear to your cart',
                      style: TextStyle(
                        fontSize: bodyFontSize,
                        color: Colors.grey.shade600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: isSmallScreen ? 20 : 24),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: isSmallScreen ? 16 : 24,
                          vertical: isSmallScreen ? 12 : 16,
                        ),
                      ),
                      child: Text(
                        'Browse Items',
                        style: TextStyle(fontSize: bodyFontSize),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.all(horizontalPadding),
                    itemCount: _cartItems.length,
                    separatorBuilder: (context, index) => SizedBox(
                      height: isSmallScreen ? 12 : 16,
                    ),
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
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: isSmallScreen ? 12 : 16,
                  ),
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
                        style: summaryTitleStyle,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: isSmallScreen ? 12 : 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Subtotal',
                            style: bodyStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'Rp${numberFormat.format(_subtotal)}',
                            style: bodyStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      SizedBox(height: isSmallScreen ? 6 : 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tax (11%)',
                            style: bodyStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'Rp${numberFormat.format(_tax)}',
                            style: bodyStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      Divider(height: isSmallScreen ? 20 : 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: summaryTitleStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'Rp${numberFormat.format(_total)}',
                            style: summaryTitleStyle.copyWith(
                              color: theme.colorScheme.primary,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      SizedBox(height: isSmallScreen ? 12 : 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _proceedToCheckout,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              vertical: isSmallScreen ? 12 : 16,
                            ),
                          ),
                          child: Text(
                            'Proceed to Checkout',
                            style: TextStyle(
                              fontSize: isSmallScreen ? 14 : 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
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
