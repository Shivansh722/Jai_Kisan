import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:jai_kisan/pages/onboarding_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 5), () {
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
            Center(
              child: Image.asset(
                'lib/assets/JK_logo.png',
                width: 500,
                height: 400,
              ),
            ),
            const SizedBox(height: 100),
            Lottie.asset(
              'lib/assets/loading.json',
              width: 300,
              height: 200,
            ),
            const SizedBox(height: 10),
           const Padding(
              padding:  EdgeInsets.all(8.0),
              child:  Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'powered by Grow Green',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 46, 107, 42),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
