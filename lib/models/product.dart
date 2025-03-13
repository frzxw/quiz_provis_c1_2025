class Product {
  final int id;
  final String name;
  final String description;
  final int price;
  final double rating;
  final int reviewCount;
  final List<String> images;
  final Map<String, String> specifications;
  final bool isAvailable;
  final bool isPopular;
  final bool isOnSale;
  final int? salePrice;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.images,
    required this.specifications,
    required this.isAvailable,
    this.isPopular = false,
    this.isOnSale = false,
    this.salePrice,
  });
}

// Sample data
List<Product> sampleItems = [
  Product(
    id: 1,
    name: 'Tenda Camping Premium',
    description:
        'Tenda luas untuk 4 orang dengan bahan tahan air, sempurna untuk perjalanan camping keluarga. Fitur pemasangan mudah dan ventilasi yang sangat baik.',
    price: 650000,
    rating: 4.7,
    reviewCount: 128,
    images: [
      'assets/images/tent1.jpg',
      'assets/images/tent2.jpg',
      'assets/images/tent3.jpg',
    ],
    specifications: {
      'Kapasitas': '4 Orang',
      'Berat': '3.5 kg',
      'Dimensi': '240 x 210 x 130 cm',
      'Bahan': 'Polyester, Tiang Aluminium',
      'Tahan Air': 'Ya, 3000mm',
    },
    isAvailable: true,
    isPopular: true,
  ),
  Product(
    id: 2,
    name: 'Sleeping Bag Ultraringan',
    description:
        'Sleeping bag kompak dan ringan cocok untuk suhu hingga 5°C. Sempurna untuk perjalanan backpacking dan hiking.',
    price: 350000,
    rating: 4.5,
    reviewCount: 94,
    images: [
      'assets/images/sleeping_bag1.jpg',
      'assets/images/sleeping_bag2.jpg',
    ],
    specifications: {
      'Rating Suhu': '5°C',
      'Berat': '0.9 kg',
      'Dimensi': '220 x 80 cm',
      'Bahan': 'Nilon, Isian Down',
      'Ukuran Terlipat': '15 x 25 cm',
    },
    isAvailable: true,
    isOnSale: true,
    salePrice: 280000,
  ),
  Product(
    id: 3,
    name: 'Kompor Camping Portabel',
    description:
        'Kompor gas kompak dengan penyalaan piezo. Ringan dan sempurna untuk memasak makanan selama petualangan camping Anda.',
    price: 220000,
    rating: 4.3,
    reviewCount: 76,
    images: [
      'assets/images/stove1.jpg',
      'assets/images/stove2.jpg',
    ],
    specifications: {
      'Jenis Bahan Bakar': 'Butana/Propana',
      'Berat': '0.35 kg',
      'Dimensi': '12 x 12 x 8 cm',
      'Waktu Mendidih': '3.5 menit (1L)',
      'Penyalaan': 'Piezo',
    },
    isAvailable: true,
  ),
  Product(
    id: 4,
    name: 'Lampu Camping LED',
    description:
        'Lampu LED terang dengan 3 mode pencahayaan. Tahan air dan sempurna untuk menerangi lokasi camping Anda.',
    price: 175000,
    rating: 4.6,
    reviewCount: 112,
    images: [
      'assets/images/lantern1.jpg',
      'assets/images/lantern2.jpg',
    ],
    specifications: {
      'Kecerahan': '300 lumens',
      'Baterai': '3 x AA (tidak termasuk)',
      'Waktu Pakai': 'Hingga 12 jam',
      'Berat': '0.4 kg',
      'Ketahanan Air': 'IPX4',
    },
    isAvailable: true,
    isPopular: true,
  ),
  Product(
    id: 5,
    name: 'Tongkat Trekking (Sepasang)',
    description:
        'Tongkat trekking aluminium yang dapat disesuaikan dengan pegangan nyaman. Sempurna untuk perjalanan hiking dan backpacking.',
    price: 265000,
    rating: 4.4,
    reviewCount: 68,
    images: [
      'assets/images/poles1.jpg',
      'assets/images/poles2.jpg',
    ],
    specifications: {
      'Bahan': 'Aluminium',
      'Berat': '0.5 kg (sepasang)',
      'Panjang': '65-135 cm (dapat disesuaikan)',
      'Pegangan': 'Busa EVA',
      'Ujung': 'Karbida',
    },
    isAvailable: true,
  ),
  Product(
    id: 6,
    name: 'Kursi Camping',
    description:
        'Kursi lipat nyaman dengan tempat minuman. Ringan dan mudah dibawa ke lokasi camping Anda.',
    price: 195000,
    rating: 4.2,
    reviewCount: 85,
    images: [
      'assets/images/chair1.jpg',
      'assets/images/chair2.jpg',
    ],
    specifications: {
      'Kapasitas Berat': '120 kg',
      'Berat': '2.2 kg',
      'Dimensi': '50 x 50 x 80 cm',
      'Bahan': 'Rangka Baja, Kain Polyester',
      'Fitur': 'Tempat minuman, Kantong penyimpanan',
    },
    isAvailable: true,
    isOnSale: true,
    salePrice: 150000,
  ),
];

List<Map<String, dynamic>> promotionPackages = [
  {
    'id': 1,
    'title': 'Paket Camping Akhir Pekan',
    'description':
        'Set lengkap untuk liburan akhir pekan. Termasuk tenda, sleeping bag, dan peralatan memasak.',
    'price': 1100000,
    'originalPrice': 1350000,
    'image': 'assets/images/promo1.jpg',
    'items': [1, 2, 3],
  },
  {
    'id': 2,
    'title': 'Perlengkapan Hiking Esensial',
    'description':
        'Semua yang Anda butuhkan untuk hiking sehari. Termasuk ransel, tongkat trekking, dan filter air.',
    'price': 650000,
    'originalPrice': 850000,
    'image': 'assets/images/promo2.jpg',
    'items': [5, 4],
  },
  {
    'id': 3,
    'title': 'Bundel Camping Keluarga',
    'description':
        'Sempurna untuk perjalanan keluarga. Termasuk tenda besar, 4 sleeping bag, set peralatan masak, dan lampu.',
    'price': 1750000,
    'originalPrice': 2100000,
    'image': 'assets/images/promo3.jpg',
    'items': [1, 2, 3, 4, 6],
  },
];
