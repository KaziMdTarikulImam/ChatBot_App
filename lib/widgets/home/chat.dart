import 'package:flutter/material.dart';
import 'package:my_app/networks/api_service.dart';

class chat extends StatefulWidget {
  const chat({super.key});

  @override
  State<chat> createState() => _chatState();
}

class _chatState extends State<chat> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  static const String _sender = "mohsin";
  static const String _defaultMessage = "Hi";

  bool _isBotTyping = false;
  bool _defaultMessageLoaded = false;

  final List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _sendDefaultMessage();
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _sendDefaultMessage() async {
    if (_defaultMessageLoaded) return;

    _defaultMessageLoaded = true;
    _setBotTyping(true);

    try {
      final botReply = await ApiService.postChatMessage(
        endpoint: "chat",
        sender: _sender,
        message: _defaultMessage,
      );

      _addMessage(botReply, isUser: false);
    } catch (e) {
      _addMessage(
        "Sorry, I could not start the chat. Please try again.",
        isUser: false,
      );
    } finally {
      _setBotTyping(false);
      _scrollToBottom();
    }
  }

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();

    if (text.isEmpty || _isBotTyping) return;

    _messageController.clear();

    _addMessage(text, isUser: true);
    _setBotTyping(true);
    _scrollToBottom();

    try {
      final botReply = await ApiService.postChatMessage(
        endpoint: "chat",
        sender: _sender,
        message: text,
      );

      _addMessage(botReply, isUser: false);
    } catch (e) {
      _addMessage(
        "Sorry, something went wrong. Please try again.",
        isUser: false,
      );
    } finally {
      _setBotTyping(false);
      _scrollToBottom();
    }
  }

  void _addMessage(String message, {required bool isUser}) {
    if (!mounted) return;

    setState(() {
      _messages.add(
        ChatMessage(
          message: message,
          isUser: isUser,
        ),
      );
    });
  }

  void _setBotTyping(bool value) {
    if (!mounted) return;

    setState(() {
      _isBotTyping = value;
    });
  }

  void _resetChat() {
    setState(() {
      _messages.clear();
      _isBotTyping = false;
      _defaultMessageLoaded = false;
    });

    _sendDefaultMessage();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;

      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  Widget _buildMessageBubble(ChatMessage item) {
    final bool isUser = item.isUser;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          left: isUser ? 60 : 16,
          right: isUser ? 16 : 60,
          bottom: 12,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: isUser ? AppColors.primaryGreen : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),
            bottomLeft: Radius.circular(isUser ? 18 : 4),
            bottomRight: Radius.circular(isUser ? 4 : 18),
          ),
          border: Border.all(
            color: isUser ? AppColors.primaryGreen : AppColors.borderColor,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Text(
          item.message,
          style: TextStyle(
            color: isUser ? Colors.white : AppColors.darkText,
            fontSize: 14,
            height: 1.45,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildTypingBubble() {
    if (!_isBotTyping) return const SizedBox.shrink();

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(
          left: 16,
          right: 60,
          bottom: 12,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
            bottomLeft: Radius.circular(4),
            bottomRight: Radius.circular(18),
          ),
          border: Border.all(
            color: AppColors.borderColor,
          ),
        ),
        child: const Text(
          "Typing...",
          style: TextStyle(
            color: AppColors.lightText,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildInputBox() {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                minLines: 1,
                maxLines: 4,
                textInputAction: TextInputAction.send,
                textCapitalization: TextCapitalization.sentences,
                onSubmitted: (_) => _sendMessage(),
                decoration: InputDecoration(
                  hintText: "Type your message...",
                  filled: true,
                  fillColor: AppColors.backgroundColor,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  border: _inputBorder(BorderSide.none),
                  enabledBorder: _inputBorder(
                    const BorderSide(color: AppColors.borderColor),
                  ),
                  focusedBorder: _inputBorder(
                    const BorderSide(
                      color: AppColors.primaryGreen,
                      width: 1.4,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            InkWell(
              onTap: _isBotTyping ? null : _sendMessage,
              borderRadius: BorderRadius.circular(18),
              child: Container(
                height: 52,
                width: 52,
                decoration: BoxDecoration(
                  color: _isBotTyping
                      ? AppColors.primaryGreen.withOpacity(0.5)
                      : AppColors.primaryGreen,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(
                  Icons.send_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  OutlineInputBorder _inputBorder(BorderSide borderSide) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: borderSide,
    );
  }

  Widget _buildEmptyMessage() {
    if (_messages.isNotEmpty || _isBotTyping) {
      return const SizedBox.shrink();
    }

    return const Center(
      child: Text(
        "Starting chat...",
        style: TextStyle(
          color: AppColors.lightText,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final itemCount = _messages.length + (_isBotTyping ? 1 : 0);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.appBarColor,
        foregroundColor: Colors.white,
        titleSpacing: 0,
        title: const Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.smart_toy_rounded,
                color: AppColors.primaryGreen,
                size: 22,
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nexify",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Online",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: _resetChat,
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: itemCount == 0
                ? _buildEmptyMessage()
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.only(top: 16, bottom: 16),
                    itemCount: itemCount,
                    itemBuilder: (context, index) {
                      if (_isBotTyping && index == _messages.length) {
                        return _buildTypingBubble();
                      }

                      return _buildMessageBubble(_messages[index]);
                    },
                  ),
          ),
          _buildInputBox(),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String message;
  final bool isUser;

  const ChatMessage({
    required this.message,
    required this.isUser,
  });
}

class AppColors {
  static const Color primaryGreen = Color(0xff16a34a);
  static const Color appBarColor = Color(0xff0f172a);
  static const Color backgroundColor = Color(0xfff8fafc);
  static const Color borderColor = Color(0xffe2e8f0);
  static const Color darkText = Color(0xff0f172a);
  static const Color lightText = Color(0xff64748b);
}