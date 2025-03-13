import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class CartItemCard extends StatelessWidget {
  final CartItem cartItem;
  final VoidCallback onRemove;
  final Function(int) onUpdateQuantity;

  const CartItemCard({
    super.key,
    required this.cartItem,
    required this.onRemove,
    required this.onUpdateQuantity,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final item = cartItem.item;
    final dateFormat = DateFormat('MMM dd, yyyy');
    final numberFormat = NumberFormat('#,##0', 'id_ID');
    final size = MediaQuery.of(context).size;

    // Responsive adjustments
    final bool isSmallScreen = size.width < 360;
    final bool isTabletOrLarger = size.width >= 600;

    // Dimensions
    final double imageSizeWidth =
        isSmallScreen ? 70 : (isTabletOrLarger ? 100 : 80);
    final double imageSizeHeight =
        isSmallScreen ? 70 : (isTabletOrLarger ? 100 : 80);
    final double horizontalSpacing =
        isSmallScreen ? 10 : (isTabletOrLarger ? 20 : 16);
    final double verticalSpacing =
        isSmallScreen ? 8 : (isTabletOrLarger ? 16 : 12);
    final double fontSize = isSmallScreen ? 13 : (isTabletOrLarger ? 16 : 14);
    final double titleFontSize =
        isSmallScreen ? 14 : (isTabletOrLarger ? 18 : 16);
    final double smallFontSize =
        isSmallScreen ? 11 : (isTabletOrLarger ? 14 : 12);
    final double iconSize = isSmallScreen ? 20 : (isTabletOrLarger ? 24 : 22);
    final double quantityIconSize =
        isSmallScreen ? 14 : (isTabletOrLarger ? 18 : 16);

    // Create responsive text styles
    final titleStyle = theme.textTheme.titleMedium?.copyWith(
      fontWeight: FontWeight.bold,
      fontSize: titleFontSize,
    );

    final priceStyle = TextStyle(
      color: theme.colorScheme.primary,
      fontWeight: FontWeight.bold,
      fontSize: fontSize,
    );

    final strikethroughStyle = TextStyle(
      decoration: TextDecoration.lineThrough,
      color: Colors.grey,
      fontSize: smallFontSize,
    );

    final dateStyle = theme.textTheme.bodySmall?.copyWith(
      color: Colors.grey.shade600,
      fontSize: smallFontSize,
    );

    final quantityStyle = theme.textTheme.titleSmall?.copyWith(
      fontSize: fontSize,
    );

    final subtotalStyle = theme.textTheme.titleSmall?.copyWith(
      fontWeight: FontWeight.bold,
      fontSize: fontSize,
    );

    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(isSmallScreen ? 8 : 12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      elevation: isSmallScreen ? 1 : 2,
      child: Padding(
        padding: EdgeInsets.all(isSmallScreen ? 10 : 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(isSmallScreen ? 6 : 8),
                  child: Image.asset(
                    item.images[0],
                    width: imageSizeWidth,
                    height: imageSizeHeight,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: horizontalSpacing),

                // Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: titleStyle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: isSmallScreen ? 2 : 4),
                      if (item.isOnSale)
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Rp${numberFormat.format(item.salePrice)}/day',
                                style: priceStyle,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(width: isSmallScreen ? 6 : 8),
                            Text(
                              'Rp${numberFormat.format(item.price)}',
                              style: strikethroughStyle,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        )
                      else
                        Text(
                          'Rp${numberFormat.format(item.price)}/day',
                          style: priceStyle,
                          overflow: TextOverflow.ellipsis,
                        ),
                      SizedBox(height: isSmallScreen ? 6 : 8),
                      if (cartItem.rentalStart != null &&
                          cartItem.rentalEnd != null)
                        Text(
                          '${dateFormat.format(cartItem.rentalStart!)} - ${dateFormat.format(cartItem.rentalEnd!)}',
                          style: dateStyle,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),

                // Remove button
                IconButton(
                  icon: Icon(Icons.delete_outline, size: iconSize),
                  onPressed: onRemove,
                  color: Colors.grey,
                  padding: EdgeInsets.all(isSmallScreen ? 0 : 4),
                  constraints: BoxConstraints(
                      minWidth: isSmallScreen ? 32 : 40,
                      minHeight: isSmallScreen ? 32 : 40),
                ),
              ],
            ),

            SizedBox(height: verticalSpacing),
            Divider(height: 1, thickness: isSmallScreen ? 0.5 : 1),
            SizedBox(height: verticalSpacing),

            // Quantity and subtotal
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      Text(
                        'Quantity: ',
                        style: TextStyle(fontSize: fontSize),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () {
                                if (cartItem.quantity > 1) {
                                  onUpdateQuantity(cartItem.quantity - 1);
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: isSmallScreen ? 6 : 8,
                                    vertical: isSmallScreen ? 2 : 4),
                                child:
                                    Icon(Icons.remove, size: quantityIconSize),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: isSmallScreen ? 6 : 8,
                              ),
                              child: Text(
                                '${cartItem.quantity}',
                                style: quantityStyle,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                onUpdateQuantity(cartItem.quantity + 1);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: isSmallScreen ? 6 : 8,
                                    vertical: isSmallScreen ? 2 : 4),
                                child: Icon(Icons.add, size: quantityIconSize),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: horizontalSpacing),
                Text(
                  'Rp${numberFormat.format(cartItem.totalPrice)}',
                  style: subtotalStyle,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
