import 'package:flutter/material.dart';
import 'package:jai_kisan/pages/login_page.dart';
import 'package:jai_kisan/pages/register_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {

  //initially showing the login page
  bool showLoginPage = true;

  //toggle between the login and register page
  void togglePage() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }


  @override
  Widget build(BuildContext context) {

   //if showLoginPage is true, show the login page, else show the register page 
    if(showLoginPage){
      return LoginPage(
        onTap: togglePage,
      );
    }
      
    else{
      return RegisterPage(
        onTap: togglePage,
      );
    }
  }
}
