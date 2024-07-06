import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:farmers/constants/constants.dart';

class Product {
  String? name;
  String? qty;
  int? price;
  String? location;
  String? image;

  Product({this.name, this.qty, this.price, this.location});

  Product.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    qty = json['qty'];
    price = json['price'];
    location = json['location'];
  }
}

Future<Product?> fetchProduct() async {
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    print('responce from api: ' + response.body);

    // If the server returns a 200 OK response, parse the JSON
    return Product.fromJson(jsonDecode(response.body));
  } else {
    print('responce from api: ' + response.body);

    // If the server does not return a 200 OK response, throw an exception
    throw Exception('Failed to load post');
  }
}
