// lib/chat_screen.dart

import 'package:flutter/material.dart';

// A simple class to hold message data
class Message {
  final String text;
  final bool isSentByMe;

  Message({required this.text, required this.isSentByMe});
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();

  // Messages are stored in a simple list in memory
  final List<Message> _messages = [
    Message(text: 'Lorem ipsum dolor sit', isSentByMe: false),
    Message(
      text: 'Lorem ipsum dolor sit amet consectetur adipiscing elit sed do',
      isSentByMe: true,
    ),
    Message(text: 'Lorem ipsum dolor sit', isSentByMe: false),
    Message(text: 'Lorem ipsum dolor sit amet', isSentByMe: true),
  ];

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      // Add the new message to the list and update the UI
      setState(() {
        _messages.add(Message(text: text, isSentByMe: true));
      });
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color lightGreen = Color(0xFFEFF6E9);
    const Color darkGreen = Color(0xFF689F38);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Support', style: TextStyle(color: Colors.black)),
          actions: [
            IconButton(
              icon: Image.asset('assets/icons/settings.png', height: 20),
              onPressed: () {},
            ),
          ],
          bottom: TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              color: lightGreen,
              border: Border(bottom: BorderSide(color: darkGreen, width: 3.0)),
            ),
            tabs: const [
              Tab(text: 'Live Chat'),
              Tab(text: 'Help'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Live Chat Tab
            Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[index];
                      return _buildMessageBubble(
                        message,
                        lightGreen,
                        darkGreen,
                      );
                    },
                  ),
                ),
                _buildMessageInputField(darkGreen),
              ],
            ),
            // Help Tab (Placeholder)
            const Center(child: Text('Help Section')),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBubble(
    Message message,
    Color lightGreen,
    Color darkGreen,
  ) {
    final isMyMessage = message.isSentByMe;
    final bubbleColor = isMyMessage ? darkGreen : lightGreen;
    final textColor = isMyMessage ? Colors.white : Colors.black87;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: isMyMessage
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (!isMyMessage) ...[
            Image.asset('assets/icons/chatBot.png', height: 20, width: 20),
            const SizedBox(width: 8),
          ],

          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14.0,
                vertical: 10.0,
              ),
              decoration: BoxDecoration(
                color: bubbleColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(30),
                  topRight: const Radius.circular(30.0),
                  bottomLeft: Radius.circular(isMyMessage ? 30.0 : 0.0),
                  bottomRight: Radius.circular(isMyMessage ? 0.0 : 30.0),
                ),
              ),
              child: Text(
                message.text,
                style: TextStyle(color: textColor, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInputField(Color darkGreen) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Ask You Questions',
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10.0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: darkGreen,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_forward, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
