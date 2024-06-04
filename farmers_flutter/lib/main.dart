import 'package:farmers/pages/customer/home_page.dart';
import 'package:farmers/pages/farmers/dashboard_page.dart';
import 'package:farmers/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:farmers/pages/onboarding_page.dart';

void main() {
  Get.testMode = true; // Enable GetX test mode
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final token = box.read('token');
    final username = box.read('username');
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
        textTheme: GoogleFonts.nunitoTextTheme(),
      ),
      initialRoute:
          token != null ? '/home' : '/', // Set initial route based on token
      getPages: [
        GetPage(name: '/', page: () => const OnboardingPage()),
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/home', page: () => HomePage(userName: username)),
        GetPage(
            name: '/farmerdashboard',
            page: () => DashboardPage(userName: username)),
      ],
    );
  }
}
