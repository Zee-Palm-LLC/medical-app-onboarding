import 'package:animate_do/animate_do.dart';
import 'package:animation_app/views/home/components/custom_like_button.dart';
import 'package:animation_app/views/home/course_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../../controllers/user_controller.dart';
import '../../models/favorite_model.dart';

class FavoriteView extends StatelessWidget {
  final UserController uc = Get.find<UserController>();
  FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        centerTitle: true,
        title: Text(
          'Favorites',
          style: GoogleFonts.poppins(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: StreamBuilder<List<FavoriteItem>>(
        stream: uc.favoritesStream(uc.user!.id!),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final favorites = snapshot.data!;
          if (favorites.isEmpty) {
            return Center(child: Text('No favorite items yet.'));
          }
          return StaggeredGridView.countBuilder(
            padding: EdgeInsets.all(10),
            crossAxisCount: 4,
            itemCount: favorites.length,
            itemBuilder: (BuildContext context, int index) {
              return FadeInUp(
                delay: Duration(milliseconds: index * 50),
                duration: Duration(milliseconds: (index * 50) + 800),
                child: InkWell(
                  onTap: (){
                    Get.to(()=>CourseDetailPage(course: favorites[index].course));
                  },
                  child: Container(
                    alignment: Alignment.topRight,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            image:
                                NetworkImage(favorites[index].course.thumbnail),
                            fit: BoxFit.cover)),
                    child: CustomHeartIcon(
                      isFavorite: true,
                      onTap: (isLiked) async {
                        if (isLiked) {
                          final removed =
                              await uc.removeFavorite(uc.courses![index]);
                              print("Hello");
                        } else {
                          final added = await uc.addFavorite(uc.courses![index]);
                        }
                      },
                    ),
                  ),
                ),
              );
            },
            staggeredTileBuilder: (int index) =>
                StaggeredTile.count(2, index.isEven ? 4 : 2),
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
          );
        },
      ),
    );
  }
}
