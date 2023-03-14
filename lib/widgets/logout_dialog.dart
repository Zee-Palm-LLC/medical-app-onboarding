import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LogoutDialog extends StatelessWidget {
  final VoidCallback onLogoutCallback;
  const LogoutDialog({super.key, required this.onLogoutCallback});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      contentPadding: EdgeInsets.zero,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 15),
          Text(
            "Logout",
            style: GoogleFonts.poppins(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
          ),
          const SizedBox(height: 10),
          Text(
            "Are you sure you want to logout?",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                color: Colors.grey, fontWeight: FontWeight.w300, fontSize: 14),
          ),
          const SizedBox(height: 20),
          const Divider(height: 0, color: Colors.black),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      "Cancel",
                      style: GoogleFonts.poppins(
                          color: Colors.black, fontWeight: FontWeight.w600),
                    )),
                Container(width: 1, height: 50, color: Colors.grey),
                TextButton(
                    onPressed:onLogoutCallback,
                    child: Text(
                      "Logout",
                      style: GoogleFonts.poppins(
                          color: Colors.red, fontWeight: FontWeight.w600),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
