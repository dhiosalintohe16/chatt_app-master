// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:tierra_app/app/controllers/auth_controller.dart';
import 'package:tierra_app/app/modules/pertanyaan/controllers/pertanyaan_controller.dart';
import 'package:tierra_app/app/routes/app_pages.dart';

import '../controllers/komunitas_controller.dart';

class KomunitasView extends GetView<KomunitasController> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final authC = Get.find<AuthController>();
  final control = Get.put(KomunitasController());
  

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
                            hintText: "Seacrh in community",
                            fillColor: Colors.grey[100],
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
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
        body: StreamBuilder<QuerySnapshot>(
            stream: firestore
                .collection("komunitas")
                .orderBy("lasttime", descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return LinearProgressIndicator();
              return snapshot.data!.docs.length > 0
                  ? ListView(
                      shrinkWrap: true,
                      children: snapshot.data!.docs.map(_listTile).toList(),
                    )
                  : Container(
                      color: Colors.amber,
                    );
            }),
        floatingActionButton: Padding(
            padding: EdgeInsets.only(bottom: Get.height * 0.1),
            child: FloatingActionButton(
                onPressed: () => Get.toNamed(Routes.PERTANYAAN),
                child: Icon(Icons.add_comment),
                backgroundColor: Color(0xFF008269))));
  }

  Widget _listTile(DocumentSnapshot data) {
    return Expanded(
      child: GestureDetector(
          onTap: () => Get.toNamed(Routes.CHAT_ROOM),
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: Color(0xFF008269).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Color(0xFF008269)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Obx(() => ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: 
                              Container(height: 60,width: 60,
                                child: Image.network(
                                  authC.user.value.photoUrl!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ))),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data["nama"],
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 17),
                        ),
                        Text(controller.readTimestamp(data["lasttime"]),
                          
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                            color: Colors.black87,
                          ),
                        )
                      ],
                    ), ],
                ),

                    // SizedBox(
                    //   height: 25,
                    // ),

                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: PertanyaanController().PickedImage != null ?
                        
                        
                        Image.file(File(PertanyaanController().PickedImage!.path),
                            // child: Image.network(
                            //     documentSnapshot["image"],
                            width: double.infinity,height: 150,)
                            :SizedBox(height: 10,)
                      ),
                    ),
  

                Text(
                          data["isiChat"],
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 17),
                        ),

                        SizedBox(height:8),

                       

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                           Row(
                      children: [
                        Icon(
                          Icons.favorite_border,
                          color: Colors.black,
                        ),
                        Text(
                          '${data['postlike']}',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.message_outlined,
                          color: Colors.black,
                        ),
                        Text(
                          '${data['postcomment']}',
                          // '${data.postcoment}',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ) 
                          ],
                        )
                 
                // Stack(children: [
                //   Container(
                //       margin: EdgeInsets.only(left: 400, top: 0),
                //       child: PopupMenuButton(
                //         color: Colors.black54,
                //         iconSize: 25,
                //         icon: Icon(Icons.more_vert_rounded,
                //             color: Colors.black),
                //         itemBuilder: (BuildContext context) {
                //           return menuitems
                //               .map((menuitem MenuItem) {
                //             return PopupMenuItem(
                //                 child: ListTile(
                //               leading: Icon(
                //                 MenuItem.iconVal,
                //                 size: 25,
                //                 color: Colors.white,
                //               ),
                //               title: Text(
                //                 MenuItem.menuVal,
                //                 style: TextStyle(
                //                     color: Colors.white),
                //               ),
                //             ));
                //           }).toList();
                //         },
                //         onSelected: (value) => Get.toNamed(Routes.CHAT_ROOM),
                //       )),

                // Gambar

                // ]),
               
              ],
            ),
            // ],
          )),
    );
  }
}

// class menuitem {
//   late String menuVal;
//   late IconData iconVal;

//   menuitem(this.menuVal, this.iconVal);
// }

// final List<menuitem> menuitems = [menuitem("Delete", Icons.delete)];





// return Row(
                  //   children: <Widget> [
                  //     Expanded(child: Text(documentSnapshot["isiChat"])),
                  //     Expanded(child: Text(documentSnapshot["nama"]))
                  //   ],
                  // );

// Container(
              // color: Colors.amber,
              // padding: EdgeInsets.only(top: 0,right: Get.width*0.8),
              // child: PopupMenuButton(icon: Icon(Icons.more_vert_rounded,color: Colors.white),
              //   itemBuilder: (BuildContext context){
              //     return menuitems.map((menuitem MenuItem) {
              //       return PopupMenuItem(child: ListTile(
              //         leading: Icon(MenuItem.iconVal,size: 20,color: Colors.white,),
              //         title: Text(MenuItem.menuVal,style: TextStyle(color: Colors.white),),
              //       ));
              //     }).toList();
              //   },
              // )),

    // SafeArea(
      //   child: Column(
      //     children: [

      // Expanded(child: ListView.builder(
      //           itemCount: myChats.length,
      //           itemBuilder: (context,index)=>myChats[index]))

      // Expanded(
      //   child: Obx(
      //     ()=> ListView.builder(
      //       itemCount: controller.chatStream.length,
      //       itemBuilder: (context, index){

      //       })
      //   ))
      // Expanded(

      //   child: StreamBuilder(
      //     stream: controller.chatStream(),
      //     builder: (context, snapshot){
      //       if (snapshot.hasData){
      //         print(snapshot.data!.documents.length);
      //         return ListView.builder(
      //           itemCount: snapshots.data!.doc.lenght,
      //           itemBuilder: itemBuilder);
      //       }
      //     },),

      //   // child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(

      //   //   builder: (Context,snapshot){
      //   //     if (snapshot.connectionState == ConnectionState.active) {

      //   //     }
      //   //     return Center(
      //   //       child: CircularProgressIndicator(color: Colors.green,),
      //   //     );
      //   //   },)

      // ),
       // ],
      //   ),
      // ),