class Review {
  final int id;
  final String userName;
  final String userImage;
  final double rating;
  final String comment;
  final DateTime date;
  final List<String>? images;

  Review({
    required this.id,
    required this.userName,
    required this.userImage,
    required this.rating,
    required this.comment,
    required this.date,
    this.images,
  });
}

// Sample reviews
List<Review> getSampleReviews(int itemId) {
  return [
    Review(
      id: 1,
      userName: 'Alex Johnson',
      userImage: 'assets/images/user1.png',
      rating: 5.0,
      comment: 'Excellent quality tent! It was easy to set up and kept us dry during a rainy night. Highly recommend for family camping.',
      date: DateTime.now().subtract(const Duration(days: 5)),
      images: ['assets/images/review1.png', 'assets/images/review2.png'],
    ),
    Review(
      id: 2,
      userName: 'Sarah Miller',
      userImage: 'assets/images/user2.png',
      rating: 4.5,
      comment: 'Great product, just as described. Spacious and comfortable. The only minor issue was one of the zippers was a bit stiff.',
      date: DateTime.now().subtract(const Duration(days: 12)),
    ),
    Review(
      id: 3,
      userName: 'Michael Chen',
      userImage: 'assets/images/user3.png',
      rating: 4.0,
      comment: 'Good value for money. The tent is sturdy and well-made. Setup took about 15 minutes the first time.',
      date: DateTime.now().subtract(const Duration(days: 20)),
      images: ['assets/images/review3.png'],
    ),
    Review(
      id: 4,
      userName: 'Emily Wilson',
      userImage: 'assets/images/user4.png',
      rating: 5.0,
      comment: 'Perfect for our weekend trip! Plenty of room for 4 people and our gear. Will definitely rent again.',
      date: DateTime.now().subtract(const Duration(days: 30)),
    ),
  ];
}
