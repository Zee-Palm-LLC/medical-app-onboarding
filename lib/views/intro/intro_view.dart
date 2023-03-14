import 'package:animation_app/data/constants.dart';
import 'package:animation_app/models/intro_model.dart';
import 'package:animation_app/views/auth/auth_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'components/animated_widget.dart';
import 'components/custom_buttons.dart';

class IntroductionPageView extends StatefulWidget {
  const IntroductionPageView({Key? key}) : super(key: key);

  @override
  State<IntroductionPageView> createState() => _IntroductionPageViewState();
}

class _IntroductionPageViewState extends State<IntroductionPageView> {
  PageController pageController = PageController(initialPage: 0);
  int currentIndex = 0;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          flex: 3,
          child: PageView.builder(
            controller: pageController,
            itemCount: listOfItems.length,
            onPageChanged: (newIndex) {
              setState(() {
                currentIndex = newIndex;
              });
            },
            physics: const BouncingScrollPhysics(),
            itemBuilder: ((context, index) {
              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(15, 40, 15, 10),
                    width: Get.width,
                    height: Get.height / 2.5,
                    child: CustomAnimatedWidget(
                      index: index,
                      delay: 100,
                      child: Image.asset(listOfItems[index].img),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: CustomAnimatedWidget(
                        index: index,
                        delay: 300,
                        child: Text(
                          listOfItems[index].title,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              color: Colors.black, fontSize: 26),
                        ),
                      )),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: CustomAnimatedWidget(
                      index: index,
                      delay: 500,
                      child: Text(
                        listOfItems[index].subTitle,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontSize: 17, fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SmoothPageIndicator(
                controller: pageController,
                count: listOfItems.length,
                effect: const ExpandingDotsEffect(
                  spacing: 6.0,
                  radius: 10.0,
                  dotWidth: 10.0,
                  dotHeight: 10.0,
                  expansionFactor: 3.8,
                  dotColor: Colors.grey,
                  activeDotColor: MyColors.kPrimaryColor,
                ),
                onDotClicked: (newIndex) {
                  setState(() {
                    currentIndex = newIndex;
                    pageController.animateToPage(newIndex,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease);
                  });
                },
              ),
              const Spacer(),
              currentIndex == 2
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: PrimaryButton(
                        onTap: () {
                          Get.to(() => AuthWrapper());
                        },
                        text: 'Get Started',
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: PrimaryButton(
                        onTap: () {
                          setState(() {
                            pageController.animateToPage(2,
                                duration: const Duration(milliseconds: 1000),
                                curve: Curves.fastOutSlowIn);
                          });
                        },
                        text: 'Skip',
                      ),
                    ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    ));
  }
}
