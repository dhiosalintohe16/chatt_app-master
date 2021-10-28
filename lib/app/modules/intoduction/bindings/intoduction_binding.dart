import 'package:get/get.dart';

import '../controllers/intoduction_controller.dart';

class IntoductionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IntoductionController>(
      () => IntoductionController(),
    );
  }
}
