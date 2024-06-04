import 'dart:convert';
import 'dart:ffi';
import 'package:farmers/constants/constants.dart';
import 'package:farmers/models/product.dart';
import 'package:farmers/pages/farmers/products_page.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class ProductController extends GetxController {
  Rx<List<Product>> posts = Rx<List<Product>>([]);
  final isLoading = false.obs;
  final box = GetStorage();


  Future addProduct({
    required String name,
    required Int quatity,
    required String price,
    required String location,
    required Int farmerId,
  }) async {
    try {
      isLoading.value = true;
      var data = {
        'product_name': name,
        'quantity': quatity,
        'price': price,
        'location': location,
        'farmer_id': farmerId,
      };

      var response = await http.post(
        Uri.parse('${url}addproduct'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
        body: data,
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        Get.offAll(() => ProductsPage());
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

}