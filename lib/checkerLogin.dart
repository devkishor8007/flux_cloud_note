import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flux_cloud/pages/homepage.dart';
import 'package:flux_cloud/pages/login.dart';

class CheckerLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return HomePage(
              user: snapshot.data!,
            );
          } else if (snapshot.data == null) {
            return AnoLogin();
          }
          return Container();
        });
  }
}
