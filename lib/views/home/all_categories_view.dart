// import 'package:animation_app/models/category_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';

// import 'components/category_card.dart';

// class AllCategoriesView extends StatelessWidget {
//   const AllCategoriesView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: true,
//         leading: IconButton(
//           onPressed: () {
//             Get.back();
//           },
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//         ),
//         title: Text(
//           'Categories',
//           style: GoogleFonts.poppins(
//               fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600),
//         ),
//       ),
//       body: AnimationLimiter(
//         child: GridView.count(
//           childAspectRatio: 70/80,
//           padding: const EdgeInsets.all(8.0),
//           crossAxisCount: 4,
//           children: List.generate(
//             categoriesList.length,
//             (int index) {
//               return AnimationConfiguration.staggeredGrid(
//                 columnCount: 4,
//                 position: index,
//                 duration: const Duration(milliseconds: 375),
//                 child:  ScaleAnimation(
//                   scale: 0.5,
//                   child: FadeInAnimation(
//                     child: CategoryCard(category: categoriesList[index]),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
