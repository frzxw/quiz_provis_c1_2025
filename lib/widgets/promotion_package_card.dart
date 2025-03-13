import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/product.dart';
import '../screens/package_purchase_screen.dart';

class PromotionPackageCard extends StatelessWidget {
  final Map<String, dynamic> promotion;

  const PromotionPackageCard({
    super.key,
    required this.promotion,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
    final double imageHeight =
        isSmallScreen ? 140.0 : (isTabletOrLarger ? 220.0 : 180.0);
    final double itemImageSize =
        isSmallScreen ? 40.0 : (isTabletOrLarger ? 80.0 : 60.0);
    final double badgeTop = isSmallScreen ? 8.0 : 16.0;
    final double badgeRight = isSmallScreen ? 8.0 : 16.0;

    final double titleFontSize =
        isSmallScreen ? 16.0 : (isTabletOrLarger ? 22.0 : 18.0);
    final double bodyFontSize =
        isSmallScreen ? 12.0 : (isTabletOrLarger ? 16.0 : 14.0);
    final double priceFontSize =
        isSmallScreen ? 16.0 : (isTabletOrLarger ? 24.0 : 20.0);
    final double smallFontSize =
        isSmallScreen ? 10.0 : (isTabletOrLarger ? 14.0 : 12.0);
    final double badgeFontSize =
        isSmallScreen ? 10.0 : (isTabletOrLarger ? 14.0 : 12.0);

    final titleStyle = theme.textTheme.titleLarge?.copyWith(
      fontWeight: FontWeight.bold,
      fontSize: titleFontSize,
    );

    final bodyStyle = theme.textTheme.bodyMedium?.copyWith(
      fontSize: bodyFontSize,
    );

    final itemTitleStyle = theme.textTheme.titleSmall?.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: bodyFontSize,
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

    final itemPriceStyle = TextStyle(
      color: Colors.grey.shade600,
      fontSize: smallFontSize,
    );

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(isSmallScreen ? 8.0 : 12.0),
      ),
      elevation: isSmallScreen ? 1.0 : (isTabletOrLarger ? 3.0 : 2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: imageHeight,
                child: Image.asset(
                  promotion['image'] as String,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: badgeTop,
                right: badgeRight,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isSmallScreen ? 8.0 : 12.0,
                    vertical: isSmallScreen ? 4.0 : 6.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'SAVE ${(((promotion['originalPrice'] - promotion['price']) / promotion['originalPrice']) * 100).toInt()}%',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: badgeFontSize,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  promotion['title'] as String,
                  style: titleStyle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                SizedBox(height: spacing),
                Text(
                  promotion['description'] as String,
                  style: bodyStyle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
                SizedBox(height: spacingLarge),
                Text(
                  'Included Items:',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: bodyFontSize,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spacing),
                ...List.generate(
                  (promotion['items'] as List).length,
                  (index) {
                    final itemId = (promotion['items'] as List)[index] as int;
                    final item =
                        sampleItems.firstWhere((item) => item.id == itemId);

                    return Padding(
                      padding: EdgeInsets.only(bottom: spacing),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                                isSmallScreen ? 6.0 : 8.0),
                            child: Image.asset(
                              item.images[0],
                              width: itemImageSize,
                              height: itemImageSize,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: isSmallScreen ? 8.0 : 12.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  style: itemTitleStyle,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                                SizedBox(height: isSmallScreen ? 2.0 : 4.0),
                                Text(
                                  'Rp${numberFormat.format(item.price)}/day',
                                  style: itemPriceStyle,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Divider(
                  height: isSmallScreen ? 20.0 : 24.0,
                  thickness: isSmallScreen ? 0.8 : 1.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Rp${numberFormat.format(promotion['originalPrice'])}',
                            style: strikethroughStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: isSmallScreen ? 2.0 : 4.0),
                          Text(
                            'Rp${numberFormat.format(promotion['price'])}',
                            style: priceStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PackagePurchaseScreen(
                              package: promotion,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: isSmallScreen ? 12.0 : 16.0,
                          vertical: isSmallScreen ? 8.0 : 12.0,
                        ),
                      ),
                      child: Text(
                        'View Package',
                        style: TextStyle(
                          fontSize: isSmallScreen ? 12.0 : 14.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
