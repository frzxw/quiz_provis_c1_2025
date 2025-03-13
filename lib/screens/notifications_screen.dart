import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<Map<String, dynamic>> _notifications = [
    {
      'id': 1,
      'type': 'order',
      'title': 'Order Confirmed',
      'message': 'Your order #2587 has been confirmed and is being processed.',
      'timestamp': DateTime.now().subtract(const Duration(hours: 2)),
      'isRead': false,
    },
    {
      'id': 2,
      'type': 'promo',
      'title': 'Summer Sale!',
      'message':
          'Enjoy up to 30% off on selected camping gear. Limited time offer!',
      'timestamp': DateTime.now().subtract(const Duration(days: 1)),
      'isRead': false,
    },
    {
      'id': 3,
      'type': 'return',
      'title': 'Return Processed',
      'message':
          'We\'ve processed your return for order #2356. Your refund will be issued within 3-5 business days.',
      'timestamp': DateTime.now().subtract(const Duration(days: 3)),
      'isRead': true,
    },
    {
      'id': 4,
      'type': 'reminder',
      'title': 'Rental Due Tomorrow',
      'message':
          'Don\'t forget to return your rented equipment for order #2430 by tomorrow to avoid late fees.',
      'timestamp': DateTime.now().subtract(const Duration(days: 5)),
      'isRead': true,
    },
    {
      'id': 5,
      'type': 'promo',
      'title': 'New Hiking Collection',
      'message':
          'Check out our new hiking collection with premium gear for your next adventure!',
      'timestamp': DateTime.now().subtract(const Duration(days: 7)),
      'isRead': true,
    },
    {
      'id': 6,
      'type': 'order',
      'title': 'Order Ready for Pickup',
      'message':
          'Your order #2567 is ready for pickup at our store. Please bring your ID for verification.',
      'timestamp': DateTime.now().subtract(const Duration(days: 8)),
      'isRead': true,
    },
    {
      'id': 7,
      'type': 'system',
      'title': 'App Update Available',
      'message': 'Update your app to get the latest features and improvements.',
      'timestamp': DateTime.now().subtract(const Duration(days: 10)),
      'isRead': true,
    },
    {
      'id': 8,
      'type': 'promo',
      'title': 'Weekend Flash Sale',
      'message':
          'Flash sale this weekend! Get 20% off on tents and sleeping bags.',
      'timestamp': DateTime.now().subtract(const Duration(days: 12)),
      'isRead': true,
    },
  ];

  void _markAllAsRead() {
    setState(() {
      for (var notification in _notifications) {
        notification['isRead'] = true;
      }
    });
  }

  void _clearAll() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Notifications'),
        content:
            const Text('Are you sure you want to clear all notifications?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() => _notifications.clear());
              Navigator.pop(context);
            },
            child: Text(
              'Clear',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _markAsRead(int id) {
    setState(() {
      final index =
          _notifications.indexWhere((notification) => notification['id'] == id);
      if (index != -1) {
        _notifications[index]['isRead'] = true;
      }
    });
  }

  IconData _getIconForType(String type) {
    switch (type) {
      case 'order':
        return Icons.shopping_bag_outlined;
      case 'promo':
        return Icons.local_offer_outlined;
      case 'return':
        return Icons.assignment_return_outlined;
      case 'reminder':
        return Icons.alarm_outlined;
      case 'system':
        return Icons.system_update_outlined;
      default:
        return Icons.notifications_outlined;
    }
  }

  Color _getColorForType(String type) {
    switch (type) {
      case 'order':
        return const Color(0xFF4CAF50);
      case 'promo':
        return const Color(0xFF9C27B0);
      case 'return':
        return const Color(0xFF795548);
      case 'reminder':
        return const Color(0xFFFF9800);
      case 'system':
        return const Color(0xFF2196F3);
      default:
        return const Color(0xFF9E9E9E);
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hr ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return DateFormat('MMM dd').format(timestamp);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    final bool isSmallScreen = size.width < 360;
    final bool isTabletOrLarger = size.width >= 600;
    final bool isWideScreen = size.width >= 1200;

    final double padding =
        isSmallScreen ? 12.0 : (isTabletOrLarger ? 24.0 : 16.0);
    final double badgeSize =
        isSmallScreen ? 10.0 : (isTabletOrLarger ? 14.0 : 12.0);

    final double titleFontSize =
        isSmallScreen ? 14.0 : (isTabletOrLarger ? 18.0 : 16.0);
    final double messageFontSize =
        isSmallScreen ? 12.0 : (isTabletOrLarger ? 16.0 : 14.0);
    final double timeFontSize =
        isSmallScreen ? 10.0 : (isTabletOrLarger ? 14.0 : 12.0);

    final bool hasUnreadNotifications =
        _notifications.any((notification) => notification['isRead'] == false);
    final int unreadCount = _notifications
        .where((notification) => notification['isRead'] == false)
        .length;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: TextStyle(fontSize: isSmallScreen ? 18 : 20),
        ),
        actions: [
          if (_notifications.isNotEmpty)
            PopupMenuButton(
              icon: Icon(Icons.more_vert, size: isSmallScreen ? 22 : 24),
              itemBuilder: (context) => [
                if (hasUnreadNotifications)
                  PopupMenuItem(
                    onTap: _markAllAsRead,
                    child: Row(
                      children: [
                        Icon(Icons.mark_email_read,
                            color: theme.colorScheme.primary,
                            size: isSmallScreen ? 18 : 20),
                        SizedBox(width: isSmallScreen ? 8 : 12),
                        Text(
                          'Mark all as read',
                          style: TextStyle(fontSize: isSmallScreen ? 14 : 16),
                        ),
                      ],
                    ),
                  ),
                PopupMenuItem(
                  onTap: _clearAll,
                  child: Row(
                    children: [
                      Icon(Icons.delete_outline,
                          color: Colors.red, size: isSmallScreen ? 18 : 20),
                      SizedBox(width: isSmallScreen ? 8 : 12),
                      Text(
                        'Clear all',
                        style: TextStyle(fontSize: isSmallScreen ? 14 : 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
      body: Center(
        child: Container(
          constraints:
              BoxConstraints(maxWidth: isWideScreen ? 1200 : double.infinity),
          child: _notifications.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.notifications_off_outlined,
                        size: isTabletOrLarger ? 80 : 60,
                        color: Colors.grey.shade400,
                      ),
                      SizedBox(height: isSmallScreen ? 16 : 24),
                      Text(
                        'No Notifications',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontSize:
                              isSmallScreen ? 18 : (isTabletOrLarger ? 24 : 20),
                          color: Colors.grey.shade700,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: isSmallScreen ? 8 : 12),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: padding * 1.5),
                        child: Text(
                          'You don\'t have any notifications at the moment. We\'ll notify you about orders, promotions, and more.',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontSize: isSmallScreen ? 14 : 16,
                            color: Colors.grey.shade600,
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    if (hasUnreadNotifications)
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: isSmallScreen ? 8 : 12,
                          horizontal: padding,
                        ),
                        color: theme.colorScheme.primary.withOpacity(0.1),
                        child: Row(
                          children: [
                            Icon(
                              Icons.circle_notifications,
                              color: theme.colorScheme.primary,
                              size: isSmallScreen ? 18 : 20,
                            ),
                            SizedBox(width: isSmallScreen ? 8 : 12),
                            Expanded(
                              child: Text(
                                'You have $unreadCount unread notification${unreadCount > 1 ? 's' : ''}',
                                style: TextStyle(
                                  color: theme.colorScheme.primary,
                                  fontSize: isSmallScreen ? 12 : 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            TextButton(
                              onPressed: _markAllAsRead,
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  horizontal: isSmallScreen ? 8 : 12,
                                  vertical: isSmallScreen ? 4 : 6,
                                ),
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text(
                                'Mark all as read',
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 12 : 14,
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.all(padding),
                        itemCount: _notifications.length,
                        separatorBuilder: (context, index) => Divider(
                          height: isSmallScreen ? 1 : 2,
                          thickness: 0.5,
                        ),
                        itemBuilder: (context, index) {
                          final notification = _notifications[index];
                          final bool isRead = notification['isRead'] as bool;
                          final String type = notification['type'] as String;
                          final IconData iconData = _getIconForType(type);
                          final Color iconColor = _getColorForType(type);
                          final DateTime timestamp =
                              notification['timestamp'] as DateTime;

                          return Dismissible(
                            key: Key('notification_${notification['id']}'),
                            background: Container(
                              color: Colors.red.shade400,
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(right: padding),
                              child: Icon(
                                Icons.delete_outline,
                                color: Colors.white,
                                size: isSmallScreen ? 22 : 24,
                              ),
                            ),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              setState(() {
                                _notifications.removeAt(index);
                              });
                            },
                            child: InkWell(
                              onTap: () {
                                if (!isRead) {
                                  _markAsRead(notification['id'] as int);
                                }
                                // Navigate to notification detail or related screen
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: isSmallScreen ? 12 : 16),
                                color: isRead
                                    ? null
                                    : theme.colorScheme.primary
                                        .withOpacity(0.05),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(
                                          isSmallScreen ? 8 : 10),
                                      decoration: BoxDecoration(
                                        color: iconColor.withOpacity(0.1),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        iconData,
                                        color: iconColor,
                                        size: isSmallScreen ? 18 : 20,
                                      ),
                                    ),
                                    SizedBox(width: isSmallScreen ? 12 : 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  notification['title']
                                                      as String,
                                                  style: TextStyle(
                                                    fontSize: titleFontSize,
                                                    fontWeight: isRead
                                                        ? FontWeight.w500
                                                        : FontWeight.bold,
                                                    color: isRead
                                                        ? Colors.black87
                                                        : theme.colorScheme
                                                            .primary,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              SizedBox(
                                                  width: isSmallScreen ? 4 : 8),
                                              Text(
                                                _formatTimestamp(timestamp),
                                                style: TextStyle(
                                                  fontSize: timeFontSize,
                                                  color: Colors.grey.shade600,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                              height: isSmallScreen ? 4 : 6),
                                          Text(
                                            notification['message'] as String,
                                            style: TextStyle(
                                              fontSize: messageFontSize,
                                              color: Colors.black87
                                                  .withOpacity(0.8),
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (!isRead)
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: isSmallScreen ? 4 : 8),
                                        child: Container(
                                          width: badgeSize,
                                          height: badgeSize,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: theme.colorScheme.primary,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
