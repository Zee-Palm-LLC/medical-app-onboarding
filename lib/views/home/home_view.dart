import 'package:animation_app/controllers/user_controller.dart';
import 'package:animation_app/models/user_model.dart';
import 'package:animation_app/views/home/components/category_card.dart';
import 'package:animation_app/views/home/components/custom_animated_text.dart';
import 'package:animation_app/views/search/search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/admin_controller.dart';
import 'all_course_view.dart';
import 'category_courses.dart';
import 'components/custom_icon_button.dart';
import 'components/search_field.dart';
import 'components/suggested_courses_card.dart';
import 'course_detail_page.dart';

class HomeView extends StatelessWidget {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  UserController uc = Get.find<UserController>();
  AdminController ac = Get.put(AdminController());

  double _progress1 = 0.2;
  double _progress2 = 0.8;
  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: _key,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              ZoomDrawer.of(context)!.open();
            },
            icon: const Icon(Icons.menu, color: Colors.black),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome Back!',
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              Obx(() {
                UserModel user = uc.user!;
                return CustomAnimatedText(
                  name: user.fullName!,
                );
              })
            ],
          ),
          actions: [
            Obx(() {
              UserModel user = uc.user!;
              return user.profilePic != ''
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(user.profilePic!))
                  : CircleAvatar(
                      backgroundColor: Colors.grey.withOpacity(0.4),
                      child: const Icon(Icons.person),
                    );
            }),
            const SizedBox(width: 10)
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => SearchView());
                        },
                        child: CustomSearchField(
                          controller: TextEditingController(),
                          onChanged: (value) {},
                          isdiabled: false,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    BouncingButton(
                      onTap: () {
                        Get.to(() => SearchView());
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Text(
                      "Categories",
                      style: GoogleFonts.poppins(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        // Get.to(() => const AllCategoriesView());
                      },
                      child: const Text(
                        "See All",
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 110,
                child: Obx(() {
                  return ac.categories!.isEmpty
                      ? Center(
                          child: Text("No Categories"),
                        )
                      : ListView.separated(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.only(left: 24),
                          itemBuilder: (ctx, index) {
                            return CategoryCard(
                              category: ac.categories![index],
                              onTap: () {
                                Get.to(() => CategoryCourseView(
                                      category: ac.categories![index],
                                    ));
                              },
                            );
                          },
                          separatorBuilder: (ctx, index) =>
                              const SizedBox(width: 10),
                          itemCount: ac.categories?.length ?? 0);
                }),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Text(
                      "All Courses",
                      style: GoogleFonts.poppins(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Get.to(() => AllCourseView());
                      },
                      child: const Text(
                        "See All",
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    )
                  ],
                ),
              ),
              Obx(() {
                if (uc.courses!.isEmpty) {
                  return Center(
                    child: Text("No Courses"),
                  );
                }
                return SizedBox(
                  height: 300,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(left: 24),
                      itemBuilder: (ctx, index) {
                        return Obx(() {
                          final isFavorite = uc.favorites.any((favorite) =>
                              favorite.id == uc.courses![index].id);
                          return SuggestedCourseCard(
                            courses: uc.courses![index],
                            index: index,
                            onTap: () {
                              Get.to(() => CourseDetailPage(
                                    course: uc.courses![index],
                                    isBought: false,
                                  ));
                            },
                            isFavorite: isFavorite,
                            favoriteCallback: (bool isFavorite) async {
                              if (isFavorite) {
                                await uc.removeFavorite(uc.courses![index]);
                                return false;
                              } else {
                                await uc.addFavorite(uc.courses![index]);
                                return true;
                              }
                            },
                          );
                        });
                      },
                      separatorBuilder: (ctx, index) =>
                          const SizedBox(width: 20),
                      itemCount: uc.courses!.length),
                );
              }),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Text(
                      "Ongoing Courses",
                      style: GoogleFonts.poppins(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "See All",
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 300,
                child: Obx(() {
                  return uc.purchased!.isEmpty
                      ? Center(
                          child: Text("No Courses"),
                        )
                      : ListView.separated(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.only(left: 24),
                          itemBuilder: (ctx, index) {
                            return InkWell(
                              onTap: () {
                                Get.to(() => CourseDetailPage(
                                    course: uc.purchased![index].course,
                                    isBought: true));
                              },
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Container(
                                  height: 170,
                                  width: 270,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 170,
                                        width: double.maxFinite,
                                        alignment: Alignment.topRight,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                                image: NetworkImage(uc
                                                    .purchased![index]
                                                    .course
                                                    .thumbnail),
                                                fit: BoxFit.cover)),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(uc.purchased![index].course.title,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600)),
                                      const SizedBox(height: 10),
                                      Text("Completed",
                                          style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 10)),
                                      LinearProgressIndicator(
                                        value: uc.purchased![index]
                                                .completedValue /
                                            uc.purchased![index].totalValue,
                                        backgroundColor:
                                            Colors.grey.withOpacity(0.3),
                                      ),
                                      const SizedBox(height: 10),
                                      Text("Remaining",
                                          style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 10)),
                                      LinearProgressIndicator(
                                        value: 1-uc.purchased![index].completedValue /
                                            uc.purchased![index].totalValue,
                                        color: Colors.red,
                                        backgroundColor:
                                            Colors.grey.withOpacity(0.3),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (ctx, index) =>
                              const SizedBox(width: 20),
                          itemCount: uc.purchased?.length ?? 0);
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
