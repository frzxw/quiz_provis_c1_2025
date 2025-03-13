import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class ReturnsScreen extends StatefulWidget {
  final Transaction transaction;

  const ReturnsScreen({
    super.key,
    required this.transaction,
  });

  @override
  State<ReturnsScreen> createState() => _ReturnsScreenState();
}

class _ReturnsScreenState extends State<ReturnsScreen> {
  final Map<int, bool> _selectedItems = {};
  final Map<int, String> _itemConditions = {};
  final Map<int, String?> _itemNotes = {};
  final Map<int, List<String>> _itemIssues = {};
  
  final List<String> _conditionOptions = [
    'Excellent',
    'Good',
    'Fair',
    'Poor',
    'Damaged',
  ];
  
  final List<String> _issueOptions = [
    'Scratches',
    'Tears',
    'Missing parts',
    'Not working properly',
    'Water damage',
    'Broken',
    'Other',
  ];
  
  @override
  void initState() {
    super.initState();
    // Initialize all items as selected by default
    for (final item in widget.transaction.items) {
      _selectedItems[item.item.id] = true;
      _itemConditions[item.item.id] = 'Excellent';
      _itemIssues[item.item.id] = [];
    }
  }
  
  bool get _allItemsSelected {
    return _selectedItems.values.every((selected) => selected);
  }
  
  void _toggleSelectAll(bool? value) {
    if (value == null) return;
    
    setState(() {
      for (final item in widget.transaction.items) {
        _selectedItems[item.item.id] = value;
      }
    });
  }
  
  void _toggleItemSelection(int itemId, bool? value) {
    if (value == null) return;
    
    setState(() {
      _selectedItems[itemId] = value;
    });
  }
  
  void _updateItemCondition(int itemId, String? condition) {
    if (condition == null) return;
    
    setState(() {
      _itemConditions[itemId] = condition;
    });
  }
  
  void _toggleItemIssue(int itemId, String issue) {
    setState(() {
      if (_itemIssues[itemId]!.contains(issue)) {
        _itemIssues[itemId]!.remove(issue);
      } else {
        _itemIssues[itemId]!.add(issue);
      }
    });
  }
  
  void _submitReturn() {
    // In a real app, this would send the return data to a backend
    
    // Check if any items are selected
    final hasSelectedItems = _selectedItems.values.any((selected) => selected);
    
    if (!hasSelectedItems) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one item to return'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    
    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Return'),
        content: const Text(
          'Are you sure you want to return the selected items? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              
              // Show success message and navigate back
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Return submitted successfully'),
                  duration: Duration(seconds: 2),
                ),
              );
              
              // Navigate back twice (to order monitoring screen)
              Navigator.pop(context);
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('MMM dd, yyyy');
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Return Items'),
      ),
      body: Column(
        children: [
          // Order Info
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey.shade100,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order #${widget.transaction.transactionCode}',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Rental Period: ${dateFormat.format(widget.transaction.rentalStart)} - ${dateFormat.format(widget.transaction.rentalEnd)}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.purple.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.purple),
                  ),
                  child: const Text(
                    'In Use',
                    style: TextStyle(
                      color: Colors.purple,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Select All Checkbox
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Checkbox(
                  value: _allItemsSelected,
                  onChanged: _toggleSelectAll,
                  activeColor: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Select All Items',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          // Items List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: widget.transaction.items.length,
              itemBuilder: (context, index) {
                final item = widget.transaction.items[index];
                final itemId = item.item.id;
                
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      dividerColor: Colors.transparent,
                    ),
                    child: ExpansionTile(
                      leading: Checkbox(
                        value: _selectedItems[itemId],
                        onChanged: (value) => _toggleItemSelection(itemId, value),
                        activeColor: theme.colorScheme.primary,
                      ),
                      title: Text(
                        item.item.name,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Quantity: ${item.quantity}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                      children: [
                        if (_selectedItems[itemId]!) ...[
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Item Condition
                                Text(
                                  'Item Condition',
                                  style: theme.textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                DropdownButtonFormField<String>(
                                  value: _itemConditions[itemId],
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
                                  ),
                                  items: _conditionOptions.map((condition) {
                                    return DropdownMenuItem<String>(
                                      value: condition,
                                      child: Text(condition),
                                    );
                                  }).toList(),
                                  onChanged: (value) => _updateItemCondition(itemId, value),
                                ),
                                
                                const SizedBox(height: 16),
                                
                                // Issues (if condition is not Excellent)
                                if (_itemConditions[itemId] != 'Excellent') ...[
                                  Text(
                                    'Issues (select all that apply)',
                                    style: theme.textTheme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: _issueOptions.map((issue) {
                                      final isSelected = _itemIssues[itemId]!.contains(issue);
                                      return FilterChip(
                                        label: Text(issue),
                                        selected: isSelected,
                                        onSelected: (selected) => _toggleItemIssue(itemId, issue),
                                        selectedColor: theme.colorScheme.primary.withOpacity(0.2),
                                        checkmarkColor: theme.colorScheme.primary,
                                      );
                                    }).toList(),
                                  ),
                                  
                                  const SizedBox(height: 16),
                                ],
                                
                                // Additional Notes
                                Text(
                                  'Additional Notes',
                                  style: theme.textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                TextFormField(
                                  initialValue: _itemNotes[itemId],
                                  decoration: InputDecoration(
                                    hintText: 'Any additional details about the item condition...',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    contentPadding: const EdgeInsets.all(16),
                                  ),
                                  maxLines: 3,
                                  onChanged: (value) {
                                    setState(() {
                                      _itemNotes[itemId] = value;
                                    });
                                  },
                                ),
                                
                                const SizedBox(height: 16),
                                
                                // Upload Photos Button
                                SizedBox(
                                  width: double.infinity,
                                  child: OutlinedButton.icon(
                                    onPressed: () {
                                      // Photo upload logic
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Photo upload feature coming soon'),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.camera_alt),
                                    label: const Text('Upload Photos'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          
          // Submit Button
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _submitReturn,
                child: const Text('Submit Return'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}