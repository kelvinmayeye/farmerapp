import 'package:farmers/pages/register_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:farmers/controllers/authentication.dart';
import 'package:get/get.dart';
import 'package:connectivity/connectivity.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';

void main() {
  runApp(LoginApp());
}

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var sizewidth = MediaQuery.of(context).size.width;
    var sizeheight = MediaQuery.of(context).size.height;

    return GetMaterialApp(
      //using getmaterial app instead of materialapp
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Karibu FarmersApp'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Jina'),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Neno la siri'),
                obscureText: true,
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () async {
                  // Check for internet connectivity first
                  var connectivityResult =
                      await Connectivity().checkConnectivity();
                  if (connectivityResult == ConnectivityResult.none) {
                    // No internet connection, show a message or take appropriate action
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Hakuna interneti')),
                    );
                    return;
                  }

                  // Internet connection available, proceed with login
                  await _authenticationController.login(
                    username: _usernameController.text.trim(),
                    password: _passwordController.text.trim(),
                  );
                },
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(20, 14, 20, 14)),
                child: Obx(() {
                  return _authenticationController.isLoading.value
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text('Ingia');
                }),
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      CupertinoPageRoute(builder: (context) => RegisterPage()));
                },
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(20, 14, 20, 14)),
                child: const Text('Sajili akaunti'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
