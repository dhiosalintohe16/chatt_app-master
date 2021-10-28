import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProfilController extends GetxController {
  
  // late TextController emailC;
  // late TextEditingController nameC;

  final count = 0.obs;
  @override
  void onInit() {
    // emailC = TextEController(text: "edelynn@gmail.com");
    // nameC = TextEditingController(text: "Edelynn");
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    // emailC.dispose();
    // nameC.dispose();
  }
  void increment() => count.value++;
}
