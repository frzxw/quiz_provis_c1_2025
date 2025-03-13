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
    price: 100000,
    rating: 4.7,
    reviewCount: 128,
    images: [
      'assets/images/tent1.png',
      'assets/images/tent2.png',
      'assets/images/tent3.png',
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
    price: 30000,
    rating: 4.5,
    reviewCount: 94,
    images: [
      'assets/images/sleeping_bag1.png',
      'assets/images/sleeping_bag2.png',
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
    salePrice: 25000,
  ),
  Product(
    id: 3,
    name: 'Kompor Camping Portabel',
    description:
        'Kompor gas kompak dengan penyalaan piezo. Ringan dan sempurna untuk memasak makanan selama petualangan camping Anda.',
    price: 15000,
    rating: 4.3,
    reviewCount: 76,
    images: [
      'assets/images/stove1.png',
      'assets/images/stove2.png',
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
    price: 17500,
    rating: 4.6,
    reviewCount: 112,
    images: [
      'assets/images/lantern1.png',
      'assets/images/lantern2.png',
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
    name: 'Tongkat Trekking',
    description:
        'Tongkat trekking aluminium yang dapat disesuaikan dengan pegangan nyaman. Sempurna untuk perjalanan hiking dan backpacking.',
    price: 50000,
    rating: 4.4,
    reviewCount: 68,
    images: [
      'assets/images/poles1.png',
      'assets/images/poles2.png',
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
    price: 30000,
    rating: 4.2,
    reviewCount: 85,
    images: [
      'assets/images/chair1.png',
      'assets/images/chair2.png',
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
    salePrice: 25000,
  ),
  Product(
    id: 7,
    name: 'Carrier 50L - Tas Hiking',
    description:
        'Tas nyaman dengan kapasitas 50L. Sempurna untuk perjalanan hiking dan camping, dilengkapi tali pengikat dan kantong samping.',
    price: 100000,
    rating: 4.5,
    reviewCount: 94,
    images: [
      'assets/images/bag1.png',
      'assets/images/bag2.png',
    ],
    specifications: {
      'Kapasitas': '50 L',
      'Berat': '1.2 kg',
      'Dimensi': '60 x 30 x 20 cm',
      'Bahan': 'Nilon, Polyester',
      'Fitur': 'Tali pengikat, Kantong samping',
    },
    isAvailable: true,
    isOnSale: true,
    salePrice: 90000,
  ),
  Product(
    id: 8,
    name: 'Matras Camping - Waterproof',
    description:
        'Matras dengan bahan nyaman dan tahan air. Sempurna untuk tidur nyenyak di lokasi camping Anda.',
    price: 25000,
    rating: 4.4,
    reviewCount: 68,
    images: [
      'assets/images/mat1.png',
    ],
    specifications: {
      'Tebal': '5 cm',
      'Berat': '1.2 kg',
      'Dimensi': '190 x 60 cm',
      'Bahan': 'Nilon, Busa',
      'Fitur': 'Tahan air, Mudah dilipat',
    },
    isAvailable: true,
  ),
  Product(
    id: 9,
    name: 'Jaket Gunung - Waterproof & Windproof',
    description:
        'Jaket gunung yang tahan air dan tahan angin. Cocok untuk perjalanan hiking dan camping di berbagai cuaca.',
    price: 100000,
    rating: 4.5,
    reviewCount: 94,
    images: [
      'assets/images/jacket1.png',
      'assets/images/jacket2.png',
    ],
    specifications: {
      'Bahan': 'Polyester',
      'Berat': '0.8 kg',
      'Ukuran': 'S, M, L, XL',
      'Fitur': 'Tahan air, Tahan angin',
    },
    isAvailable: true,
    isOnSale: true,
    salePrice: 90000,
  ),
  Product(
    id: 10,
    name: 'Sepatu Hiking - Anti Slip & Waterproof',
    description:
        'Sepatu hiking yang nyaman dan tahan air. Didesain dengan sol anti-slip untuk perjalanan hiking dan camping yang lebih aman.',
    price: 150000,
    rating: 4.5,
    reviewCount: 94,
    images: [
      'assets/images/shoes1.png',
      'assets/images/shoes2.png',
    ],
    specifications: {
      'Bahan': 'Kulit, Karet',
      'Berat': '1.2 kg',
      'Ukuran': '39, 40, 41, 42',
      'Fitur': 'Tahan air, Nyaman, Anti-slip',
    },
    isAvailable: true,
  ),
  Product(
    id: 11,
    name: 'Topi Outdoor - UV Protection',
    description:
        'Topi yang nyaman dan tahan air. Dilengkapi perlindungan UV untuk perjalanan hiking dan camping.',
    price: 50000,
    rating: 4.5,
    reviewCount: 94,
    images: [
      'assets/images/hat1.png',
      'assets/images/hat2.png',
    ],
    specifications: {
      'Bahan': 'Kain',
      'Berat': '0.2 kg',
      'Ukuran': 'M, L',
      'Fitur': 'Tahan air, Nyaman, Perlindungan UV',
    },
    isAvailable: true,
  ),
  Product(
    id: 12,
    name: 'Kacamata Outdoor - Anti Silau & Tahan Air',
    description:
        'Kacamata dengan desain stylish dan lensa anti silau. Cocok untuk perjalanan hiking dan camping.',
    price: 50000,
    rating: 4.5,
    reviewCount: 94,
    images: [
      'assets/images/glasses1.png',
      'assets/images/glasses2.png',
    ],
    specifications: {
      'Bahan': 'Plastik',
      'Berat': '0.1 kg',
      'Ukuran': 'M, L',
      'Fitur': 'Tahan air, Nyaman, Anti silau',
    },
    isAvailable: true,
    isPopular: true,
  ),
];

List<Map<String, dynamic>> promotionPackages = [
  {
    'id': 1,
    'title': 'Paket Camping Akhir Pekan',
    'description':
        'Set lengkap untuk liburan akhir pekan. Termasuk tenda, sleeping bag, dan peralatan memasak.',
    'price': 130500,
    'originalPrice': 145000,
    'image': 'assets/images/promo1.png',
    'items': [1, 2, 3],
  },
  {
    'id': 2,
    'title': 'Perlengkapan Hiking Esensial',
    'description':
        'Semua yang Anda butuhkan untuk hiking sehari. Termasuk ransel, tongkat trekking, dan filter air.',
    'price': 60750,
    'originalPrice': 67500,
    'image': 'assets/images/promo2.png',
    'items': [5, 4],
  },
  {
    'id': 3,
    'title': 'Bundel Camping Keluarga',
    'description':
        'Sempurna untuk perjalanan keluarga. Termasuk tenda besar, 4 sleeping bag, set peralatan masak, dan lampu.',
    'price': 177750,
    'originalPrice': 197500,
    'image': 'assets/images/promo3.png',
    'items': [1, 2, 3, 4, 6],
  },
];
