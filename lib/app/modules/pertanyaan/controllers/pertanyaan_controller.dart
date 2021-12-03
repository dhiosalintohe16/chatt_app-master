import 'dart:io';
import 'dart:math';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tierra_app/app/controllers/auth_controller.dart';

class PertanyaanController extends GetxController {
  late ImagePicker imagePicker;
  late String isiChat, postImageURL,reply;
  final authC = Get.find<AuthController>();
  static const chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  XFile? PickedImage = null;
  File? imageFile,file;
  late File files;

  FirebaseStorage storage = FirebaseStorage.instance;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // final CollectionReference chats =
  //     FirebaseFirestore.instance.collection("Chats");

  getPertanyaan(isiChat) {
    this.isiChat = isiChat;
  }

  getUrlfto(postImageURL) {
    this.postImageURL = postImageURL;
  }

  void uploadData() async {
    String postID = getRandomString(8) + Random().nextInt(500).toString();
    print('ini post id   $postID');
    String postImageURL;
    // File file = File(PickedImage!.path);
    if (file != null){
    postImageURL = (await uploadfto(postID: postID, postIamgeFile: file))!;
    print('ini post image urlnya $postImageURL');
    getUrlfto(postImageURL);
    } else{
      postImageURL = 'NONE';
       getUrlfto(postImageURL);

    }
    
    sendPostFB(postID); //upload ke firestore
  }

  Future<void> sendPostFB(String postID) async {
    FirebaseFirestore.instance.collection('komunitas').doc(postID).set({
      'postID' :postID,
      'nama': authC.user.value.name,
      'fotoprofil' : authC.user.value.photoUrl,
      'isiChat': isiChat,
      'lasttime': DateTime.now().millisecondsSinceEpoch,
      'postlike': 0,
      'postcomment': 0,
      'postImage': postImageURL,
    });
  }

  Future<void> jumlhCommnet(DocumentSnapshot postData)async{
    postData.reference.update({'postcomment':FieldValue.increment(1)});
  }

  Future<void> jumlhLike(DocumentSnapshot postData)async{
    
    postData.reference.update({'postlike':FieldValue.increment(1)});
  }

Future<void> replycommnet() async{

}

  Future<void> commentToPost(String toUserID,postID,commentContent) async {
    String commentID = getRandomString(8) + Random().nextInt(500).toString();
    FirebaseFirestore.instance.collection('komunitas').doc(postID).collection('comment').doc(commentID).set({
      'toUserID': toUserID,
      'commentID' : commentID,
      'postID':postID,
      'nama': authC.user.value.name,
      'fotoprofil' : authC.user.value.photoUrl,
      'isiComment': commentContent,
      'lasttimeComment': DateTime.now().millisecondsSinceEpoch,
      'commnetlike': 0,
   
      
    }
    );
  }

  Future<void> likeToPost(String postID) async {
    FirebaseFirestore.instance.collection('komunitas').doc(postID).collection('like').doc(authC.user.value.name,).set({
      
      'nama': authC.user.value.name,
      'fotoprofil' : authC.user.value.photoUrl,
      
   
      
    });
  }

  Future<String?> uploadfto(
      {required String postID, required File? postIamgeFile}) async {
    try {
      String fileName = 'images/$postID/postImage';
      Reference StorageRef = storage.ref().child(fileName);
      final fileupload = await StorageRef.putFile(postIamgeFile!);
      print(fileupload);

      String downfto = await StorageRef.getDownloadURL();
      print(downfto);
      return downfto.toString();
    } catch (err) {
      return null;
    }
  }

  void ResetImage() {
    PickedImage = null;

    update();
  }

  Future<void> PickGaleri() async {
    try {
      final GaleriImage =
          await imagePicker.pickImage(source: ImageSource.gallery);
      

      if (GaleriImage != null) {
        file = File(GaleriImage.path);
        PickedImage = GaleriImage;
        print(GaleriImage.name);
        print(GaleriImage.path);
        

        update();
      } else{
        file = null;
        PickedImage = null;
        update();
      }
    } catch (err) {
      print(err);
      
    }
    
  }

  void PickCamera() async {
    try {
      final GaleriImage =
          await imagePicker.pickImage(source: ImageSource.camera);

      if (GaleriImage != null) {
        file = File(GaleriImage.path);
        PickedImage = GaleriImage;
        print(GaleriImage.name);
        print(GaleriImage.path);
        
        update();
      } else {
        PickedImage = null;
        update();
      }
    } catch (err) {
      print(err);
    }
  }

  void onInit() {
    imagePicker = ImagePicker();
    
    super.onInit();
  }

  

  

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => chars.codeUnitAt(Random().nextInt(chars.length))));
  //TODO: Implement PertanyaanController

Future<void> pickImage() async {
    final pickedImages = await imagePicker.pickImage(source: ImageSource.gallery);
    imageFile = pickedImages != null ? File(pickedImages.path):null;
    print(pickedImages!.path);
    print(imageFile);
    
    }
  
Future<Null> pickfromCamera() async {
    final pickedImages = await 
    imagePicker.pickImage(source: ImageSource.camera);
    File? imageGaleriFile = pickedImages != null ? File(pickedImages.path):null;
    if (imageGaleriFile !=null){
      
       
      }

      
    }
  }

Future<File?> cropImage(File? image) async {
    return await ImageCropper.cropImage(
        sourcePath: image!.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        
        );
    
  }

  





