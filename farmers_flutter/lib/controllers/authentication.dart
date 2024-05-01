import 'dart:convert';

import 'package:farmers/constants/constants.dart';
import 'package:farmers/pages/customer/home_page.dart';
import 'package:farmers/pages/farmers/dashboard_page.dart';
import 'package:farmers/pages/login_page.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class AuthenticationController extends GetxController {
  final isLoading = false.obs;
  final token = ''.obs;
  final username = ''.obs;
  Map<String, dynamic> userdata = {'name': '', 'username': '', 'role': ''};

  final box = GetStorage();

  Future register({
    required String name,
    required String username,
    required String email,
    required String password,
    required String role,
    required String confirmPassword,
  }) async {
    try {
      isLoading.value = true;
      var data = {
        'name': name,
        'username': username,
        'email': email,
        'password': password,
        'password_confirmation': confirmPassword,
        'role': role,
      };

      var response = await http.post(
        Uri.parse('${url}register'),
        headers: {
          'Accept': 'application/json',
        },
        body: data,
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        Get.offAll(() => LoginPage());
        Get.snackbar(
          'Success',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        isLoading.value = false;
        Get.snackbar(
          'Error',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        // print('responce from api: ' + response.body);
      }
    } catch (e) {
      isLoading.value = false;
      print('Exception details:\n $e');
    }
  }

  Future login({
    required String username,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      var data = {
        'username': username,
        'password': password,
      };

      var response = await http.post(
        Uri.parse('${url}login'),
        headers: {
          'Accept': 'application/json',
        },
        body: data,
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        Map<String, dynamic> responseJson = json.decode(response.body);
        // print('responce from api: ' + response.body);
        token.value = json.decode(response.body)['token'];
        username = json.decode(response.body)['username'];
        box.write('token', token.value);
        box.write('username', username);
        if (responseJson.containsKey('userdata')) {
          Map<String, dynamic> userDataJson = responseJson['userdata'];
          userdata = {
            'name': userDataJson['name'] ?? '',
            'username': userDataJson['username'] ?? '',
            'role': userDataJson['role'] ?? '',
          };
        }
        userdata['role'] == 'farmer'
            ? Get.offAll(() => DashboardPage(userName: username))
            : Get.offAll(() => HomePage(userName: username));
        print(username);
      } else {
        isLoading.value = false;
        Get.snackbar(
          'Failed',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        // print('responce from api: ' + response.body);
      }
    } catch (e) {
      isLoading.value = false;
      print('Exception details:\n $e');
    }
  }

  Future logout() async {
    try {
      isLoading.value = true;
      var response = await http.post(Uri.parse('${url}logout'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      });
      if (response.statusCode == 200) {
        isLoading.value = false;
        Get.offAllNamed('/login');
        //todo: return msg to user
        Get.snackbar(
          'Success',
          "Logout successful",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          icon: const Icon(Icons.check),
        );
      } else {
        isLoading.value = false;
        // print(json.decode(response.body));
      }
    } catch (e) {
      isLoading.value = false;
      print('Exception details:\n $e');
    }
  }
}
