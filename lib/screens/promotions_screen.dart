import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/product.dart';
import '../widgets/promotion_package_card.dart';

class PromotionsScreen extends StatelessWidget {
  const PromotionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    final bool isSmallScreen = size.width < 360;
    final bool isTabletOrLarger = size.width >= 600;
    final bool isDesktop = size.width >= 1024;

    final double padding =
        isSmallScreen ? 12.0 : (isTabletOrLarger ? 24.0 : 16.0);
    final double spacing =
        isSmallScreen ? 16.0 : (isTabletOrLarger ? 32.0 : 24.0);
    final double smallSpacing =
        isSmallScreen ? 8.0 : (isTabletOrLarger ? 16.0 : 12.0);
    final double bannerHeight =
        isSmallScreen ? 120.0 : (isTabletOrLarger ? 180.0 : 150.0);

    final double titleFontSize =
        isSmallScreen ? 18.0 : (isTabletOrLarger ? 26.0 : 22.0);
    final double subtitleFontSize =
        isSmallScreen ? 14.0 : (isTabletOrLarger ? 20.0 : 16.0);
    final double buttonFontSize =
        isSmallScreen ? 12.0 : (isTabletOrLarger ? 16.0 : 14.0);

    // Calculate responsive grid columns based on screen width
    int gridColumns = 2;
    if (isDesktop) {
      gridColumns = 4;
    } else if (isTabletOrLarger) {
      gridColumns = 3;
    }

    // Calculate child aspect ratio for grid items
    double aspectRatio = isSmallScreen ? 0.7 : (isTabletOrLarger ? 0.85 : 0.75);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Special Offers',
          style: TextStyle(fontSize: isSmallScreen ? 18 : 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Banner
              Container(
                width: double.infinity,
                height: bannerHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(isSmallScreen ? 8 : 12),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/promo_banner.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(isSmallScreen ? 8 : 12),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  padding: EdgeInsets.all(padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Summer Sale',
                        style: theme.textTheme.displayMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: titleFontSize,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: smallSpacing / 2),
                      Text(
                        'Up to 30% off on selected items',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontSize: subtitleFontSize,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: isSmallScreen ? 8 : 12),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: theme.colorScheme.primary,
                          padding: EdgeInsets.symmetric(
                            horizontal: isSmallScreen ? 12 : 16,
                            vertical: isSmallScreen ? 6 : 8,
                          ),
                        ),
                        child: Text(
                          'Shop Now',
                          style: TextStyle(fontSize: buttonFontSize),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: spacing),

              // Package Deals
              Text(
                'Package Deals',
                style: theme.textTheme.displayMedium?.copyWith(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: smallSpacing),

              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: promotionPackages.length,
                separatorBuilder: (context, index) =>
                    SizedBox(height: smallSpacing),
                itemBuilder: (context, index) {
                  return PromotionPackageCard(
                    promotion: promotionPackages[index],
                  );
                },
              ),

              SizedBox(height: spacing),

              // Sale Items
              Text(
                'Sale Items',
                style: theme.textTheme.displayMedium?.copyWith(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: smallSpacing),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: gridColumns,
                  childAspectRatio: aspectRatio,
                  crossAxisSpacing: isSmallScreen ? 8 : 16,
                  mainAxisSpacing: isSmallScreen ? 8 : 16,
                ),
                itemCount: sampleItems.where((item) => item.isOnSale).length,
                itemBuilder: (context, index) {
                  final saleItems =
                      sampleItems.where((item) => item.isOnSale).toList();
                  return _buildSaleItemCard(context, saleItems[index],
                      isSmallScreen, isTabletOrLarger);
                },
              ),

              SizedBox(height: padding),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSaleItemCard(BuildContext context, Product item,
      bool isSmallScreen, bool isTabletOrLarger) {
    final theme = Theme.of(context);
    final numberFormat = NumberFormat('#,##0', 'id_ID');

    final double padding = isSmallScreen ? 8.0 : 12.0;
    final double titleFontSize =
        isSmallScreen ? 12.0 : (isTabletOrLarger ? 16.0 : 14.0);
    final double priceFontSize =
        isSmallScreen ? 14.0 : (isTabletOrLarger ? 18.0 : 16.0);
    final double badgeFontSize =
        isSmallScreen ? 10.0 : (isTabletOrLarger ? 14.0 : 12.0);
    final double savingsFontSize =
        isSmallScreen ? 10.0 : (isTabletOrLarger ? 13.0 : 12.0);
    final double strikeThroughFontSize =
        isSmallScreen ? 12.0 : (isTabletOrLarger ? 16.0 : 14.0);

    return GestureDetector(
      onTap: () {
        // Navigate to item details
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: isSmallScreen ? 1 : 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(isSmallScreen ? 6 : 8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sale badge
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset(
                    item.images[0],
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: isSmallScreen ? 4 : 8,
                  right: isSmallScreen ? 4 : 8,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: isSmallScreen ? 6 : 8,
                      vertical: isSmallScreen ? 2 : 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'SALE',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: badgeFontSize,
                      ),
                      overflow: TextOverflow.ellipsis,
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
                    item.name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: titleFontSize,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: isSmallScreen ? 2 : 4),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          'Rp${numberFormat.format(item.price)}',
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                            fontSize: strikeThroughFontSize,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: isSmallScreen ? 4 : 8),
                      Flexible(
                        flex: 2,
                        child: Text(
                          'Rp${numberFormat.format(item.salePrice)}',
                          style: TextStyle(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: priceFontSize,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: isSmallScreen ? 4 : 8),
                  Text(
                    'Save ${(((item.price - item.salePrice!) / item.price) * 100).toInt()}%',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: savingsFontSize,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
