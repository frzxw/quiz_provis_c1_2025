import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import '../widgets/transaction_card.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Transaction> _getFilteredTransactions(TransactionStatus status) {
    if (status == TransactionStatus.pending ||
        status == TransactionStatus.confirmed) {
      return sampleTransactions
          .where((t) =>
              t.status == TransactionStatus.pending ||
              t.status == TransactionStatus.confirmed)
          .toList();
    } else if (status == TransactionStatus.inUse) {
      return sampleTransactions
          .where((t) => t.status == TransactionStatus.inUse)
          .toList();
    } else {
      return sampleTransactions
          .where((t) =>
              t.status == TransactionStatus.returned ||
              t.status == TransactionStatus.completed ||
              t.status == TransactionStatus.cancelled)
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Rentals'),
        bottom: TabBar(
          controller: _tabController,
          labelColor: theme.colorScheme.primary,
          unselectedLabelColor: Colors.grey,
          indicatorColor: theme.colorScheme.primary,
          tabs: const [
            Tab(text: 'Upcoming'),
            Tab(text: 'Active'),
            Tab(text: 'History'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Upcoming rentals
          _buildTransactionList(
            _getFilteredTransactions(TransactionStatus.confirmed),
            'No upcoming rentals',
            'Your confirmed rental bookings will appear here',
          ),

          // Active rentals
          _buildTransactionList(
            _getFilteredTransactions(TransactionStatus.inUse),
            'No active rentals',
            'Your currently active rentals will appear here',
          ),

          // Rental history
          _buildTransactionList(
            _getFilteredTransactions(TransactionStatus.completed),
            'No rental history',
            'Your past rentals will appear here',
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionList(
    List<Transaction> transactions,
    String emptyTitle,
    String emptySubtitle,
  ) {
    final theme = Theme.of(context);

    return transactions.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.receipt_long_outlined,
                  size: 80,
                  color: Colors.grey.shade400,
                ),
                const SizedBox(height: 16),
                Text(
                  emptyTitle,
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  emptySubtitle,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to home
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  child: const Text('Browse Items'),
                ),
              ],
            ),
          )
        : ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: transactions.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              return TransactionCard(transaction: transactions[index]);
            },
          );
  }
}
