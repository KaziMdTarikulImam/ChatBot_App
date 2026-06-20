import 'package:flutter/material.dart';
import 'package:my_app/widgets/home/home.dart';

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
        curve: Curves.easeOutBack,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    _animationController.forward();
    _navigatetoscreen();
  }

  _navigatetoscreen() async {
    await Future.delayed(const Duration(milliseconds: 2000), () {});

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const home()),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildAnimatedDot({
    required double size,
    required Color color,
  }) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: color.withOpacity(0.18),
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0f172a),
      body: Stack(
        children: [
          Positioned(
            top: -80,
            right: -70,
            child: _buildAnimatedDot(
              size: 210,
              color: Colors.green,
            ),
          ),

          Positioned(
            bottom: -90,
            left: -80,
            child: _buildAnimatedDot(
              size: 230,
              color: Colors.blue,
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
                        height: 112,
                        width: 112,
                        decoration: BoxDecoration(
                          color: const Color(0xff16a34a),
                          borderRadius: BorderRadius.circular(32),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.green.withOpacity(0.35),
                              blurRadius: 32,
                              offset: const Offset(0, 14),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.chat_rounded,
                          color: Colors.white,
                          size: 62,
                        ),
                      ),

                      const SizedBox(height: 28),

                      const Text(
                        'ChatBot AI',
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        'Smart AI Chat Assistant',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(0.72),
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
              'Powered by NextIndex',
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