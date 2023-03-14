import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class CustomAnimatedText extends StatelessWidget {
  final String name;
  const CustomAnimatedText({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return TextAnimator(
      name,
      incomingEffect: WidgetTransitionEffects.incomingScaleDown(
          duration: const Duration(milliseconds: 1000)),
      style: GoogleFonts.poppins(
          fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400),
    );
  }
}
