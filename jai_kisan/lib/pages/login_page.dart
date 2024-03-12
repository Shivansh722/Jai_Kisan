import 'package:flutter/material.dart';
import 'package:jai_kisan/components/arc_draw.dart';
import 'package:jai_kisan/components/my_button.dart';
import 'package:jai_kisan/components/textfield.dart';
import 'package:jai_kisan/components/square_tile.dart';
import 'package:jai_kisan/authentication/auth_service.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final void Function()? onTap;

  LoginPage({Key? key, required this.onTap});

  void login(BuildContext context) async {
    final authService = AuthService();

    try {
      await authService.signInWithEmailAndPassword(
        _emailController.text,
        _pwController.text,
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double arcDiameter = screenWidth * 1.2;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: -arcDiameter / 1.5,
              child: MyArc(
                diameter: arcDiameter,
                color: Colors.green,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10), // Adjust the top padding for the Image.asset
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'lib/assets/JK_logo.png',
                    width: 300,
                    height: 350,
                  ),
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "Welcome",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: " back.",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 85, 107, 47),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                    icon: Icons.email,
                    hintText: 'Email',
                    obscureText: false,
                    controller: _emailController,
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                    icon: Icons.lock,
                    hintText: 'Password',
                    obscureText: true,
                    controller: _pwController,
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        // Implement forgot password functionality here
                      },
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Forgot password?",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  MyButton(
                    text: "Login now!",
                    onTap: () => login(context),
                  ),
                  const SizedBox(height: 30),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.black,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Or continue with',
                            style: TextStyle(
                              color: Color.fromARGB(255, 38, 80, 115),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Transform.scale(
                        scale: 0.8,
                        child: SquareTile(
                          imagePath: 'lib/assets/google.png',
                        ),
                      ),
                      SizedBox(width: 25),
                      Transform.scale(
                        scale: 0.8,
                        child: SquareTile(imagePath: 'lib/assets/apple.png'),
                      )
                    ],
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?  ",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),
                      GestureDetector(
                        onTap: onTap,
                        child: Text(
                          "Register now!",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
