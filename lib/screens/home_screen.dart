import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/category_card.dart';
import '../widgets/item_card.dart';
import '../widgets/promotion_card.dart';
import 'promotions_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    // Responsive values based on screen size
    final bool isTabletOrLarger = size.width >= 600;
    final bool isDesktop = size.width >= 1024;

    // Dynamic grid columns based on screen width
    int gridColumns = 2;
    if (isDesktop) {
      gridColumns = 4;
    } else if (isTabletOrLarger) {
      gridColumns = 3;
    }

    // Responsive padding that scales with screen size but has min/max bounds
    final double basePadding = size.width * 0.04; // 4% of screen width
    final double horizontalPadding = basePadding.clamp(12.0, 24.0);

    // Responsive aspect ratio for item cards
    final double itemAspectRatio = isTabletOrLarger ? 0.7 : 0.6;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App Bar with Search
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(horizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hello, Adventurer!',
                                style: theme.textTheme.bodyLarge,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Find Your Gear',
                                style: theme.textTheme.displayLarge,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.notifications_outlined),
                          onPressed: () {},
                          iconSize: 28,
                        ),
                        const SizedBox(width: 8),
                        const CircleAvatar(
                          radius: 20,
                          backgroundImage:
                              AssetImage('assets/images/user1.jpg'),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
                    TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search camping equipment...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Categories
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Categories',
                      style: theme.textTheme.displayMedium,
                    ),
                    SizedBox(height: size.height * 0.015),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: LayoutBuilder(builder: (context, constraints) {
                // Responsive height based on screen width
                final categoryHeight = size.width * 0.25;
                return SizedBox(
                  height: categoryHeight.clamp(100.0, 150.0),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding:
                        EdgeInsets.symmetric(horizontal: horizontalPadding),
                    children: [
                      CategoryCard(
                        icon: Icons.cabin,
                        title: 'Tents',
                        color: Color(0xFF4CAF50),
                      ),
                      SizedBox(width: horizontalPadding * 0.75),
                      CategoryCard(
                        icon: Icons.hotel,
                        title: 'Sleeping',
                        color: Color(0xFF795548),
                      ),
                      SizedBox(width: horizontalPadding * 0.75),
                      CategoryCard(
                        icon: Icons.outdoor_grill,
                        title: 'Cooking',
                        color: Color(0xFFFF9800),
                      ),
                      SizedBox(width: horizontalPadding * 0.75),
                      CategoryCard(
                        icon: Icons.backpack,
                        title: 'Backpacks',
                        color: Color(0xFF2196F3),
                      ),
                      SizedBox(width: horizontalPadding * 0.75),
                      CategoryCard(
                        icon: Icons.hiking,
                        title: 'Hiking',
                        color: Color(0xFF9C27B0),
                      ),
                    ],
                  ),
                );
              }),
            ),

            // Special Offers
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(horizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Special Offers',
                          style: theme.textTheme.displayMedium,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PromotionsScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'See All',
                            style: TextStyle(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.015),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: LayoutBuilder(builder: (context, constraints) {
                // Responsive promotion card height
                final promotionHeight = size.width * 0.45;
                return SizedBox(
                  height: promotionHeight.clamp(180.0, 300.0),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding:
                        EdgeInsets.symmetric(horizontal: horizontalPadding),
                    itemCount: promotionPackages.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(right: horizontalPadding),
                        child: PromotionCard(
                          promotion: promotionPackages[index],
                        ),
                      );
                    },
                  ),
                );
              }),
            ),

            // Popular Items
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(horizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Popular Items',
                      style: theme.textTheme.displayMedium,
                    ),
                    SizedBox(height: size.height * 0.015),
                  ],
                ),
              ),
            ),

            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: gridColumns,
                  childAspectRatio: itemAspectRatio,
                  crossAxisSpacing: horizontalPadding * 0.8,
                  mainAxisSpacing: horizontalPadding * 0.8,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final item = sampleItems[index];
                    return ItemCard(item: item);
                  },
                  childCount: sampleItems.length,
                ),
              ),
            ),

            SliverPadding(
              padding: EdgeInsets.only(bottom: horizontalPadding),
            ),
          ],
        ),
      ),
    );
  }
}
