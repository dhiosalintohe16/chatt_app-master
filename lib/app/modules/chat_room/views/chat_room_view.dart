


import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';



import '../controllers/chat_room_controller.dart';

class ChatRoomView extends GetView<ChatRoomController> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        

        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Dhio Immanuel Salintohe",
              style : GoogleFonts.chelaOne(
                fontStyle: FontStyle.normal,
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 18),  )             
            ],
        ),

        
        elevation: 3,

        leading: InkWell(
          onTap: ()=> Get.back(),
          borderRadius: BorderRadius.circular(100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 5,),
              Icon(Icons.arrow_back_ios_new,color: Colors.black,),
              SizedBox(width: 5,),
              CircleAvatar(
                radius: 30,)
            ],

          ),
        ),
        
      ),


      body: Column(
        children: [
          Expanded(
            child: Container(
              child: ListView(
                children: [
                  
                  ItemChat(isSender: true,),
                  ItemChat(isSender: false,)
                ],

            ),
          ),
        ),


        Container(

          margin: EdgeInsets.only(bottom: context.mediaQueryPadding.bottom),
          width: Get.width,
          height: 100,
          color: Colors.green[600],
          child: Row(
             
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [ 
              SizedBox(width: 10,),            
              CircleAvatar(
                radius: 35, 
                backgroundColor: Colors.green[100],
                child: Icon(Icons.person),),

              SizedBox(width: 10,),
              Expanded(
                child: Container(
                  child: TextField(
                    
                    cursorColor: Colors.white,
                    decoration: InputDecoration (
                       
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white) ,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white),
                        borderRadius: BorderRadius.circular(20),),

                    hintText: "Masukkan Pesan" ,
                    hintStyle: TextStyle(color: Colors.white)),
                  ))),

              SizedBox(width: 10,),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.send),
                color: Colors.white,
                iconSize: 33,
              ),
            ],
          ),
        ),
        
      ]),
    );
  }
}

class ItemChat extends StatelessWidget {
  const ItemChat({
    Key? key,
    required this.isSender
  }) : super(key: key);

final bool isSender;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
      child: Column(

        crossAxisAlignment: isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          
          Container(
            
            decoration: BoxDecoration(
              color: isSender ? Colors.pink[100] : Colors.green[200],
              borderRadius: isSender ? BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ) : BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
            ),
            ),
            
            width: Get.width*0.6, 
            padding: EdgeInsets.all(10),
            child: Text("Pemupukan dengan rutin dan biarkan terkena sinar matahari",
            style: GoogleFonts.averageSans(
              fontSize: 16,
              fontWeight: FontWeight.w400,)
            )
          ),

          Text("19.01 PM",
          style: GoogleFonts.averageSans(
            fontSize:12),)
        ],
      ),

      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
    );
  }
}
