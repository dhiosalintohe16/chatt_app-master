import 'package:get/get.dart';

import '../controllers/detail_saya_controller.dart';

class DetailSayaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailSayaController>(
      () => DetailSayaController(),
    );
  }
}
