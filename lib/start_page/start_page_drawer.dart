import 'package:flutter/material.dart';

class StartPageDrawer extends StatelessWidget {
  const StartPageDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: const CircleAvatar(
              foregroundImage: AssetImage("assets/icon.png"),
            ),
            otherAccountsPictures: [
              IconButton(
                icon: const Icon(Icons.logout),
                tooltip: "logout",
                onPressed: () {},
                color: Colors.white,
              )
            ],
            accountName: const Text("Sumx21t"),
            accountEmail: const Text("sumx21t.dev@gmail.com"),
          ),
        ],
      ),
    );
  }
}
