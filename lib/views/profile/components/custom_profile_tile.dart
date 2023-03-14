import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomProfileTile extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final IconData icon;
  const CustomProfileTile(
      {super.key, required this.onTap, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        onTap: onTap,
        leading:  Icon(icon, color: Colors.grey),
        minLeadingWidth: 10,
        title: Text(
          text,
          style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey),
        ),
        trailing: const Icon(Icons.arrow_drop_down, color: Colors.grey),
      ),
    );
  }
}
