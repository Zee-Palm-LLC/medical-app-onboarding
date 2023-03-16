import 'package:animation_app/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/cart_model.dart';
import '../../models/purchased_model.dart';

class CartView extends StatelessWidget {
  final UserController uc = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Cart',
            style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black)),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back, color: Colors.black)),
      ),
      body: StreamBuilder<Cart>(
        stream: uc.userCartStream(uc.user!.id!),
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
                leading: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                          image: NetworkImage(cartItem.thumbnail),
                          fit: BoxFit.cover)),
                ),
                title: Text(cartItem.title, maxLines: 1),
                subtitle: Text(
                  cartItem.description,
                  maxLines: 2,
                ),
                trailing: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25))),
                    onPressed: () async {
                      await uc.addToBoughtCollection(PurchasedCourses(
                          completedValue: 0,
                          id: '',
                          totalValue: cartItem.chapters.length.toDouble(),
                          course: cartItem,
                          purchaseDate: DateTime.now()));
                    },
                    child: Text("Pay")),
              );
            },
          );
        },
      ),
    );
  }
}
