// ignore_for_file: must_be_immutable

import 'dart:io';
// import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:tierra_app/app/controllers/auth_controller.dart';
import 'package:tierra_app/app/modules/komunitas/views/QnA_Room.dart';
import 'package:tierra_app/app/modules/pertanyaan/controllers/pertanyaan_controller.dart';


import 'package:tierra_app/app/routes/app_pages.dart';

import '../controllers/komunitas_controller.dart';

class KomunitasView extends GetView<KomunitasController> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final authC = Get.find<AuthController>();
  final control = Get.put(KomunitasController());
 

  @override
  Widget build(BuildContext context) {

    void _movetoDeailcontent(DocumentSnapshot data){
    Navigator.push(context, MaterialPageRoute(builder: (context) => QnARoom(postData: data)));
  }
  
    void _updateLikeCount(DocumentSnapshot data) async {
      await PertanyaanController().jumlhLike(data);
      await PertanyaanController().likeToPost(data['postID']);
    }


  Widget _listTile(DocumentSnapshot data) {
    return Expanded(
      child: GestureDetector(
          onTap: () => _movetoDeailcontent(data),
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: Color(0xFF008269).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Color(0xFF008269)),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:  ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: 
                                Container(height: 60,width: 60,
                                  child: Image.network(
                                    data['fotoprofil'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )),
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
                        
                        child: data['postImage'] != 'NONE' ? 
                         ClipRRect(
                          borderRadius: BorderRadius.circular(12),                        
                          
                          child:                          
                          
                          // PertanyaanController().PickedImage != null ?
                        
                          
                          Image.network(data['postImage'],
                              // child: Image.network(
                              //     documentSnapshot["image"],
                              width: double.infinity,height: 150,
                              fit: BoxFit.fitWidth,)
                              // :SizedBox(height: 10,)
                        ): Container(),
                      ),
                  SizedBox(height: 10,),
                  GestureDetector(
                    onTap: () => _movetoDeailcontent(data),
                    child: Text(
                            data["isiChat"],
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 17),
                          ),),
                  
            
                          SizedBox(height:8),
            
                         
            
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                             Row(
                        children: [
                          GestureDetector(
                            onTap: ()=>_updateLikeCount(data),
                            child: Icon(
                              Icons.favorite_border,
                              color: Colors.black,
                            ),
                          ),
                          data['postlike'] != 0 ?
                          Text(
                            '${data['postlike']}',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w500),
                          ):Container(),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [IconButton(onPressed: () => _movetoDeailcontent(data), icon: Icon(Icons.message_outlined)),
                          // Icon(
                          //   Icons.message_outlined,
                          //   color: Colors.black,
                          // ),
                          data['postcomment'] != 0 ?
                          Text(
                            '${data['postcomment']}',
                            // '${data.postcoment}',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w500),
                          ):Container(),
                        ],
                      ) 
                            ],
                          )
                   
                  
                 
                ],
              ),
            ),
            // ],
          )),
    );
  }

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
                backgroundColor: Color(0xFF008269)
                )
                )
                );
                

  }
  
  
  }
  

