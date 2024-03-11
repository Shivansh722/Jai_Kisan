import 'package:flutter/material.dart';
import 'package:jai_kisan/components/my_button.dart';
import 'package:jai_kisan/components/textfield.dart';
import 'package:jai_kisan/authentication/auth_service.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key, required this.onTap}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();
  final void Function()? onTap;

  Future<void> register(BuildContext context) async {
    final _auth = AuthService();

    if (_pwController.text == _confirmPwController.text) {
      try {
        await _auth.signUpWithEmailAndPassword(
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
    } else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Passwords don't match"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'lib/assets/JK_logo.png',
            width: 300,
            height: 250,
          ),
          Text(
            "Let's create an account for you!",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.background,
            ),
          ),
          MyTextField(
            hintText: 'Email',
            obscureText: false,
            controller: _emailController,
          ),
          const SizedBox(height: 10),
          MyTextField(
            hintText: 'Password',
            obscureText: true,
            controller: _pwController,
          ),
          const SizedBox(height: 10),
          MyTextField(
            hintText: 'Confirm Password',
            obscureText: true,
            controller: _confirmPwController,
          ),
          SizedBox(height: 10),
          MyButton(
            text: "Register now!",
            onTap: () => register(context),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account?",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  " Login now!",
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
