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
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _isLoading = false;
      _transaction = widget.transaction ?? sampleTransactions[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final numberFormat = NumberFormat('#,##0', 'id_ID');
    final screenWidth = MediaQuery.of(context).size.width;
    final isTabletOrLarger = screenWidth > 600;

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
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal:
                    isTabletOrLarger ? constraints.maxWidth * 0.1 : 16.0,
                vertical: 16.0,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 800,
                ),
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
                            Wrap(
                              alignment: WrapAlignment.spaceBetween,
                              spacing: 16,
                              runSpacing: 8,
                              children: [
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Order #${widget.orderNumber}',
                                        style: theme.textTheme.titleLarge
                                            ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Placed on ${DateFormat('MMM dd, yyyy').format(_transaction.createdAt)}',
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                          color: Colors.grey.shade600,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                _buildStatusBadge(context, _transaction.status),
                              ],
                            ),
                            const SizedBox(height: 16),
                            const Divider(),
                            const SizedBox(height: 16),

                            // Rental Period
                            InfoRow(
                              icon: Icons.date_range,
                              label: 'Rental Period',
                              value:
                                  '${DateFormat('MMM dd, yyyy').format(_transaction.rentalStart)} - ${DateFormat('MMM dd, yyyy').format(_transaction.rentalEnd)}',
                              theme: theme,
                            ),
                            const SizedBox(height: 16),

                            // Total Amount
                            InfoRow(
                              icon: Icons.attach_money,
                              label: 'Total Amount',
                              value:
                                  'Rp${numberFormat.format(_transaction.totalAmount)}',
                              valueColor: theme.colorScheme.primary,
                              theme: theme,
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
                                      style:
                                          theme.textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${item.quantity} x Rp${numberFormat.format(item.item.isOnSale ? item.item.salePrice : item.item.price)}/day',
                                      style: theme.textTheme.bodyMedium,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 8),
                                    if (_transaction.status ==
                                        TransactionStatus.inUse)
                                      SizedBox(
                                        width: isTabletOrLarger ? 150 : null,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ReturnsScreen(
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
                                            textStyle:
                                                const TextStyle(fontSize: 12),
                                          ),
                                          child: const Text('Return Item'),
                                        ),
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
                    SizedBox(
                      width: double.infinity,
                      child: _buildActionButton(),
                    ),

                    const SizedBox(height: 16),

                    // Support Button
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
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
            ),
          );
        },
      ),
    );
  }

  Widget _buildActionButton() {
    if (_transaction.status == TransactionStatus.confirmed) {
      return ElevatedButton(
        onPressed: () {
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
      );
    } else if (_transaction.status == TransactionStatus.inUse) {
      return ElevatedButton(
        onPressed: () {
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
      );
    } else if (_transaction.status == TransactionStatus.completed) {
      return ElevatedButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Items added to cart'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        child: const Text('Rent Again'),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _buildOrderTimeline(BuildContext context) {
    final theme = Theme.of(context);

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

        return TimelineStep(
          step: step,
          isLastStep: isLastStep,
          theme: theme,
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

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;
  final ThemeData theme;

  const InfoRow({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
    required this.theme,
    this.valueColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.grey),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.grey.shade600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                value,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: valueColor,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TimelineStep extends StatelessWidget {
  final Map<String, dynamic> step;
  final bool isLastStep;
  final ThemeData theme;

  const TimelineStep({
    Key? key,
    required this.step,
    required this.isLastStep,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                step['description'] as String,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                step['date'] as String,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.grey.shade500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              if (!isLastStep) const SizedBox(height: 24),
            ],
          ),
        ),
      ],
    );
  }
}
