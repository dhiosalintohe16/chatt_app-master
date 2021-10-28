import 'package:get/get.dart';

import '../controllers/komunitas_controller.dart';

class KomunitasBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KomunitasController>(
      () => KomunitasController(),
    );
  }
}
