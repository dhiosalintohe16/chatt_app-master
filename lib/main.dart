import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tierra_app/app/controllers/auth_controller.dart';
import 'package:tierra_app/app/utils/splashscreen.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
 final authc = Get.put(AuthController(), permanent: true );

  @override
  Widget build(BuildContext context) {
        
        // return  GetMaterialApp(
        //   initialRoute: Routes.COMUNITY,
        //   getPages:AppPages.routes,
        // );

        
        return FutureBuilder(
            future:authc.firstInitialized(),
            builder: (context, snapshot){
              if (snapshot.connectionState == ConnectionState.done) {
                return Obx(() => GetMaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: "Tierra",
                  initialRoute: authc.isSkipIntro.isTrue ?
                    authc.isAuth.isTrue ? 
                    Routes.BOTTOM_NAV_BAR 
                    :  Routes.LOGIN 
                  : Routes.INTODUCTION ,
                  getPages: AppPages.routes,
                 )
               );
              }

              return FutureBuilder(
                future:  Future.delayed(Duration(seconds: 3)),
                builder: (context, snapshot) => SplashScreen(),
              );
             },
            );// Otherwise, show something whilst waiting for initialization to complete
           }
          }