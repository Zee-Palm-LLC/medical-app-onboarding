import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:animation_app/models/category_model.dart';

class CategoryCard extends StatefulWidget {
  final CategoryModel category;
  const CategoryCard({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Duration _animationDuration = const Duration(milliseconds: 300);
  final Tween<double> _tween = Tween<double>(begin: 1.0, end: 0.8);
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: _animationDuration,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      GestureDetector(
          onTap: () {
            _controller.forward().then((_) {
              _controller.reverse();
            });
          },
          child: ScaleTransition(
            scale: _tween.animate(
              CurvedAnimation(
                parent: _controller,
                curve: Curves.easeOut,
                reverseCurve: Curves.easeIn,
              ),
            ),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              child: Container(
                height: 70,
                width: 70,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: SvgPicture.asset(widget.category.image),
              ),
            ),
          )),
      const Spacer(),
      Text(widget.category.categoryName,
          style: GoogleFonts.poppins(fontSize: 15, color: Colors.black))
    ]);
  }
}
