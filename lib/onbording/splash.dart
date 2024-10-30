import 'package:flutter/material.dart';
import 'package:login/onbording/screens/onboarding/onboarding.dart';


// import 'package:onboarding_screens_digital_cards/';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _fadeInAnimation =
        Tween<double>(begin: 0, end: 1).animate(_animationController);

    _playAnimation();
  }

  void _playAnimation() async {
    await Future.delayed(const Duration(
        seconds: 1)); // Wait for initial delay before starting the animation
    _animationController.forward(); // Start the animation
    await Future.delayed(
        const Duration(seconds: 3)); // Wait for the animation to complete
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Onboarding(screenHeight: 1000,)));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //  crossAxisAlignment: CrossAxisAlignment.,
          children: [
            FadeTransition(
              opacity: _fadeInAnimation,
              child: Image.asset(
                'logo.png',
                height: 300,
              ),
            ),
            //SizedBox(height: 270),
            FadeTransition(
              opacity: _fadeInAnimation,
              child: Text(""),
            ),
          ],
        ),
      ),
    );
  }
}
