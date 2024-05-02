import 'package:farmers/pages/farmers/orders_page.dart';
import 'package:farmers/pages/farmers/profile_page.dart';
import 'package:farmers/pages/farmers/products_page.dart';
import 'package:farmers/pages/farmers/weather_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class DashboardPage extends StatefulWidget {
  String userName;
  DashboardPage({super.key, required this.userName});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final pages = [
    const WeatherPage(),
    const ProductsPage(),
    const OrdersPage(),
    ProfilePage()
  ];
  int currentPageIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const Drawer(),
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton.filledTonal(
          onPressed: () {
            //  _scaffoldKey.currentState?.openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello ${widget.userName} 👋🏾",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text("Farmer", style: Theme.of(context).textTheme.bodySmall)
          ],
        ),
      ),
      body: pages[currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentPageIndex,
        onTap: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(IconlyLight.home),
            label: "Home",
            activeIcon: Icon(IconlyBold.home),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: "Products",
            activeIcon: Icon(Icons.shopping_bag),
          ),
          BottomNavigationBarItem(
            icon: Icon(IconlyLight.buy),
            label: "Orders",
            activeIcon: Icon(IconlyBold.buy),
          ),
          BottomNavigationBarItem(
            icon: Icon(IconlyLight.profile),
            label: "Profile",
            activeIcon: Icon(IconlyBold.profile),
          ),
        ],
      ),
    );
  }
}
