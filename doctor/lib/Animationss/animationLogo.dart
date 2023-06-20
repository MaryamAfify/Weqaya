import 'package:flutter/material.dart';

class LogoAnimation extends StatefulWidget {
  @override
  _LogoAnimationState createState() => _LogoAnimationState();
}

class _LogoAnimationState extends State<LogoAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final logoSize = 200.0; // Adjust the size of the logo as needed

    return AnimatedBuilder(
      animation: _fadeAnimation,
      builder: (context, child) {
        return Center(
          child: Transform.scale(
            scale: _fadeAnimation.value, // Apply scale based on fade animation
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Image.asset(
                "images/logo.png",
                width: logoSize,
                height: logoSize,
              ),
            ),
          ),
        );
      },
    );
  }
}
