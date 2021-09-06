import 'package:flutter/material.dart';
import 'package:flux_cloud/checkerLogin.dart';
import 'package:flux_cloud/services/auth_service.dart';

class AnoLogin extends StatefulWidget {
  @override
  _AnoLoginState createState() => _AnoLoginState();
}

class _AnoLoginState extends State<AnoLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          makeStraightLine(context),
          Center(
            child: InkWell(
              onTap: () async {
                await AuthService.anomonouslogin();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => CheckerLogin()),
                    (route) => false);
              },
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.indigo,
                child: Text(
                  "go",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Theme.of(context).textTheme.bodyText2!.fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          makeStraightLine(context),
        ],
      ),
    );
  }

  Widget makeStraightLine(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.06,
        width: 10,
        color: Colors.grey,
      ),
    );
  }
}
