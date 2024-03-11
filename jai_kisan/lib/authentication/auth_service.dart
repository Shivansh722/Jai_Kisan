import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {

  //instance of firebase auth
  final FirebaseAuth _auth = FirebaseAuth.instance;


  //sign in with email and password
  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //sign up with email and password
  Future<UserCredential> signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = 
            await _auth.createUserWithEmailAndPassword(
              email: email,
              password: password
              
          );
          return userCredential;
        } 
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //sign in with google
  signInWithGoogle() async {
    //begin the interactive sign-in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();//question mark because it can be null

    //obtaine the auth details from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;


    //create  a new creadential

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,//access token means the user is signed in
      idToken: gAuth.idToken);//id token is the user's unique id

    //finally, sign in the user with the credential
    return await _auth.signInWithCredential(credential);
  }

  //sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  //errors 
}