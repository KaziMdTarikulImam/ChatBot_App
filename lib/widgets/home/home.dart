import 'package:flutter/material.dart';
import 'package:my_app/widgets/home/chat.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  final List<Map<String, dynamic>> quickPrompts = [
    {
      "icon": Icons.lightbulb_outline,
      "title": "Ask Anything",
      "subtitle": "Get quick answers from AI",
    },
    {
      "icon": Icons.school_outlined,
      "title": "Learn Something",
      "subtitle": "Explain topics simply",
    },
    {
      "icon": Icons.edit_note_outlined,
      "title": "Write Better",
      "subtitle": "Emails, messages, ideas",
    },
    {
      "icon": Icons.code_outlined,
      "title": "Code Help",
      "subtitle": "Fix bugs and build apps",
    },
  ];

  final List<Map<String, dynamic>> recentChats = [
    {
      "title": "Flutter UI Help",
      "message": "Create a modern login screen",
      "time": "10:20 AM",
    },
    {
      "title": "Rasa Chatbot",
      "message": "How to train and run Rasa",
      "time": "Yesterday",
    },
    {
      "title": "Python Package",
      "message": "Check package vulnerability",
      "time": "2 days ago",
    },
  ];

  void _startNewChat() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('New chat clicked'),
        backgroundColor: Color(0xff16a34a),
      ),
    );

    // Later you can navigate to your chat screen here
    // Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatScreen()));
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xff0f172a),
            Color(0xff14532d),
            Color(0xff16a34a),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.25),
            blurRadius: 30,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.smart_toy_rounded,
                  color: Color(0xff16a34a),
                  size: 30,
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello there",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      "How can I help you?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          Text(
            "Start a smart conversation with your AI assistant. Ask questions, generate ideas, write content, or get coding help.",
            style: TextStyle(
              color: Colors.white.withOpacity(0.78),
              fontSize: 14,
              height: 1.6,
            ),
          ),

          const SizedBox(height: 22),

          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton.icon(
              onPressed: _startNewChat,
              icon: const Icon(Icons.chat_bubble_outline),
              label: const Text(
                "Start New Chat",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xff16a34a),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickPromptCard(Map<String, dynamic> item) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xffe2e8f0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: _startNewChat,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                color: const Color(0xffdcfce7),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                item["icon"],
                color: const Color(0xff16a34a),
                size: 24,
              ),
            ),

            const SizedBox(height: 14),

            Text(
              item["title"],
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xff0f172a),
              ),
            ),

            const SizedBox(height: 6),

            Text(
              item["subtitle"],
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentChatItem(Map<String, dynamic> chat) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xffe2e8f0),
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: _startNewChat,
        child: Row(
          children: [
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: const Color(0xfff1f5f9),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.chat_rounded,
                color: Color(0xff16a34a),
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chat["title"],
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff0f172a),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    chat["message"],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),

            Text(
              chat["time"],
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle({
    required String title,
    String? actionText,
    VoidCallback? onTap,
  }) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xff0f172a),
          ),
        ),
        const Spacer(),
        if (actionText != null)
          TextButton(
            onPressed: onTap,
            child: Text(
              actionText,
              style: const TextStyle(
                color: Color(0xff16a34a),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8fafc),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xfff8fafc),
        foregroundColor: const Color(0xff0f172a),
        title: const Text(
          'ChatBot AI',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person_outline_rounded),
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),

              const SizedBox(height: 28),

              _buildSectionTitle(title: "Quick Actions"),

              const SizedBox(height: 14),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: quickPrompts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 1.08,
                ),
                itemBuilder: (context, index) {
                  return _buildQuickPromptCard(quickPrompts[index]);
                },
              ),

              const SizedBox(height: 28),

              _buildSectionTitle(
                title: "Recent Chats",
                actionText: "View All",
                onTap: () {},
              ),

              const SizedBox(height: 14),

              Column(
                children: recentChats.map((chat) {
                  return _buildRecentChatItem(chat);
                }).toList(),
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const chat()));
        },
        backgroundColor: const Color(0xff16a34a),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_comment_rounded),
        label: const Text(
          "New Chat",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              _BottomNavItem(
                icon: Icons.home_rounded,
                label: "Home",
                active: true,
              ),
              _BottomNavItem(
                icon: Icons.chat_bubble_outline_rounded,
                label: "Chats",
                active: false,
              ),
              _BottomNavItem(
                icon: Icons.history_rounded,
                label: "History",
                active: false,
              ),
              _BottomNavItem(
                icon: Icons.settings_outlined,
                label: "Settings",
                active: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;

  const _BottomNavItem({
    required this.icon,
    required this.label,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: active ? const Color(0xff16a34a) : Colors.grey,
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: active ? FontWeight.bold : FontWeight.w600,
            color: active ? const Color(0xff16a34a) : Colors.grey,
          ),
        ),
      ],
    );
  }
}