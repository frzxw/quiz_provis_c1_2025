import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import 'returns_screen.dart';
import 'chat_screen.dart';

class OrderMonitoringScreen extends StatefulWidget {
  final String orderNumber;
  final Transaction? transaction;

  const OrderMonitoringScreen({
    super.key,
    required this.orderNumber,
    this.transaction,
  });

  @override
  State<OrderMonitoringScreen> createState() => _OrderMonitoringScreenState();
}

class _OrderMonitoringScreenState extends State<OrderMonitoringScreen> {
  late Transaction _transaction;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTransaction();
  }

  Future<void> _loadTransaction() async {
    // In a real app, this would fetch the transaction from a backend
    // For demo purposes, we'll use a sample transaction or the provided one
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _isLoading = false;
      _transaction = widget.transaction ?? sampleTransactions[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Order Status'),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Status'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Info Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Order #${widget.orderNumber}',
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Placed on ${DateFormat('MMM dd, yyyy').format(_transaction.createdAt)}',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                        _buildStatusBadge(context, _transaction.status),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 16),

                    // Rental Period
                    Row(
                      children: [
                        const Icon(Icons.date_range, color: Colors.grey),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Rental Period',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.grey.shade600,
                              ),
                            ),
                            Text(
                              '${DateFormat('MMM dd, yyyy').format(_transaction.rentalStart)} - ${DateFormat('MMM dd, yyyy').format(_transaction.rentalEnd)}',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Total Amount
                    Row(
                      children: [
                        const Icon(Icons.attach_money, color: Colors.grey),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total Amount',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.grey.shade600,
                              ),
                            ),
                            Text(
                              'IDR ${_transaction.totalAmount.toStringAsFixed(2)}',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Order Timeline
            Text(
              'Order Timeline',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            _buildOrderTimeline(context),

            const SizedBox(height: 24),

            // Order Items
            Text(
              'Order Items',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Items List
            ...List.generate(_transaction.items.length, (index) {
              final item = _transaction.items[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          item.item.images[0],
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.item.name,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${item.quantity} x IDR ${item.item.isOnSale ? item.item.salePrice!.toStringAsFixed(2) : item.item.price.toStringAsFixed(2)}/day',
                              style: theme.textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 8),
                            if (_transaction.status == TransactionStatus.inUse)
                              ElevatedButton(
                                onPressed: () {
                                  // Navigate to return screen
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ReturnsScreen(
                                        transaction: _transaction,
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  textStyle: const TextStyle(fontSize: 12),
                                ),
                                child: const Text('Return Item'),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),

            const SizedBox(height: 24),

            // Action Buttons
            if (_transaction.status == TransactionStatus.confirmed)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Cancel order logic
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Order cancelled successfully'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text('Cancel Order'),
                ),
              )
            else if (_transaction.status == TransactionStatus.inUse)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to return screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReturnsScreen(
                          transaction: _transaction,
                        ),
                      ),
                    );
                  },
                  child: const Text('Return All Items'),
                ),
              )
            else if (_transaction.status == TransactionStatus.completed)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Reorder logic
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Items added to cart'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  child: const Text('Rent Again'),
                ),
              ),

            const SizedBox(height: 16),

            // Support Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  // Navigate to chat screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChatScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.support_agent),
                label: const Text('Contact Support'),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderTimeline(BuildContext context) {
    final theme = Theme.of(context);

    // Define timeline steps based on order status
    final List<Map<String, dynamic>> steps = [
      {
        'title': 'Order Placed',
        'description': 'Your order has been received',
        'icon': Icons.shopping_cart,
        'date': DateFormat('MMM dd, yyyy').format(_transaction.createdAt),
        'isCompleted': true,
      },
      {
        'title': 'Order Confirmed',
        'description': 'Your order has been confirmed',
        'icon': Icons.check_circle,
        'date': DateFormat('MMM dd, yyyy')
            .format(_transaction.createdAt.add(const Duration(hours: 2))),
        'isCompleted': _transaction.status != TransactionStatus.pending,
      },
      {
        'title': 'Ready for Pickup/Delivery',
        'description': 'Your items are ready',
        'icon': Icons.inventory,
        'date': DateFormat('MMM dd, yyyy')
            .format(_transaction.rentalStart.subtract(const Duration(days: 1))),
        'isCompleted': _transaction.status == TransactionStatus.inUse ||
            _transaction.status == TransactionStatus.returned ||
            _transaction.status == TransactionStatus.completed,
      },
      {
        'title': 'In Use',
        'description': 'You are using the items',
        'icon': Icons.hiking,
        'date': DateFormat('MMM dd, yyyy').format(_transaction.rentalStart),
        'isCompleted': _transaction.status == TransactionStatus.inUse ||
            _transaction.status == TransactionStatus.returned ||
            _transaction.status == TransactionStatus.completed,
      },
      {
        'title': 'Returned',
        'description': 'Items have been returned',
        'icon': Icons.assignment_return,
        'date': DateFormat('MMM dd, yyyy').format(_transaction.rentalEnd),
        'isCompleted': _transaction.status == TransactionStatus.returned ||
            _transaction.status == TransactionStatus.completed,
      },
      {
        'title': 'Completed',
        'description': 'Order has been completed',
        'icon': Icons.done_all,
        'date': DateFormat('MMM dd, yyyy')
            .format(_transaction.rentalEnd.add(const Duration(days: 1))),
        'isCompleted': _transaction.status == TransactionStatus.completed,
      },
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: steps.length,
      itemBuilder: (context, index) {
        final step = steps[index];
        final isLastStep = index == steps.length - 1;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: step['isCompleted']
                        ? theme.colorScheme.primary
                        : Colors.grey.shade300,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    step['icon'] as IconData,
                    color: step['isCompleted'] ? Colors.white : Colors.grey,
                    size: 16,
                  ),
                ),
                if (!isLastStep)
                  Container(
                    width: 2,
                    height: 50,
                    color: step['isCompleted']
                        ? theme.colorScheme.primary
                        : Colors.grey.shade300,
                  ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step['title'] as String,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: step['isCompleted']
                          ? theme.colorScheme.primary
                          : Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    step['description'] as String,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    step['date'] as String,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade500,
                    ),
                  ),
                  if (!isLastStep) const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatusBadge(BuildContext context, TransactionStatus status) {
    Color color;
    String text;

    switch (status) {
      case TransactionStatus.pending:
        color = Colors.orange;
        text = 'Pending';
        break;
      case TransactionStatus.confirmed:
        color = Colors.blue;
        text = 'Confirmed';
        break;
      case TransactionStatus.inUse:
        color = Colors.purple;
        text = 'In Use';
        break;
      case TransactionStatus.returned:
        color = Colors.amber;
        text = 'Returned';
        break;
      case TransactionStatus.completed:
        color = Colors.green;
        text = 'Completed';
        break;
      case TransactionStatus.cancelled:
        color = Colors.red;
        text = 'Cancelled';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
