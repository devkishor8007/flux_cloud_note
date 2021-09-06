import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future anomonouslogin() async {
    return await _auth.signInAnonymously();
  }

  static logout() async {
    return await _auth.signOut();
  }
}
