import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {
      'isUser': false,
      'message': 'Hello! Apakah ada yang bisa saya bantu?',
      'time': DateTime.now().subtract(const Duration(minutes: 5)),
    },
  ];
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.add({
        'isUser': true,
        'message': _messageController.text.trim(),
        'time': DateTime.now(),
      });
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;

      setState(() {
        _messages.add({
          'isUser': false,
          'message': _getAutoResponse(_messageController.text.trim()),
          'time': DateTime.now(),
        });
      });

      _scrollToBottom();
    });

    _messageController.clear();
    _scrollToBottom();
  }

  String _getAutoResponse(String message) {
    final lowerCaseMessage = message.toLowerCase();
    if (lowerCaseMessage.contains('tenda') ||
        lowerCaseMessage.contains('berkemah')) {
      return 'Kami memiliki berbagai macam tenda yang tersedia untuk disewa! Yang paling populer adalah Tenda Camping Premium yang dapat menampung 4 orang dengan nyaman. Apakah Anda ingin informasi lebih lanjut tentang itu?';
    } else if (lowerCaseMessage.contains('tidur') ||
        lowerCaseMessage.contains('kantong tidur')) {
      return 'Kantong tidur kami memiliki rating untuk berbagai suhu. Untuk berkemah di musim panas, saya merekomendasikan Kantong Tidur Ultralight kami. Untuk cuaca yang lebih dingin, Anda mungkin ingin memeriksa Kantong Tidur Musim Dingin kami.';
    } else if (lowerCaseMessage.contains('harga') ||
        lowerCaseMessage.contains('biaya') ||
        lowerCaseMessage.contains('berapa')) {
      return 'Harga sewa kami bervariasi tergantung pada item dan durasi sewa. Sebagian besar tenda berkisar dari Rp25-Rp45 per hari, dengan diskon untuk sewa lebih lama. Apakah ada item tertentu yang Anda minati?';
    } else if (lowerCaseMessage.contains('halo') ||
        lowerCaseMessage.contains('hi') ||
        lowerCaseMessage.contains('hei')) {
      return 'Halo! Bagaimana saya bisa membantu Anda dengan kebutuhan peralatan berkemah Anda hari ini?';
    } else if (lowerCaseMessage.contains('terima kasih')) {
      return 'Sama-sama! Jangan ragu untuk bertanya jika Anda memiliki pertanyaan lain.';
    } else if (lowerCaseMessage.contains('kembali') ||
        lowerCaseMessage.contains('terlambat')) {
      return 'Untuk pengembalian, Anda dapat mengunjungi toko kami selama jam kerja atau menjadwalkan penjemputan. Pengembalian terlambat dikenakan biaya tambahan. Apakah Anda ingin saya membantu Anda menjadwalkan pengembalian?';
    } else if (lowerCaseMessage.contains('kerusakan') ||
        lowerCaseMessage.contains('rusak')) {
      return 'Jika peralatan rusak, harap beri tahu kami sesegera mungkin. Kerusakan kecil diharapkan, tetapi kerusakan signifikan mungkin dikenakan biaya perbaikan. Kami merekomendasikan mengambil foto kerusakan yang ada saat Anda menerima barang.';
    } else if (lowerCaseMessage.contains('paket') ||
        lowerCaseMessage.contains('bundel')) {
      return 'Kami menawarkan beberapa paket berkemah yang mencakup semua yang Anda butuhkan untuk perjalanan Anda dengan harga diskon. Paket Camping Akhir Pekan kami populer untuk perjalanan singkat, sementara Bundel Camping Keluarga sangat cocok untuk kelompok yang lebih besar. Apakah Anda ingin detail tentang paket tertentu?';
    } else if (lowerCaseMessage.contains('pengiriman') ||
        lowerCaseMessage.contains('penjemputan')) {
      return 'Kami menawarkan opsi penjemputan di toko kami dan pengiriman. Pengiriman tersedia dalam radius 30 mil dengan biaya Rp10. Apakah Anda ingin menjadwalkan pengiriman atau penjemputan?';
    } else {
      return 'Terima kasih atas pesan Anda. Saya akan dengan senang hati membantu pertanyaan Anda. Bisakah Anda memberikan lebih banyak detail tentang peralatan berkemah yang Anda cari?';
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final bool isSmallScreen = size.width < 360;
    final double horizontalPadding = size.width < 600 ? 12.0 : 16.0;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: isSmallScreen ? 60 : null,
        leadingWidth: isSmallScreen ? 30 : 40,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: const AssetImage('assets/images/admin.png'),
              radius: isSmallScreen ? 16 : 18,
            ),
            SizedBox(width: isSmallScreen ? 8 : 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Live Assistant',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontSize: isSmallScreen ? 15 : 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Usually responds within 10 minutes',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade600,
                      fontSize: isSmallScreen ? 10 : 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline, size: isSmallScreen ? 22 : 24),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('About Customer Support'),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Our customer support is available:',
                          style: theme.textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 8),
                        Text('• Monday to Friday: 9 AM - 8 PM'),
                        Text('• Saturday: 10 AM - 6 PM'),
                        Text('• Sunday: 12 PM - 5 PM'),
                        const SizedBox(height: 16),
                        Text(
                          'For urgent matters outside these hours, please email us at support@campingrental.com',
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Close'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: isSmallScreen ? 12 : 16,
              ),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessageBubble(message, theme, isSmallScreen);
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: isSmallScreen ? 6 : 8,
            ),
            color: Colors.grey.shade100,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildQuickResponseChip(
                      'Bagaimana Cara saya mengembalikan barang?',
                      isSmallScreen),
                  _buildQuickResponseChip(
                      'Ada bundle apa saja ya yang tersedia?', isSmallScreen),
                  _buildQuickResponseChip(
                      'Bagaimana cara pemesanan?', isSmallScreen),
                  _buildQuickResponseChip(
                      'Ada paket camping keluarga?', isSmallScreen),
                  _buildQuickResponseChip(
                      'Berapa harga sewa tenda?', isSmallScreen),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: isSmallScreen ? 12 : 16,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.attach_file, size: isSmallScreen ? 22 : 24),
                  padding: EdgeInsets.all(isSmallScreen ? 8 : 12),
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => Container(
                        padding: EdgeInsets.all(horizontalPadding),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: const Icon(Icons.photo),
                              title: const Text('Photo'),
                              onTap: () {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Photo attachment coming soon'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.camera_alt),
                              title: const Text('Camera'),
                              onTap: () {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Camera attachment coming soon'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.location_on),
                              title: const Text('Location'),
                              onTap: () {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Location attachment coming soon'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(width: isSmallScreen ? 4 : 8),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    style: TextStyle(fontSize: isSmallScreen ? 14 : 16),
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      hintStyle: TextStyle(fontSize: isSmallScreen ? 14 : 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      isDense: isSmallScreen,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: isSmallScreen ? 6 : 8,
                      ),
                    ),
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                SizedBox(width: isSmallScreen ? 4 : 8),
                CircleAvatar(
                  radius: isSmallScreen ? 16 : 20,
                  backgroundColor: theme.colorScheme.primary,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: isSmallScreen ? 16 : 20,
                    ),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickResponseChip(String text, bool isSmallScreen) {
    return Padding(
      padding: EdgeInsets.only(right: isSmallScreen ? 6.0 : 8.0),
      child: ActionChip(
        label: Text(
          text,
          style: TextStyle(fontSize: isSmallScreen ? 11 : 13),
          overflow: TextOverflow.ellipsis,
        ),
        padding: EdgeInsets.all(isSmallScreen ? 4 : 8),
        onPressed: () {
          _messageController.text = text;
          _sendMessage();
        },
      ),
    );
  }

  Widget _buildMessageBubble(
      Map<String, dynamic> message, ThemeData theme, bool isSmallScreen) {
    final isUser = message['isUser'] as bool;
    final double avatarRadius = isSmallScreen ? 14 : 16;
    final double fontSize = isSmallScreen ? 13 : 14;
    final double timeSize = isSmallScreen ? 9 : 10;
    final double bubblePaddingH = isSmallScreen ? 12 : 16;
    final double bubblePaddingV = isSmallScreen ? 10 : 12;

    return Padding(
      padding: EdgeInsets.only(bottom: isSmallScreen ? 12.0 : 16.0),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) ...[
            CircleAvatar(
              backgroundImage: const AssetImage('assets/images/admin.jpg'),
              radius: avatarRadius,
            ),
            SizedBox(width: isSmallScreen ? 6 : 8),
          ],
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: bubblePaddingH,
                vertical: bubblePaddingV,
              ),
              decoration: BoxDecoration(
                color: isUser ? theme.colorScheme.primary : Colors.white,
                borderRadius: BorderRadius.circular(16).copyWith(
                  bottomLeft: isUser
                      ? const Radius.circular(16)
                      : const Radius.circular(0),
                  bottomRight: isUser
                      ? const Radius.circular(0)
                      : const Radius.circular(16),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message['message'] as String,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isUser ? Colors.white : Colors.black87,
                      fontSize: fontSize,
                    ),
                  ),
                  SizedBox(height: isSmallScreen ? 2 : 4),
                  Text(
                    _formatTime(message['time'] as DateTime),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: isUser
                          ? Colors.white.withOpacity(0.7)
                          : Colors.grey.shade600,
                      fontSize: timeSize,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isUser) SizedBox(width: isSmallScreen ? 6 : 8),
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
