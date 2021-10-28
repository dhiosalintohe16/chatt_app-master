import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class DetailSayaController extends GetxController {
  //TODO: Implement DetailSayaController
  late TextEditingController emailC;
  late TextEditingController nameC;
  late ImagePicker imagePicker;
  XFile ? PickedImage = null;
  

  FirebaseStorage storage = FirebaseStorage.instance;

  Future<String?> upload (String uid) async {
    Reference StorageRef =  storage.ref("$uid.png");
    File file = File(PickedImage!.path);

    try {
     final fileupload = await StorageRef.putFile(file);
      print(fileupload);
      final PhotoUrl = await StorageRef.getDownloadURL();
      ResetImage();
      return PhotoUrl;
    } catch (err){
      print(err);
      ResetImage();
      return null;
    }
  }

  void ResetImage(){
  PickedImage = null;
  
      update();
  }


  void PickProfile()async{
    try{
      final GaleriImage = 
        await imagePicker.pickImage(source: ImageSource.gallery);

      if (GaleriImage != null) {
        print(GaleriImage.name);
        print(GaleriImage.path);
        PickedImage=GaleriImage;
        update();
      }
        
    }catch (err){
      print(err);
      PickedImage = null;
      update();
    }  
  }

  final count = 0.obs;
  @override
  void onInit() {
    emailC = TextEditingController();
    nameC = TextEditingController();
    imagePicker = ImagePicker();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailC.dispose();
    nameC.dispose();
  }
  void increment() => count.value++;
}
