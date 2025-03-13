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
      userName: 'Hasbi Altamish',
      userImage: 'assets/images/user1.jpg',
      rating: 5.0,
      comment:
          'Kualitas tenda yang sangat baik! Mudah dipasang dan tetap kering selama malam hujan. Sangat direkomendasikan untuk berkemah keluarga.',
      date: DateTime.now().subtract(const Duration(days: 5)),
      images: ['assets/images/review1.png', 'assets/images/review2.png'],
    ),
    Review(
      id: 2,
      userName: 'Sarah Miller',
      userImage: 'assets/images/user1.jpg',
      rating: 4.5,
      comment:
          'Produk yang bagus, sesuai dengan deskripsi. Luas dan nyaman. Satu-satunya masalah kecil adalah salah satu resletingnya agak kaku.',
      date: DateTime.now().subtract(const Duration(days: 12)),
    ),
    Review(
      id: 3,
      userName: 'Fariz Alfarazi',
      userImage: 'assets/images/user1.jpg',
      rating: 4.0,
      comment:
          'Nilai yang baik untuk uang. Tenda ini kokoh dan dibuat dengan baik. Pemasangan memakan waktu sekitar 15 menit pertama kali.',
      date: DateTime.now().subtract(const Duration(days: 20)),
      images: ['assets/images/review3.png'],
    ),
    Review(
      id: 4,
      userName: 'Emily Wilson',
      userImage: 'assets/images/user1.jpg',
      rating: 5.0,
      comment:
          'Sempurna untuk perjalanan akhir pekan kami! Banyak ruang untuk 4 orang dan perlengkapan kami. Pasti akan menyewa lagi.',
      date: DateTime.now().subtract(const Duration(days: 30)),
    ),
  ];
}
