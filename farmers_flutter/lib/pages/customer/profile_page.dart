import 'package:farmers/pages/customer/orders_page.dart';
import 'package:flutter/material.dart';
import 'package:farmers/controllers/authentication.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';

class ProfilePage extends StatelessWidget {
  final AuthenticationController _authenticationController =
      AuthenticationController();
  ProfilePage({super.key});
  final box = GetStorage();

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
                backgroundImage: AssetImage('assets/fruit.jpg'),
              ),
            ),
          ),
          Center(
            child: Text(
              '${box.read('name')}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Center(
            child: Text(
              "",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          const SizedBox(height: 25),
          ListTile(
            title: const Text("Oda zangu"),
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
            title: const Text("Kapu langu"),
            leading: const Icon(IconlyLight.chart),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Ondoka"),
            leading: const Icon(IconlyLight.logout),
            onTap: () async {
              Fluttertoast.showToast(
                  msg: "Kwaheri karibu tena",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM_RIGHT,
                  timeInSecForIosWeb: 3,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
              await Future.delayed(const Duration(seconds: 1));
              await _authenticationController.logout();
            },
          ),
        ],
      ),
    );
  }
}
