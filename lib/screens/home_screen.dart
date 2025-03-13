import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/category_card.dart';
import '../widgets/item_card.dart';
import '../widgets/promotion_card.dart';
import 'chat_screen.dart';
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

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App Bar with Search
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
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
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Find Your Gear',
                                style: theme.textTheme.displayLarge,
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.notifications_outlined),
                          onPressed: () {},
                          iconSize: 28,
                        ),
                        const CircleAvatar(
                          radius: 20,
                          backgroundImage:
                              AssetImage('assets/images/user1.jpg'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
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
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Categories',
                      style: theme.textTheme.displayMedium,
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: SizedBox(
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  children: [
                    CategoryCard(
                      icon: Icons.cabin,
                      title: 'Tents',
                      color: Color(0xFF4CAF50),
                    ),
                    SizedBox(width: 12),
                    CategoryCard(
                      icon: Icons.hotel,
                      title: 'Sleeping',
                      color: Color(0xFF795548),
                    ),
                    SizedBox(width: 12),
                    CategoryCard(
                      icon: Icons.outdoor_grill,
                      title: 'Cooking',
                      color: Color(0xFFFF9800),
                    ),
                    SizedBox(width: 12),
                    CategoryCard(
                      icon: Icons.backpack,
                      title: 'Backpacks',
                      color: Color(0xFF2196F3),
                    ),
                    SizedBox(width: 12),
                    CategoryCard(
                      icon: Icons.hiking,
                      title: 'Hiking',
                      color: Color(0xFF9C27B0),
                    ),
                  ],
                ),
              ),
            ),

            // Special Offers
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
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
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: SizedBox(
                height: 235,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  itemCount: promotionPackages.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: PromotionCard(
                        promotion: promotionPackages[index],
                      ),
                    );
                  },
                ),
              ),
            ),

            // Popular Items
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Popular Items',
                      style: theme.textTheme.displayMedium,
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.5,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
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

            const SliverPadding(
              padding: EdgeInsets.only(bottom: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
