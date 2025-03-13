import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/product.dart';
import '../screens/item_detail_screen.dart';
import 'rating_stars.dart';

class WishlistItemCard extends StatelessWidget {
  final Product item;
  final VoidCallback onRemove;

  const WishlistItemCard({
    super.key,
    required this.item,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final numberFormat = NumberFormat('#,##0', 'id_ID');
    final size = MediaQuery.of(context).size;

    final bool isSmallScreen = size.width < 360;
    final bool isTabletOrLarger = size.width >= 600;

    final double imageDimension =
        isSmallScreen ? 80.0 : (isTabletOrLarger ? 120.0 : 100.0);
    final double horizontalPadding =
        isSmallScreen ? 10.0 : (isTabletOrLarger ? 16.0 : 12.0);
    final double spacing =
        isSmallScreen ? 12.0 : (isTabletOrLarger ? 20.0 : 16.0);
    final double smallSpacing =
        isSmallScreen ? 4.0 : (isTabletOrLarger ? 8.0 : 6.0);
    final double iconSize =
        isSmallScreen ? 20.0 : (isTabletOrLarger ? 28.0 : 24.0);

    final double titleFontSize =
        isSmallScreen ? 14.0 : (isTabletOrLarger ? 18.0 : 16.0);
    final double priceFontSize =
        isSmallScreen ? 13.0 : (isTabletOrLarger ? 16.0 : 14.0);
    final double smallFontSize =
        isSmallScreen ? 10.0 : (isTabletOrLarger ? 14.0 : 12.0);

    final titleStyle = theme.textTheme.titleMedium?.copyWith(
      fontWeight: FontWeight.bold,
      fontSize: titleFontSize,
    );

    final priceStyle = TextStyle(
      color: theme.colorScheme.primary,
      fontWeight: FontWeight.bold,
      fontSize: priceFontSize,
    );

    final strikethroughStyle = TextStyle(
      decoration: TextDecoration.lineThrough,
      color: Colors.grey,
      fontSize: smallFontSize,
    );

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItemDetailScreen(item: item),
          ),
        );
      },
      child: Card(
        elevation: isSmallScreen ? 1.0 : (isTabletOrLarger ? 3.0 : 2.0),
        margin: EdgeInsets.symmetric(
          vertical: isSmallScreen ? 4.0 : 6.0,
          horizontal: isSmallScreen ? 0.0 : 4.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(isSmallScreen ? 8.0 : 10.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(horizontalPadding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(isSmallScreen ? 6.0 : 8.0),
                child: Image.asset(
                  item.images[0],
                  width: imageDimension,
                  height: imageDimension,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: spacing),

              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            item.name,
                            style: titleStyle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          width: isSmallScreen ? 32 : 40,
                          height: isSmallScreen ? 32 : 40,
                          child: IconButton(
                            icon: Icon(
                              Icons.delete_outline,
                              size: iconSize,
                            ),
                            onPressed: onRemove,
                            color: Colors.grey,
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(
                              minWidth: isSmallScreen ? 32 : 40,
                              minHeight: isSmallScreen ? 32 : 40,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: isSmallScreen ? 2 : 4),
                    Row(
                      children: [
                        Flexible(
                          child: RatingStars(
                            rating: item.rating,
                            size: isSmallScreen
                                ? 14
                                : (isTabletOrLarger ? 18 : 16),
                          ),
                        ),
                        SizedBox(width: smallSpacing),
                        Text(
                          '(${item.reviewCount})',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: smallFontSize,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    SizedBox(height: isSmallScreen ? 6 : 8),
                    if (item.isOnSale)
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Text(
                              'Rp${numberFormat.format(item.price)}',
                              style: strikethroughStyle,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(width: smallSpacing),
                            Text(
                              'Rp${numberFormat.format(item.salePrice)}/day',
                              style: priceStyle,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      )
                    else
                      Text(
                        'Rp${numberFormat.format(item.price)}/day',
                        style: priceStyle,
                        overflow: TextOverflow.ellipsis,
                      ),
                    SizedBox(height: isSmallScreen ? 6 : 8),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
