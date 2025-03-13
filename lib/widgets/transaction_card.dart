import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import '../screens/returns_screen.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;

  const TransactionCard({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('MMM dd, yyyy');
    final numberFormat = NumberFormat('#,##0', 'id_ID');
    final size = MediaQuery.of(context).size;

    final bool isSmallScreen = size.width < 360;
    final bool isTabletOrLarger = size.width >= 600;

    final double padding =
        isSmallScreen ? 12.0 : (isTabletOrLarger ? 20.0 : 16.0);
    final double spacing =
        isSmallScreen ? 6.0 : (isTabletOrLarger ? 12.0 : 8.0);
    final double spacingLarge =
        isSmallScreen ? 12.0 : (isTabletOrLarger ? 24.0 : 16.0);
    final double imageSize =
        isSmallScreen ? 50.0 : (isTabletOrLarger ? 80.0 : 60.0);

    final double titleFontSize =
        isSmallScreen ? 14.0 : (isTabletOrLarger ? 18.0 : 16.0);
    final double bodyFontSize =
        isSmallScreen ? 12.0 : (isTabletOrLarger ? 16.0 : 14.0);
    final double smallFontSize =
        isSmallScreen ? 10.0 : (isTabletOrLarger ? 14.0 : 12.0);

    final titleStyle = theme.textTheme.titleMedium?.copyWith(
      fontWeight: FontWeight.bold,
      fontSize: titleFontSize,
    );

    final bodyStyle = theme.textTheme.bodyMedium?.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: bodyFontSize,
    );

    final captionStyle = theme.textTheme.bodySmall?.copyWith(
      color: Colors.grey.shade600,
      fontSize: smallFontSize,
    );

    final priceStyle = TextStyle(
      color: Colors.grey.shade600,
      fontSize: smallFontSize,
    );

    return Card(
      margin: EdgeInsets.symmetric(
        vertical: isSmallScreen ? 6.0 : 8.0,
        horizontal: isSmallScreen ? 0.0 : 4.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(isSmallScreen ? 8.0 : 12.0),
      ),
      elevation: isSmallScreen ? 1.0 : 2.0,
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Order #${transaction.transactionCode}',
                    style: titleStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                _buildStatusBadge(context, transaction.status, isSmallScreen),
              ],
            ),
            SizedBox(height: spacing),
            Text(
              'Created on ${dateFormat.format(transaction.createdAt)}',
              style: captionStyle,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: spacingLarge),

            // Rental period
            Container(
              padding: EdgeInsets.all(isSmallScreen ? 8.0 : 12.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.date_range,
                    color: Colors.grey,
                    size:
                        isSmallScreen ? 18.0 : (isTabletOrLarger ? 24.0 : 20.0),
                  ),
                  SizedBox(width: isSmallScreen ? 8.0 : 12.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Rental Period',
                          style: captionStyle,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '${dateFormat.format(transaction.rentalStart)} - ${dateFormat.format(transaction.rentalEnd)}',
                          style: bodyStyle,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spacingLarge),

            // Items
            Text(
              'Items',
              style: titleStyle,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: spacing),
            ...transaction.items
                .map((item) => Padding(
                      padding: EdgeInsets.only(bottom: spacing),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                                isSmallScreen ? 6.0 : 8.0),
                            child: Image.asset(
                              item.item.images[0],
                              width: imageSize,
                              height: imageSize,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: isSmallScreen ? 8.0 : 12.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.item.name,
                                  style: theme.textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: bodyFontSize,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                                SizedBox(height: isSmallScreen ? 2.0 : 4.0),
                                Text(
                                  '${item.quantity} x Rp${numberFormat.format(item.item.isOnSale ? item.item.salePrice : item.item.price)}/day',
                                  style: priceStyle,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: spacing),
                          Text(
                            'Rp${numberFormat.format(item.totalPrice)}',
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: bodyFontSize,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ))
                .toList(),

            Divider(
              height: isSmallScreen ? 20.0 : 24.0,
              thickness: isSmallScreen ? 0.8 : 1.0,
            ),

            // Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: titleStyle,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Rp${numberFormat.format(transaction.totalAmount)}',
                  style: titleStyle?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),

            SizedBox(height: spacingLarge),

            // Action buttons
            if (transaction.status == TransactionStatus.confirmed)
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // Cancel order
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red),
                        padding: EdgeInsets.symmetric(
                          vertical: isSmallScreen ? 8.0 : 12.0,
                        ),
                      ),
                      child: Text(
                        'Cancel Order',
                        style: TextStyle(fontSize: bodyFontSize),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  SizedBox(width: spacing),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // View details
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: isSmallScreen ? 8.0 : 12.0,
                        ),
                      ),
                      child: Text(
                        'View Details',
                        style: TextStyle(fontSize: bodyFontSize),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              )
            else if (transaction.status == TransactionStatus.inUse)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReturnsScreen(
                          transaction: transaction,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      vertical: isSmallScreen
                          ? 10.0
                          : (isTabletOrLarger ? 16.0 : 14.0),
                    ),
                  ),
                  child: Text(
                    'Return Items',
                    style: TextStyle(fontSize: bodyFontSize),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
            else
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // View details
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      vertical: isSmallScreen
                          ? 10.0
                          : (isTabletOrLarger ? 16.0 : 14.0),
                    ),
                  ),
                  child: Text(
                    'View Details',
                    style: TextStyle(fontSize: bodyFontSize),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(
      BuildContext context, TransactionStatus status, bool isSmallScreen) {
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
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 8.0 : 12.0,
        vertical: isSmallScreen ? 4.0 : 6.0,
      ),
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
          fontSize: isSmallScreen ? 10.0 : 12.0,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
