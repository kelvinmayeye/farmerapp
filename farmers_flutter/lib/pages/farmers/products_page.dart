import 'dart:convert';
import 'dart:ui';
import 'package:get_storage/get_storage.dart';
import 'package:farmers/pages/data/products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:farmers/constants/constants.dart';
import 'package:farmers/pages/farmers/add_product_page.dart';

class ProductsPage extends StatelessWidget {
  final box = GetStorage();

  ProductsPage({super.key});

  Future<List<Product>> fetchProducts() async {
    var data = {
      'username': box.read('username'),
    };

    final response = await http.post(
      Uri.parse('${url}getProducts'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      },
      body: data,
    );

    if (response.statusCode == 200) {
      dynamic responseData = jsonDecode(response.body);

      if (responseData['farmer_products'] is List) {
        // Handle if 'farmer_products' is a List
        List<dynamic> productsJson = responseData['farmer_products'];
        return productsJson.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Unexpected response format');
      }
    } else {
      Get.snackbar(
        'Failed',
        json.decode(response.body)['message'] ?? 'Unknown error',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Product>>(
        future: fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products available'));
          } else {
            List<Product> products = snapshot.data!;
            return GridView.builder(
              itemCount: products.length,
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.85,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
              ),
              itemBuilder: (context, index) {
                return Container(
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      image: AssetImage('assets/seeds.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Text(
                          products[index]
                              .name
                              .toString(), // Display product name
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color.fromRGBO(82, 170, 94, 1.0),
        onPressed: () {
          Navigator.of(context).pushReplacement(
              CupertinoPageRoute(builder: (context) => const AddProductPage()));
        },
        label: const Text('Product'),
        icon: const Icon(Icons.add, color: Colors.white, size: 25),
      ),
    );
  }
}
