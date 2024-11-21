import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Bouncy animation using CurvedAnimation
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceOut,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen width for responsive image scaling
    final screenWidth = MediaQuery.of(context).size.width;

    Shader textGradient = const LinearGradient(
      colors: <Color>[Colors.orange, Colors.pink, Colors.purple],
    ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

    return Scaffold(
      backgroundColor: const Color(0xffad99ff),
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.scale(
              scale: _animation.value,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'lib/common/assets/smogo.png', // Replace with your image path
                    width: screenWidth *
                        0.8, // Responsive width (60% of screen width)
                    height: screenWidth * 0.8, // Keep it square
                    fit: BoxFit.contain, // Scale the image proportionally
                  ),
                  Text(
                    'Creaphur',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: screenWidth * 0.12, // Slightly larger font size
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cursive',
                      foreground: Paint()
                        ..shader = textGradient, // Gradient text effect
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black.withOpacity(0.3), // Soft shadow
                          offset: const Offset(3, 3),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
