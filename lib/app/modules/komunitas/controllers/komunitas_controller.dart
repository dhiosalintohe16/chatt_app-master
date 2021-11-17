import 'dart:math';


import 'package:get/get.dart';


class KomunitasController extends GetxController {
  // ignore: todo
  //TODO: Implement KomunitasController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;



  String readTimestamp(int timestamp) {
    var now = DateTime.now();
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      if (diff.inHours > 0) {
        time = diff.inHours.toString() + 'h ago';
      } else if (diff.inMinutes > 0) {
        time = diff.inMinutes.toString() + 'm ago';
      } else if (diff.inSeconds > 0) {
        time = 'now';
      } else if (diff.inMilliseconds > 0) {
        time = 'now';
      } else if (diff.inMicroseconds > 0) {
        time = 'now';
      } else {
        time = 'now';
      }
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      time = diff.inDays.toString() + 'd';
    } else if (diff.inDays > 6) {
      time = (diff.inDays / 7).floor().toString() + 'w';
    } else if (diff.inDays > 29) {
      time = (diff.inDays / 30).floor().toString() + 'm';
    } else if (diff.inDays > 365) {
      time = '${date.month} ${date.day}, ${date.year}';
    }
    return time;
  }

  

  

// void delete(){
//     DocumentReference documentReference = FirebaseFirestore.instance.collection("Chats").doc();

//     documentReference.delete().whenComplete(() {
//       print("Berhasil dihapus");
//     });
//   }

}

// class ComunityData {
//   late final String Username;
//   late final String userprofil;
//   late final int postdate;
//   late final String postcontent;
//   late final String postimage;
//   late final int postlike;
//   late final int postcoment;

//   ComunityData({
//     required this.Username,
//     required this.userprofil,
//     required this.postcoment,
//     required this.postcontent,
//     required this.postdate,
//     required this.postimage,
//     required this.postlike,
//   });
// }
