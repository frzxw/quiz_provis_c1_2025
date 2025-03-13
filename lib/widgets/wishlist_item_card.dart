import 'package:flutter/material.dart';
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
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  item.images[0],
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),

              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        RatingStars(rating: item.rating),
                        const SizedBox(width: 4),
                        Text(
                          '(${item.reviewCount})',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (item.isOnSale)
                      Row(
                        children: [
                          Text(
                            'IDR ${item.price.toStringAsFixed(2)}',
                            style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'IDR ${item.salePrice!.toStringAsFixed(2)}/day',
                            style: TextStyle(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    else
                      Text(
                        'IDR ${item.price.toStringAsFixed(2)}/day',
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Add to cart
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Added to cart'),
                                duration: Duration(seconds: 2),
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
                          child: const Text('Add to Cart'),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: onRemove,
                          color: Colors.grey,
                        ),
                      ],
                    ),
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
