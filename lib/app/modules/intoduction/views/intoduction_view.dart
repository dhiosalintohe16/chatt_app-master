import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:tierra_app/app/routes/app_pages.dart';

import '../controllers/intoduction_controller.dart';

class IntoductionView extends GetView<IntoductionController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.red[800],
        body: IntroductionScreen(
          pages: [
            PageViewModel(
              title: 'Welcome to TIERRA',
              body: "Mati tanam jadi bunga",
              image: Container(
                width: Get.width * 0.6,
                height: Get.height * 0.6,
                child: Center(
                  child: Image.asset("assets/logo/ss.png", 
                  height: Get.height * 1),
                ),
              ),
            ),
            
            PageViewModel(
              title: "Temukan teman anda",
              body: "Perbanyak teman anda karna satu msuh terlalu sedikit",
              image: Container(
                width: Get.width * 0.6,
                height: Get.height * 0.6,
                child: Center(
                  child: Image.asset("assets/logo/ss.png", height: Get.height * 1.75),
                ),
              ),
            ),
          ],
          onDone: () => Get.offAllNamed(Routes.LOGIN),
          onSkip: () => Get.offAllNamed(Routes.LOGIN),
          // When done button is press

          showSkipButton: true,
          skip: Text(
            "Skip",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          next: Text(
            "Next",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          done:
              const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
        ));
  }
}
