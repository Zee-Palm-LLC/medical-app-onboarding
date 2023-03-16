import 'package:algolia/algolia.dart';
import 'package:animation_app/models/course_model.dart';
import 'package:animation_app/views/home/course_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../services/aloglia.dart';
import '../home/components/custom_icon_button.dart';
import '../home/components/search_field.dart';

class SearchView extends StatefulWidget {
  SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();

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
          'Search',
          style: GoogleFonts.poppins(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Expanded(
                  child: CustomSearchField(
                    controller: _searchController,
                    isdiabled: true,
                    onChanged: (value) {
                      _search();
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(width: 15),
                BouncingButton(
                  onTap: () {
                    _search();
                    setState(() {});
                  },
                )
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
              child: _results.isEmpty
                  ? Center(
                      child: Text("No results found.",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600)))
                  : ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      itemBuilder: (context, index) {
                        
                        CourseModel course =
                            CourseModel.fromAlgolia(_results[index]);
                            print(_results.length);
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          onTap: () {
                            Get.to(() => CourseDetailPage(course: course));
                          },
                          leading: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                    image: NetworkImage(course.thumbnail),
                                    fit: BoxFit.cover)),
                          ),
                          title: Text(
                            course.title,
                            style: GoogleFonts.poppins(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(
                            course.description,
                            maxLines: 3,
                            style: GoogleFonts.poppins(
                                fontSize: 12, fontWeight: FontWeight.w300),
                          ),
                        );
                      },
                      separatorBuilder: (ctx, index) => Divider(),
                      itemCount: _results.length))
        ],
      ),
    );
  }

  List<AlgoliaObjectSnapshot> _results = [];
  _search() async {
    AlgoliaQuery query = AlgoliaApplication.algolia
        .index('dev-futurelearning')
        .query(_searchController.text)
        .setOffset(0)
        .setHitsPerPage(25);
    _results = (await query.getObjects()).hits;
  }

  var algolia = AlgoliaApplication();
}
