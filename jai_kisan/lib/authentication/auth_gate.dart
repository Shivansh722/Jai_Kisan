import 'package:flutter/material.dart';
import 'package:jai_kisan/pages/lang_page.dart';
import 'package:jai_kisan/pages/home_page_en.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jai_kisan/authentication/login_or_reg.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot) {
          //if the user is logged in
          if(snapshot.hasData){
            return const LangPage();
          }
          
            
          else{
            return const LoginOrRegister();
          }
        }

      ),
    );
  }
}

