import 'package:animation_app/views/cart/cart_view.dart';
import 'package:animation_app/views/favorites.dart/favorite_view.dart';
import 'package:animation_app/views/search/search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../profile/profile_view.dart';
import 'drawer_tile.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: 288,
        height: double.infinity,
        color: Colors.white,
        child: DefaultTextStyle(
          style: const TextStyle(color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    ZoomDrawer.of(context)!.close();
                  },
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.black,
                  )),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text("BROWSE",
                    style:
                        GoogleFonts.poppins(fontSize: 18, color: Colors.black)),
              ),
              const SizedBox(height: 10),
              SideMenuCard(
                  onPressed: () {
                    selectedIndex = 0;
                    setState(() {});
                    0.5.seconds.delay().then((value) {
                      ZoomDrawer.of(context)!.close();
                    });
                  },
                  text: 'HOME',
                  isSelected: selectedIndex == 0 ? true : false,
                  icon: Icons.home),
              const SizedBox(height: 10),
              SideMenuCard(
                  onPressed: () {
                    selectedIndex = 1;
                    setState(() {});
                    0.5.seconds.delay().then((value) {
                      ZoomDrawer.of(context)!.close();
                    });
                    0.5.seconds.delay().then((value) {
                      Get.to(() => ProfileView());
                    });
                  },
                  text: 'PROFILE',
                  isSelected: selectedIndex == 1 ? true : false,
                  icon: Icons.person),
              const Divider(),
              SideMenuCard(
                  onPressed: () {
                    selectedIndex = 2;
                    setState(() {});
                    0.5.seconds.delay().then((value) {
                      ZoomDrawer.of(context)!.close();
                    });
                    0.5.seconds.delay().then((value) {
                      Get.to(() =>  FavoriteView());
                    });
                  },
                  text: 'FAVORITES',
                  isSelected: selectedIndex == 2 ? true : false,
                  icon: Icons.favorite),
              const Divider(),
              SideMenuCard(
                  onPressed: () {
                    selectedIndex = 3;
                    setState(() {});
                    0.5.seconds.delay().then((value) {
                      ZoomDrawer.of(context)!.close();
                    });
                    0.5.seconds.delay().then((value) {
                      Get.to(() =>  CartView());
                    });
                  },
                  text: 'CART',
                  isSelected: selectedIndex == 3 ? true : false,
                  icon: Icons.shopping_cart),
              const Divider(),
              SideMenuCard(
                  onPressed: () {
                    selectedIndex = 4;
                    setState(() {});
                    setState(() {});
                    0.5.seconds.delay().then((value) {
                      ZoomDrawer.of(context)!.close();
                    });
                    0.5.seconds.delay().then((value) {
                      Get.to(() =>  SearchView());
                    });
                  },
                  text: 'SEARCH',
                  isSelected: selectedIndex == 4 ? true : false,
                  icon: Icons.search),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
