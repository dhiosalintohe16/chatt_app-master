import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_cli/common/utils/json_serialize/json_ast/json_ast.dart';
import 'package:tierra_app/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tierra_app/app/controllers/auth_controller.dart';
import '../controllers/detail_saya_controller.dart';

class DetailSayaView extends GetView<DetailSayaController> {
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    controller.emailC.text = authC.user.value.email!;
    controller.nameC.text = authC.user.value.name!;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
              )),
          title: Text(
            'Informasi Pribadi',
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
        backgroundColor: const Color(0XFFFFFFFF),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: SafeArea(
              child: Expanded(
                child: Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: Get.height * 0.2,
                        child: Stack(children: [
                          GetBuilder<DetailSayaController>(
                              builder: (controller) => controller
                                          .PickedImage !=
                                      null
                                  ? ClipRRect(
                                      child: Container(
                                      width: 150,
                                      height: 150,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(200),
                                        image: DecorationImage(
                                          image: FileImage(File(controller
                                              .PickedImage!.path)),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ))
                                  : Obx(() => ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(200),
                                        child: Container(
                                          width: 150,
                                          height: 150,
                                          child: Image.network(
                                            authC.user.value.photoUrl!,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ))),
                          SizedBox(
                            height: 10,
                          ),
                          // ContainerProfile(),
                          Positioned(
                              bottom: 30,
                              right: 2,
                              child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Color(0xFF008269),
                                  child: IconButton(
                                    onPressed: () =>
                                        controller.PickProfile(),
                                    icon: Icon(
                                      Icons.photo_camera,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                  )))
                        ]),
                      ),
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
                      TextField(
                        enabled: false,
                        controller: controller.emailC,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 15,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      TextField(
                        controller: controller.nameC,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          labelText: "Nama",
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color(0xFF008269),
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 15,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.08,
                      ),
                      Container(
                        width: Get.width * 0.4,
                        height: Get.height * 0.05,
                        child: ElevatedButton(
                          onPressed: () {
                            controller
                                .upload(authC.user.value.uid!)
                                .then((HasilKembalian) {
                              if (HasilKembalian != null) {
                                authC.updatePhotoUrl(HasilKembalian);
                              }
                            });
                            authC.detailSaya(
                              controller.nameC.text,
                            );
                          },
                          child: Text(
                            "Simpan",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF008269),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ));
  }
}



// class ContainerProfile extends StatelessWidget {
//   ContainerProfile({
//     Key? key,
//   }) : super(key: key);
//   final authC = Get.find<AuthController>();

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => Center(
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(200),
//           child: Container(
//             width: 150,
//             height: 150,
//             child: authC.user.value.photoURL! == "noimage"
//                 ? Image.asset(
//                     "assets/icons/profile.png",
//                     fit: BoxFit.cover,
//                   )
//                 : Image.network(
//                     authC.user.value.photoURL!,
//                     fit: BoxFit.cover,
//                   ),
//           ),
//         ),
//       ),
//     );
//   }
// }
