import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final IconData? icon;

  const MyTextField({
    Key? key,
    this.icon,
    required this.hintText,
    required this.obscureText,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.secondary,//color of the border
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.secondary,// color of the border
            ),
          ),
          fillColor: Theme.of(context).colorScheme.background,// color of the text field
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.secondary,// color of the hint text
          ),
          prefixIcon: icon != null
              ? Icon(
                  icon,
                  color: Theme.of(context).colorScheme.secondary,// color of the icon
                )
              : null,
        ),
      ),
    );
  }
}
