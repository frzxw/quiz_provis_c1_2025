import 'product.dart';

enum TransactionStatus {
  pending,
  confirmed,
  inUse,
  returned,
  completed,
  cancelled
}

class Transaction {
  final int id;
  final List<CartItem> items;
  final DateTime rentalStart;
  final DateTime rentalEnd;
  final TransactionStatus status;
  final String? transactionCode;
  final DateTime createdAt;

  Transaction({
    required this.id,
    required this.items,
    required this.rentalStart,
    required this.rentalEnd,
    required this.status,
    this.transactionCode,
    required this.createdAt,
  });

  double get totalAmount {
    return items.fold(0, (sum, item) => sum + item.totalPrice);
  }
}

class CartItem {
  final Product item;
  int quantity;
  final DateTime? rentalStart;
  final DateTime? rentalEnd;

  CartItem({
    required this.item,
    this.quantity = 1,
    this.rentalStart,
    this.rentalEnd,
  });

  int get totalPrice => item.isOnSale
      ? (item.salePrice! * quantity).toInt()
      : (item.price * quantity).toInt();
}

// Sample transactions
List<Transaction> sampleTransactions = [
  Transaction(
    id: 1,
    items: [
      CartItem(
        item: sampleItems[0],
        quantity: 1,
        rentalStart: DateTime.now().add(const Duration(days: 5)),
        rentalEnd: DateTime.now().add(const Duration(days: 8)),
      ),
      CartItem(
        item: sampleItems[1],
        quantity: 2,
        rentalStart: DateTime.now().add(const Duration(days: 5)),
        rentalEnd: DateTime.now().add(const Duration(days: 8)),
      ),
    ],
    rentalStart: DateTime.now().add(const Duration(days: 5)),
    rentalEnd: DateTime.now().add(const Duration(days: 8)),
    status: TransactionStatus.confirmed,
    transactionCode: 'TRX-12345',
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
  ),
  Transaction(
    id: 2,
    items: [
      CartItem(
        item: sampleItems[2],
        quantity: 1,
        rentalStart: DateTime.now().subtract(const Duration(days: 3)),
        rentalEnd: DateTime.now().add(const Duration(days: 1)),
      ),
      CartItem(
        item: sampleItems[3],
        quantity: 1,
        rentalStart: DateTime.now().subtract(const Duration(days: 3)),
        rentalEnd: DateTime.now().add(const Duration(days: 1)),
      ),
    ],
    rentalStart: DateTime.now().subtract(const Duration(days: 3)),
    rentalEnd: DateTime.now().add(const Duration(days: 1)),
    status: TransactionStatus.inUse,
    transactionCode: 'TRX-12346',
    createdAt: DateTime.now().subtract(const Duration(days: 5)),
  ),
  Transaction(
    id: 3,
    items: [
      CartItem(
        item: sampleItems[4],
        quantity: 2,
        rentalStart: DateTime.now().subtract(const Duration(days: 10)),
        rentalEnd: DateTime.now().subtract(const Duration(days: 8)),
      ),
    ],
    rentalStart: DateTime.now().subtract(const Duration(days: 10)),
    rentalEnd: DateTime.now().subtract(const Duration(days: 8)),
    status: TransactionStatus.completed,
    transactionCode: 'TRX-12347',
    createdAt: DateTime.now().subtract(const Duration(days: 12)),
  ),
  Transaction(
    id: 4,
    items: [
      CartItem(
        item: sampleItems[5],
        quantity: 4,
        rentalStart: DateTime.now().subtract(const Duration(days: 15)),
        rentalEnd: DateTime.now().subtract(const Duration(days: 12)),
      ),
    ],
    rentalStart: DateTime.now().subtract(const Duration(days: 15)),
    rentalEnd: DateTime.now().subtract(const Duration(days: 12)),
    status: TransactionStatus.completed,
    transactionCode: 'TRX-12348',
    createdAt: DateTime.now().subtract(const Duration(days: 18)),
  ),
];
