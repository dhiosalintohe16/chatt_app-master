import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class SplashScreen extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      home: Scaffold(
        backgroundColor: Color(0xFFD9F2E5),
        body: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical : 50),
                child: Container(
                  width: Get.width * 0.7,
                  height: Get.height * 0.68,
                  child:Image.asset("assets/logo/ss.png"),
                  ),
              ),
                
                Text(
                  "TIERRA",
                style: GoogleFonts.bebasNeue(
                  
                  color: Color(0xFF317046),
                  fontSize: 40,
                  letterSpacing: 10,
                  
                  
                ),
                )
                
                
                
            ],
            
          ),
          ),
        ),
      );
    }
}