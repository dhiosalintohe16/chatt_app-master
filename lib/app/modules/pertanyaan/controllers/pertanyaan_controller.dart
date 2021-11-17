import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tierra_app/app/controllers/auth_controller.dart';

class PertanyaanController extends GetxController {
  late ImagePicker imagePicker;
  final authC = Get.find<AuthController>();
  XFile? PickedImage = null;

  FirebaseStorage storage = FirebaseStorage.instance;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final CollectionReference chats =
      FirebaseFirestore.instance.collection("Chats");
  late String isiChat;

  getPertanyaan(isiChat) {
    this.isiChat = isiChat;
  }


Future<void> upload() async {
  FirebaseFirestore.instance.collection('komunitas').doc().set({
    'nama' : authC.user.value.name,
    'isiChat' : isiChat,
    'lasttime' : DateTime.now().millisecondsSinceEpoch,
    'postlike' : 16,
    'postcomment' : 16,

  });
}

  // Future<String?> upload() async {
  //   uploadfto();
  //   DocumentReference documentReference =
  //       FirebaseFirestore.instance.collection("Chats").doc(isiChat);

  //   Map<String, dynamic> chat = {
  //     "isiChat": isiChat,
  //     "nama": authC.user.value.name,
  //     "lasttime": DateTime.now().toIso8601String(),
  //     "image": null
  //   };

  //   documentReference.set(chat).whenComplete(() {
  //     print("succes");
  //   });
  // }

  void uploadfto() async {
    Reference StorageRef = storage.ref("chats/image");
    File file = File(PickedImage!.path);

    try {
      final fileupload = await StorageRef.putFile(file);
      print(fileupload);
      final downfto = await StorageRef.getDownloadURL();
      print(downfto);
      
      
    } catch (err) {
      print(err);
      
    }
  }

  void tmbhfto(String url) {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Chats").doc(isiChat);

    Map<String, dynamic> chat = {"image": url};

    documentReference.set(chat).whenComplete(() {
      print("update");
    });
  }

  void ResetImage() {
    PickedImage = null;

    update();
  }

  void PickGaleri() async {
    try {
      final GaleriImage =
          await imagePicker.pickImage(source: ImageSource.gallery);

      if (GaleriImage != null) {
        print(GaleriImage.name);
        print(GaleriImage.path);
        PickedImage = GaleriImage;
        update();
      }
    } catch (err) {
      print(err);
      PickedImage = null;
      update();
    }
  }

  void PickCamera() async {
    try {
      final GaleriImage =
          await imagePicker.pickImage(source: ImageSource.camera);

      if (GaleriImage != null) {
        print(GaleriImage.name);
        print(GaleriImage.path);
        PickedImage = GaleriImage;
        update();
      }
    } catch (err) {
      print(err);
      PickedImage = null;
      update();
    }
  }

  void onInit() {
    imagePicker = ImagePicker();
    super.onInit();
  }

  //TODO: Implement PertanyaanController

}
