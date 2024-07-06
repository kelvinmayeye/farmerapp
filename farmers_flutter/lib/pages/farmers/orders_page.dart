import 'package:farmers/data/products.dart';
import 'package:farmers/pages/data/products.dart';
import 'package:farmers/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _CartPageState();
}

class _CartPageState extends State<OrdersPage> {
  final cartItems = products.take(4).toList();

  @override
  Widget build(BuildContext context) {
    final total = cartItems
        .map((cartItem) => cartItem.price)
        .reduce((value, element) => value + element)
        .toStringAsFixed(2);
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ...List.generate(
              cartItems.length,
              (index) {
                final cartItem = cartItems[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: CartItem(cartItem: cartItem),
                );
              },
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total (${cartItems.length} items)"),
                Text(
                  "\$$total",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                )
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {},
                label: const Text("Accept all"),
                icon: const Icon(IconlyLight.tickSquare),
              ),
            )
          ],
        ),
      ),
    );
  }
}
