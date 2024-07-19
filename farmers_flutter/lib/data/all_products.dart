import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:farmers/constants/constants.dart';

class AllProduct {
  String? name;
  String? qty;
  int? price;
  String? location;
  String? image;

  AllProduct({this.name, this.qty, this.price, this.location, this.image});

  AllProduct.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    qty = json['qty'];
    price = json['price'];
    location = json['location'];
    image = json['image'];
  }
}

Future<AllProduct?> fetchProduct() async {
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    print('Response from API: ' + response.body);

    // If the server returns a 200 OK response, parse the JSON
    return AllProduct.fromJson(jsonDecode(response.body));
  } else {
    print('Response from API: ' + response.body);

    // If the server does not return a 200 OK response, throw an exception
    throw Exception('Failed to load product');
  }
}

// Define the products list
List<AllProduct> products = [
  AllProduct(name: "Apple", qty: "10kg", price: 100, location: "Farm A"),
  AllProduct(name: "Banana", qty: "5kg", price: 50, location: "Farm B"),
  AllProduct(name: "Carrot", qty: "20kg", price: 200, location: "Farm C"),
];
