import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tierra_app/app/routes/app_pages.dart';

import '../controllers/komunitas_controller.dart';

class KomunitasView extends GetView<KomunitasController> {
  final List<Widget> myChats = List.generate(
    20,
    (index) => Expanded(
      child: Container(
        // width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: Color(0xFF008269).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Color(0xFF008269)),
                  // color: Colors.amber,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Gambar 
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset("assets/logo/bunga.png", width: 200),
                      ),
                    ),
                    SizedBox(height: 12),
                    // Text
                    Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Namanya orang ${index + 1}",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 17),
                        ),
                        Text("Tolong bantuannya, tanaman saya berlubang"),
                      ],
                    ),
                  ],
                )),
          ],
          //  ListTile(
          //   onTap: () => Get.toNamed(Routes.CHAT_ROOM),
          // leading: CircleAvatar(
          //   backgroundColor: Colors.green[100],
          //   child: Image.asset(
          //     "assets/logo/ss.png",
          //     fit: BoxFit.cover,
          //   ),
          //   radius: 30,
          // ),
          // title: Text(
          //   "Namanya orang ${index + 1}",
          //   style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
          // ),
          // subtitle: Text("Isi Pesannya"),

          // trailing: Chip(
          //   label: Text(
          //     '16',
          //     style: TextStyle(color: Colors.white),
          //   ),
          //   backgroundColor: Colors.green,
          // ),
        ),
      ),
    ),
  ).reversed.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      // backgroundColor: Color(0xFF008269).withOpacity(0.1),
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        child: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20))),
          // title: Text(""),
          // centerTitle: true,
          // titleTextStyle: TextStyle(
          //     fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
          backgroundColor: Colors.white,
          flexibleSpace: Padding(
            padding: const EdgeInsets.fromLTRB(10, 35, 10, 10),
            child: Align(
              alignment: Alignment.center,
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: Get.width * 0.03),
                    width: Get.width * 0.8,
                    height: 50,
                    child: TextField(
                      cursorColor: Color(0xFF008269),
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          hintText: "Seacrh",
                          fillColor: Colors.grey[100],
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                  color: Color(0xFF008269), width: 1))),
                    ),
                  ),
                  Container(
                    child: IconButton(
                      padding: EdgeInsets.only(left: Get.width * 0.045),
                      onPressed: () {},
                      icon: Icon(
                        Icons.notifications,
                        color: Colors.grey,
                        size: Get.width * 0.07,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        preferredSize: Size.fromHeight(90),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: myChats.length,
                  itemBuilder: (context, index) => myChats[index]),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: Get.height * 0.1),
          child: FloatingActionButton(
              onPressed: () => Get.toNamed(Routes.PERTANYAAN),
              child: Icon(Icons.add_comment),
              backgroundColor: Color(0xFF008269))),
    );
  }
}
