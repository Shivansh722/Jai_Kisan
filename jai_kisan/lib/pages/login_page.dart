import 'package:flutter/material.dart';
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
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Logo
          // animated logo of a farmer
          Image.asset(
            'lib/assets/JK_logo.png',
            width: 200,
            height: 200,
          ),

          // Welcome back message
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

          // Email textfield
          MyTextField(
            icon: Icons.email,
            hintText: 'Email',
            obscureText: false,
            controller: _emailController,
          ),

          const SizedBox(height: 10),

          // Password textfield
          MyTextField(
            icon: Icons.lock,
            hintText: 'Password',
            obscureText: true,
            controller: _pwController,
          ),

          const SizedBox(height: 10),

          // Forgot password button
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
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Login button
          MyButton(
            text: "Login now!",
            
            onTap: () => login(context),
          ),

          const SizedBox(height: 30),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              children: [
                Expanded(
                  child: Divider(
                    thickness: 0.5,
                    color: Colors.grey[400],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    'Or continue with',
                    style: TextStyle(color: const Color.fromARGB(255, 255, 254, 254)),
                  ),
                ),
                Expanded(
                  child: Divider(
                    thickness: 0.5,
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Google button
              Transform.scale(
                scale: 0.8,
                child: SquareTile(
                  imagePath: 'lib/assets/google.png',
                  
                ),
              ),

              SizedBox(width: 25),

              // Apple button
              Transform.scale(
                scale: 0.8,
                child: SquareTile(imagePath: 'lib/assets/apple.png'))
            ],
          ),

          const SizedBox(height: 40),

          // Register button
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account?",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  " Register now!",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
