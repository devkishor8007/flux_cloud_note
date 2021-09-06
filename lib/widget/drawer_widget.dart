import 'package:flutter/material.dart';
import 'package:flux_cloud/checkerLogin.dart';
import 'package:flux_cloud/services/auth_service.dart';

class EasyDrawer extends StatelessWidget {
  const EasyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0),
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                "https://images.unsplash.com/photo-1580429361231-bd93065f3b2a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80",
                fit: BoxFit.cover,
              ),
            ),
            accountName: Text("Anonymously Account"),
            accountEmail: Text("anonymouslyaccount@kishor.com"),
          ),
          ListTile(
            title: Text("Logout"),
            onTap: () async {
              await AuthService.logout();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => CheckerLogin()),
                  (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
