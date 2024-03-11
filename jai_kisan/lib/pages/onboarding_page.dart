import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jai_kisan/authentication/auth_gate.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const AuthGate()),
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('lib/assets/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(
      fontSize: 15.0,
    );

    var pageDecoration = PageDecoration(
      titleTextStyle: GoogleFonts.nunito(
          fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.black87),
      titlePadding: const EdgeInsets.only(top: 20.0, bottom: 5.0),
      bodyTextStyle: bodyStyle,
      bodyPadding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: const EdgeInsets.only(
        top: 90,
      ),
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      allowImplicitScrolling: true,
      autoScrollDuration: 3000,
      infiniteAutoScroll: false,
      globalFooter: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 1, 95, 101),
            foregroundColor: Colors.white,
          ),
          child: const Text(
            'Get Started',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          onPressed: () => _onIntroEnd(context),
        ),
      ),
      pages: [
        PageViewModel(
          title: "Real Time Prices",
          body:
              "Get Real time prices of crops. Get the best price for your produce.",
          image: _buildImage('tractor.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Predict the prices",
          body: "Predict the prices of crops and make informed decisions.",
          image: _buildImage('farmer1.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Simple and Easy to use",
          body:
              "Simple and easy to use interface. Get the best price for your produce.",
          image: _buildImage('farmer2.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Connect with the community",
          body:
              "Connect and talk to other farmers. Share your experiences and learn from others.",
          image: _buildImage('farmers.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "The best platform for farmers",
          bodyWidget: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Click on the button to get started", style: bodyStyle),
            ],
          ),
          decoration: pageDecoration.copyWith(
            bodyFlex: 2,
            imageFlex: 4,
            bodyAlignment: Alignment.bottomCenter,
            imageAlignment: Alignment.topCenter,
          ),
          image: _buildImage('farmer_mobile.jpg'),
          reverse: true,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: false,
      showNextButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      showDoneButton: false,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.only(bottom: 25),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
        spacing: EdgeInsets.only(right: 8),
        size: Size(15.0, 5.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(20.0, 5.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
      controlsPosition: const Position(bottom: 12.0, left: 16.0, right: 16.0),
    );
  }
}
