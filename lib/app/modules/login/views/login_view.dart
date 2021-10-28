import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:tierra_app/app/controllers/auth_controller.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: Get.width,
                height: Get.width,
                // color: Colors.amber,
                child: Container(
                    width: Get.width,
                    height: Get.width,
                    child: Image.asset("assets/logo/bunga.png")),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              ElevatedButton(
                onPressed: () => authC.loginGoogle(),
                child: Row(
                  children: [
                    Container(
                        width: Get.width * 0.07,
                        height: Get.height * 0.055,
                        child: Image.asset("assets/logo/googw.png")),
                    SizedBox(
                      width: Get.width *0.1,
                    ),
                    Text(
                      "Sign in with Google",
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                  ],
                ),
                style:ElevatedButton.styleFrom(
                  primary: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              ElevatedButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Container(
                        padding: EdgeInsets.only(left: 5),
                        width: Get.width * 0.05,
                        height: Get.height * 0.055,
                        child: Image.asset("assets/logo/fb.png")),
                    SizedBox(
                      width: Get.width *0.095,
                    ),
                    Text(
                      "Sign in with Facebook",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue.shade900,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
