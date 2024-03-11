import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:jai_kisan/pages/onboarding_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 10), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const OnBoardingPage(),
        ),
      );
    });
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/assets/logo1.png',
              width: 300,
              height: 250,
            ),
            const SizedBox(height: 130),
            Lottie.asset(
              'lib/assets/loading.json',
              width: 250,
              height: 60,
            ),
            const SizedBox(height: 10),
            const Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'powered by Grow Green',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 46, 107, 42),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
