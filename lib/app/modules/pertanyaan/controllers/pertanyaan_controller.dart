import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


class PertanyaanController extends GetxController {
  late ImagePicker imagePicker;
  XFile ? PickedImage = null;
  

  FirebaseStorage storage = FirebaseStorage.instance;

  void upload (String uid) async {
    Reference StorageRef =  storage.ref("$uid.png");
    File file = File(PickedImage!.path);

    try {
     final fileupload = await StorageRef.putFile(file);
      print(fileupload);
    } catch (err){
      print(err);
    }
  }

  void ResetImage(){
  PickedImage = null;
  
      update();
  }


  void PickGaleri()async{
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
  void PickCamera()async{
    try{
      final GaleriImage = 
        await imagePicker.pickImage(source: ImageSource.camera);

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

  

  void onInit(){
    imagePicker = ImagePicker();
    super.onInit();
  }

  //TODO: Implement PertanyaanController

  
}
