import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:liquid_galaxy_kiss_app/screens/home_page.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Container(child: Image.asset('assets/images/newlglogo.png')),
      nextScreen: HomePage(),
      splashTransition: SplashTransition.scaleTransition,
    );
  }
}
