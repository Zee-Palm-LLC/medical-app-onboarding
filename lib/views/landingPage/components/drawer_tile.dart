import 'package:animation_app/data/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SideMenuCard extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final IconData icon;
  final bool isSelected;
  const SideMenuCard(
      {super.key,
      this.isSelected = false,
      required this.onPressed,
      required this.text,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn,
          width: isSelected ? 220 : 0,
          height: 56,
          left: 0,
          child: Container(
            width: 10,
            decoration: const BoxDecoration(
                color: MyColors.kPrimaryColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
          ),
        ),
        ListTile(
          onTap: onPressed,
          contentPadding: const EdgeInsets.only(left: 20),
          minLeadingWidth: 10,
          leading: Icon(
            icon,
            color: isSelected ? Colors.white : Colors.black,
            size: 25,
          ),
          title: Text(text,
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: isSelected ? Colors.white : Colors.black)),
        ),
      ],
    );
  }
}
