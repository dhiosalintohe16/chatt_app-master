import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tierra_app/app/routes/app_pages.dart';
import 'package:tierra_app/app/data/models/user_model.dart';

class AuthController extends GetxController {
  //TODO: Implement AuthController

  var isSkipIntro = false.obs;
  var isAuth = false.obs;

  GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? currentUser;
  UserCredential? userCredential;
  var  user = UserModel().obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> firstInitialized() async {
    await autoLogin().then((value) {
      if (value) {
        isAuth.value = true;
      }
    });
    await skipIntro().then((value) {
      if (value) {
        isSkipIntro.value = true;
      }
    });
  }

  Future<bool> skipIntro() async {
    final box = GetStorage();
    if (box.read('skipIntro') != null || box.read('skipIntro') == true) {
      return true;
    }
    return false;
  }

  Future<bool> autoLogin() async {
    try {
      final isSignIn = await _googleSignIn.isSignedIn();
      if (isSignIn) {
        await _googleSignIn.signInSilently().then((value) => currentUser = value);
        final googleAuth = await currentUser!.authentication;

        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );

        // simpan di firebase
        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) => userCredential = value);

        print("User Credential");
        print(userCredential);

        // Masukkan Firestore
        CollectionReference users = firestore.collection('users');

        users.doc(currentUser!.email).update({
            // "photoUrl": currentUser!.photoUrl,
            "lastSignInTime": userCredential!.user!.metadata.lastSignInTime!
                .toIso8601String(),
          });

        final currUser = await users.doc(currentUser!.email).get();
        final currUserData = currUser.data() as Map<String, dynamic> ;

        user (UserModel(
          uid: currUserData["uid"],
          name: currUserData["name"],
          email: currUserData["email"],
          photoUrl: currUserData["photoUrl"],
          creationTime: currUserData["creationTime"],
          lastSignInTime: currUserData["lastSignInTime"],
          updateTime: currUserData["updateTime"],
          phoneNumber: currUserData["phoneNumber"],
        ));

        return true;
      }
      return false;
    } catch (err) {
      return false;
    }
  }

  Future<void> loginGoogle() async {
    try {
      //ini untuk menghandle kebocoran data user sebelum login
      await _googleSignIn.signOut();

      //ini untuk mendapatkan google account
      await _googleSignIn.signIn().then((value) => currentUser = value);
      print(currentUser);

      //mengecek status login
      final isSignIn = await _googleSignIn.isSignedIn();

      if (isSignIn) {
        //kondisi login berhasil
        print("Login berhasil");
        print(currentUser);

        final googleAuth = await currentUser!.authentication;

        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );

        // simpan di firebase
        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) => userCredential = value);

        print("User Credential");
        print(userCredential);

        // Simpan status user bahwa sudah pernah login dan tidak menampilkan introdction
        final box = GetStorage();
        if (box.read('skipIntro') != null) {
          box.remove('skipIntro');
        }
        box.write('skipIntro', true);

        // Masukkan Firestore
        CollectionReference users = firestore.collection('users');

        final checkuser = await users.doc(currentUser!.email).get();

        if (checkuser.data() == null) {
          users.doc(currentUser!.email).set({
            "uid": userCredential!.user!.uid,
            "name": currentUser!.displayName,
            "email": currentUser!.email,
            "phoneNumber": userCredential!.user!.phoneNumber??"",
            "photoUrl": currentUser!.photoUrl ?? "noimage",
            "creationTime":
                userCredential!.user!.metadata.creationTime!.toIso8601String(),
            "lastSignInTime": userCredential!.user!.metadata.lastSignInTime!
                .toIso8601String(),
            "updateTime": DateTime.now().toIso8601String(),
          });
        } else {
          users.doc(currentUser!.email).update({
            // "photoUrl": currentUser!.photoUrl,
            "lastSignInTime": userCredential!.user!.metadata.lastSignInTime!
                .toIso8601String(),
          });
        }

        final currUser = await users.doc(currentUser!.email).get();
        final currUserData = currUser.data() as Map<String, dynamic> ;

        user(UserModel(
          uid: currUserData["uid"],
          name: currUserData["name"],
          email: currUserData["email"],
          photoUrl: currUserData["photoUrl"],
          creationTime: currUserData["creationTime"],
          lastSignInTime: currUserData["lastSignInTime"],
          updateTime: currUserData["updateTime"],
          phoneNumber: currUserData["phoneNumber"],
        ),);

        isAuth.value = true;
        Get.offAllNamed(Routes.BOTTOM_NAV_BAR);
      } else {
        print("Maaf Login Tidak Berhasil");
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> loginFb() async {
    try {
      //ini untuk menghandle kebocoran data user sebelum login
      await _googleSignIn.signOut();

      //ini untuk mendapatkan google account
      await _googleSignIn.signIn().then((value) => currentUser = value);
      print(currentUser);

      //mengecek status login
      final isSignIn = await _googleSignIn.isSignedIn();

      if (isSignIn) {
        //kondisi login berhasil
        print("Login berhasil");
        print(currentUser);

        final googleAuth = await currentUser!.authentication;

        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );

        // simpan di firebase
        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) => userCredential = value);

        print("User Credential");
        print(userCredential);

        isAuth.value = true;
        Get.offAllNamed(Routes.HOME);
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> logout() async {
    await _googleSignIn.disconnect();
    await _googleSignIn.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }

  void detailSaya(String name,) {
    String date = DateTime.now().toIso8601String();

    //Update Firebase
    CollectionReference users = firestore.collection('users');

    users.doc(currentUser!.email).
    update({
      "name": name,
      "lastSignInTime":
          userCredential!.user!.metadata.lastSignInTime!.toIso8601String(),
          "updateTime":date ,
    });

    // Update Model
    user.update((user) {
      user!.name = name;
      user.lastSignInTime = userCredential!.user!.metadata.lastSignInTime!.toIso8601String();
      user.updateTime = date;
    });

    user.refresh();
    Get.defaultDialog(
      title: "succsess",
      middleText: "Change Profile Sucsess"
    );
  }

  void updatePhotoUrl (String url) async{
    String date = DateTime.now().toIso8601String();

    CollectionReference users = firestore.collection('users');

    await users.doc(currentUser!.email).update({
      "photoUrl" : url,
      "updatedTime" : date,
    });

//usermodel
    user.update((User) { 
      User!.photoUrl = url;
      User.updateTime = date;
    });

    user.refresh();
    
  }

}
