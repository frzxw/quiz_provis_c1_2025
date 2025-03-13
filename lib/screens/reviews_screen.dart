import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/review.dart';
import '../widgets/rating_stars.dart';

class ReviewsScreen extends StatelessWidget {
  final Product item;
  final List<Review> reviews;

  const ReviewsScreen({
    super.key,
    required this.item,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviews'),
      ),
      body: Column(
        children: [
          // Summary
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.rating.toString(),
                      style: theme.textTheme.displayLarge,
                    ),
                    RatingStars(rating: item.rating),
                    const SizedBox(height: 4),
                    Text(
                      '${item.reviewCount} reviews',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    children: [
                      _buildRatingBar(context, 5, 0.7),
                      _buildRatingBar(context, 4, 0.2),
                      _buildRatingBar(context, 3, 0.05),
                      _buildRatingBar(context, 2, 0.03),
                      _buildRatingBar(context, 1, 0.02),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // Reviews List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: reviews.length,
              separatorBuilder: (context, index) => const Divider(height: 32),
              itemBuilder: (context, index) {
                final review = reviews[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(review.userImage),
                          radius: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                review.userName,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  RatingStars(rating: review.rating),
                                  const SizedBox(width: 8),
                                  Text(
                                    _formatDate(review.date),
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      review.comment,
                      style: theme.textTheme.bodyMedium,
                    ),
                    if (review.images != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: review.images!
                              .map(
                                (image) => ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    image,
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingBar(BuildContext context, int rating, double percentage) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Text(
            '$rating',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12,
            ),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.star, size: 12, color: Colors.amber),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: LinearProgressIndicator(
                value: percentage,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).colorScheme.primary,
                ),
                minHeight: 8,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '${(percentage * 100).toInt()}%',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays < 1) {
      return 'Today';
    } else if (difference.inDays < 2) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 30) {
      return '${(difference.inDays / 7).floor()} weeks ago';
    } else if (difference.inDays < 365) {
      return '${(difference.inDays / 30).floor()} months ago';
    } else {
      return '${(difference.inDays / 365).floor()} years ago';
    }
  }
}
