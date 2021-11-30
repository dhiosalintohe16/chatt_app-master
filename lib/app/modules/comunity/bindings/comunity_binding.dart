import 'package:get/get.dart';

import '../controllers/comunity_controller.dart';

class ComunityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ComunityController>(
      () => ComunityController(),
    );
  }
}
