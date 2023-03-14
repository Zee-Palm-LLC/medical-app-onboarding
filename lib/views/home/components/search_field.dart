import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSearchField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final bool isdiabled;
  const CustomSearchField(
      {super.key,
      this.isdiabled = true,
      required this.controller,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      enabled: isdiabled,
      style: GoogleFonts.poppins(fontSize: 16),
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.withOpacity(0.1),
          border: InputBorder.none,
          hintText: "Search for a Course",
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(20),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(20),
          )),
    );
  }
}
