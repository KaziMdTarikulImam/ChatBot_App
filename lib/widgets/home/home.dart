import 'package:flutter/material.dart';
import 'package:my_app/components/bottom_navbar.dart';
import 'package:my_app/widgets/home/chat.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> with SingleTickerProviderStateMixin {
  late AnimationController _fabAnimationController;
  late Animation<double> _fabScaleAnimation;

  int _activeIndex = 0;

  final List<Map<String, dynamic>> chatbotFeatures = [
    {
      "icon": Icons.storage_rounded,
      "title": "RAG",
      "subtitle": "Knowledge based answers",
    },
    {
      "icon": Icons.psychology_rounded,
      "title": "LLM",
      "subtitle": "Smart AI conversation",
    },
    {
      "icon": Icons.shopping_bag_outlined,
      "title": "Order Taking",
      "subtitle": "Take customer orders",
    },
    {
      "icon": Icons.question_answer_outlined,
      "title": "Question Ans",
      "subtitle": "Answer user questions",
    },
    {
      "icon": Icons.chat_rounded,
      "title": "Natural Response",
      "subtitle": "Human-like replies",
    },
    {
      "icon": Icons.receipt_long_outlined,
      "title": "Order Status",
      "subtitle": "Track order updates",
    },
 
  ];

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
      "title": "Chatbot Training",
      "message": "How to train and run the chatbot",
      "time": "Yesterday",
    },
    {
      "title": "API Integration",
      "message": "Connect chatbot API with Flutter",
      "time": "2 days ago",
    },
  ];

  @override
  void initState() {
    super.initState();

    _fabAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..repeat(reverse: true);

    _fabScaleAnimation = Tween<double>(
      begin: 0.95,
      end: 1.07,
    ).animate(
      CurvedAnimation(
        parent: _fabAnimationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _fabAnimationController.dispose();
    super.dispose();
  }

  void _startNewChat() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const chat(),
      ),
    );
  }

  void _onBottomNavTap(int index) {
    setState(() {
      _activeIndex = index;
    });

    if (index == 1) {
      _startNewChat();
      return;
    }

    if (index == 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("History page will be added later"),
          backgroundColor: Color(0xff16a34a),
        ),
      );
    }

    if (index == 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Settings page will be added later"),
          backgroundColor: Color(0xff16a34a),
        ),
      );
    }
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
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
        borderRadius: BorderRadius.circular(32),
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
          Row(
            children: [
              Container(
                height: 58,
                width: 58,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.smart_toy_rounded,
                  color: Color(0xff16a34a),
                  size: 34,
                ),
              ),

              const SizedBox(width: 14),

              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome Back",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "AI Chat Assistant",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
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
            "Chat with a smart assistant powered by LLM, RAG, natural response, order taking, question answering, and order status support.",
            style: TextStyle(
              color: Colors.white.withOpacity(0.82),
              fontSize: 14,
              height: 1.6,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 22),

          InkWell(
            onTap: _startNewChat,
            borderRadius: BorderRadius.circular(18),
            child: Container(
              height: 54,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.chat_bubble_outline_rounded,
                    color: Color(0xff16a34a),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Start Conversation",
                    style: TextStyle(
                      color: Color(0xff16a34a),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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

  Widget _buildFeatureCard(Map<String, dynamic> item) {
    return InkWell(
      onTap: _startNewChat,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: const Color(0xffe2e8f0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                color: const Color(0xffdcfce7),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                item["icon"],
                color: const Color(0xff16a34a),
                size: 24,
              ),
            ),

            const SizedBox(height: 13),

            Text(
              item["title"],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xff0f172a),
              ),
            ),

            const SizedBox(height: 6),

            Text(
              item["subtitle"],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickPromptCard(Map<String, dynamic> item) {
    return InkWell(
      onTap: _startNewChat,
      borderRadius: BorderRadius.circular(22),
      child: Container(
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
        child: Row(
          children: [
            Container(
              height: 46,
              width: 46,
              decoration: BoxDecoration(
                color: const Color(0xfff0fdf4),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                item["icon"],
                color: const Color(0xff16a34a),
                size: 24,
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item["title"],
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff0f172a),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    item["subtitle"],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
              color: Color(0xff94a3b8),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentChatItem(Map<String, dynamic> chatItem) {
    return InkWell(
      onTap: _startNewChat,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xffe2e8f0),
          ),
        ),
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
                    chatItem["title"],
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff0f172a),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    chatItem["message"],
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
              chatItem["time"],
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

  Widget _buildAnimatedFloatingButton() {
    return ScaleTransition(
      scale: _fabScaleAnimation,
      child: GestureDetector(
        onTap: _startNewChat,
        child: Container(
          margin: const EdgeInsets.only(right: 4, bottom: 10),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                height: 74,
                width: 74,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xff16a34a).withOpacity(0.16),
                ),
              ),

              Container(
                height: 62,
                width: 62,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xff16a34a),
                      Color(0xff22c55e),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.38),
                      blurRadius: 24,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.smart_toy_rounded,
                  color: Colors.white,
                  size: 31,
                ),
              ),

              Positioned(
                top: 5,
                right: 7,
                child: Container(
                  height: 14,
                  width: 14,
                  decoration: BoxDecoration(
                    color: const Color(0xff22c55e),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                ),
              ),

              Positioned(
                right: 72,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xff0f172a),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 14,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: const Text(
                    "Chat",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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
          "ChatBot AI",
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
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 110),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),

              const SizedBox(height: 28),

              _buildSectionTitle(title: "Chatbot Features"),

              const SizedBox(height: 14),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: chatbotFeatures.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 1.08,
                ),
                itemBuilder: (context, index) {
                  return _buildFeatureCard(chatbotFeatures[index]);
                },
              ),

              const SizedBox(height: 28),

              _buildSectionTitle(title: "Quick Actions"),

              const SizedBox(height: 14),

              Column(
                children: quickPrompts.map((item) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildQuickPromptCard(item),
                  );
                }).toList(),
              ),

              const SizedBox(height: 18),

              _buildSectionTitle(
                title: "Recent Chats",
                actionText: "View All",
                onTap: () {},
              ),

              const SizedBox(height: 14),

              Column(
                children: recentChats.map((chatItem) {
                  return _buildRecentChatItem(chatItem);
                }).toList(),
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: _buildAnimatedFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      bottomNavigationBar: buildBottomNavbar(
        activeIndex: _activeIndex,
        onTap: _onBottomNavTap,
      ),
    );
  }
}