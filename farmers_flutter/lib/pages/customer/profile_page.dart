import 'package:farmers/pages/customer/orders_page.dart';
import 'package:farmers/pages/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 15),
            child: CircleAvatar(
              radius: 62,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: const CircleAvatar(
                radius: 60,
                foregroundImage: NetworkImage(
                    'https://i.pinimg.com/474x/4b/5d/19/4b5d1954fbb5b6bad18f0ac25c4ab3c3.jpg'),
              ),
            ),
          ),
          Center(
            child: Text(
              "Joana Mhekela",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Center(
            child: Text(
              "test@test.com",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          const SizedBox(height: 25),
          ListTile(
            title: const Text("My orders"),
            leading: const Icon(IconlyLight.bag),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrdersPage(),
                  ));
            },
          ),
          ListTile(
            title: const Text("My Cart"),
            leading: const Icon(IconlyLight.chart),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Logout"),
            leading: const Icon(IconlyLight.logout),
            onTap: () {
              Navigator.of(context).pushReplacement(
                  CupertinoPageRoute(builder: (context) => LoginPage()));
            },
          ),
        ],
      ),
    );
  }
}
