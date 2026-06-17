import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_app/widgets/auth/registration.dart';

class splash_screen extends StatefulWidget {
  const splash_screen({Key? key}) : super(key: key);

  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  Timer? _typingTimer;
  String _fullText = "Smart AI Chat Assistant";
  String _typingText = "";
  int _typingIndex = 0;
  bool _showCursor = true;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.75,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticOut,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.35),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutBack,
      ),
    );

    _animationController.forward();
    _startTypingEffect();
    _navigatetoscreen();
  }

  void _startTypingEffect() {
    _typingTimer = Timer.periodic(const Duration(milliseconds: 70), (timer) {
      if (!mounted) return;

      setState(() {
        if (_typingIndex < _fullText.length) {
          _typingText += _fullText[_typingIndex];
          _typingIndex++;
        } else {
          _showCursor = !_showCursor;
        }
      });
    });
  }

  _navigatetoscreen() async {
    await Future.delayed(const Duration(milliseconds: 2000), () {});

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => registration()),
    );
  }

  @override
  void dispose() {
    _typingTimer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  Widget _chatBubble({
    required IconData icon,
    required Color color,
    required double size,
  }) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: color.withOpacity(0.18),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.white.withOpacity(0.35),
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.18),
            blurRadius: 22,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: size * 0.45,
      ),
    );
  }

  Widget _smallDot({
    required Color color,
    required double size,
  }) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: color.withOpacity(0.45),
        shape: BoxShape.circle,
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0f172a),
      body: Stack(
        children: [
          Positioned(
            top: -85,
            right: -75,
            child: Container(
              height: 230,
              width: 230,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green.withOpacity(0.25),
              ),
            ),
          ),

          Positioned(
            bottom: -95,
            left: -85,
            child: Container(
              height: 250,
              width: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.withOpacity(0.18),
              ),
            ),
          ),

          Positioned(
            top: 115,
            left: 28,
            child: _chatBubble(
              icon: Icons.chat_bubble_outline,
              color: Colors.green,
              size: 58,
            ),
          ),

          Positioned(
            top: 185,
            right: 42,
            child: _smallDot(
              color: Colors.green,
              size: 12,
            ),
          ),

          Positioned(
            bottom: 185,
            right: 35,
            child: _chatBubble(
              icon: Icons.smart_toy_outlined,
              color: Colors.blue,
              size: 64,
            ),
          ),

          Positioned(
            bottom: 145,
            left: 52,
            child: _smallDot(
              color: Colors.white,
              size: 9,
            ),
          ),

          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 118,
                        width: 118,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xff16a34a),
                              Color(0xff22c55e),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(34),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.green.withOpacity(0.38),
                              blurRadius: 40,
                              offset: const Offset(0, 18),
                            ),
                          ],
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: 86,
                              width: 86,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.14),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const Icon(
                              Icons.chat_rounded,
                              size: 64,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 28),

                      const Text(
                        'ChatBot AI',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 0.6,
                        ),
                      ),

                      const SizedBox(height: 12),

                      SizedBox(
                        height: 28,
                        child: Text(
                          '$_typingText${_showCursor ? "|" : ""}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white.withOpacity(0.78),
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),

                      const SizedBox(height: 36),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.12),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 9,
                              width: 9,
                              decoration: BoxDecoration(
                                color: Colors.green.shade400,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.green.withOpacity(0.65),
                                    blurRadius: 12,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Preparing your conversation',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.white.withOpacity(0.68),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 38,
            left: 0,
            right: 0,
            child: Text(
              'Powered by AI Conversation',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.white.withOpacity(0.55),
              ),
            ),
          ),
        ],
      ),
    );
  }
}