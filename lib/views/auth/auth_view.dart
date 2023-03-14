import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/constants.dart';
import 'components/custom_flat_button.dart';
import 'login_view.dart';
import 'register_view.dart';

class WelcomePageView extends StatelessWidget {
  const WelcomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: 'd',
                    style: GoogleFonts.portLligatSans(
                      textStyle: Theme.of(context).textTheme.headline1,
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    children: const [
                      TextSpan(
                        text: 'ev',
                        style: TextStyle(color: Colors.black, fontSize: 30),
                      ),
                      TextSpan(
                        text: 'rnz',
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ])),
            const SizedBox(height: 40),
            Text(
              'Quick login with Touch ID',
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 17),
            ),
            const SizedBox(height: 20),
            const Icon(Icons.fingerprint, size: 90, color: Colors.white),
            const SizedBox(height: 20),
            Text(
              'Touch ID',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 15,
                decoration: TextDecoration.underline,
              ),
            ),
            const Spacer(),
            CustomFlatButton(
                text: 'Login',
                color: MyColors.kPrimaryColor,
                textColor: Colors.white,
                onTap: () {
                  Get.to(() => LoginPageView());
                }),
            const SizedBox(height: 20),
            CustomFlatButton(
                text: 'Register',
                color: Colors.white,
                textColor: MyColors.kPrimaryColor,
                onTap: () {
                  Get.to(() => SignUpView());
                }),
            const SizedBox(height: 30)
          ],
        ),
      ),
    );
  }
}
