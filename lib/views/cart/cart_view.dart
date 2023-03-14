import 'package:animation_app/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/cart_model.dart';

class CartView extends StatelessWidget {
  final UserController uc = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: StreamBuilder<Cart>(
        stream: uc.userCartStream(uc.user.id!),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('An error occurred!'),
            );
          }

          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final cartItems = snapshot.data!.items;

          if (cartItems.isEmpty) {
            return Center(
              child: Text('Your cart is empty.'),
            );
          }

          return ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final cartItem = cartItems[index];
              return ListTile(
                title: Text(cartItem.title),
                subtitle: Text(cartItem.description),
                trailing: Text('\$${cartItem.price}'),
              );
            },
          );
        },
      ),
    );
  }
}
