import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:tierra_app/app/controllers/auth_controller.dart';
import 'package:tierra_app/app/modules/komunitas/controllers/komunitas_controller.dart';
import 'package:tierra_app/app/modules/pertanyaan/controllers/pertanyaan_controller.dart';

class QnARoom extends StatefulWidget {
  final DocumentSnapshot postData;
  QnARoom({required this.postData});
  @override
  State<StatefulWidget> createState() => _QnARoom();
}

class _QnARoom extends State<QnARoom> {
  final authC = Get.find<AuthController>();
  String? _replyCommentID;
  String? _replyUser;
  // String? _replyCommentID;

  final TextEditingController _msgTextController = new TextEditingController();
  final FocusNode _msgFocusNode = new FocusNode();

  void _replykomen(String replyTo, replyCommentID) async {
    _replyCommentID = replyCommentID;
    FocusScope.of(context).requestFocus(_msgFocusNode);
    _msgTextController.text = '$replyTo';
  }


// void _replyComment (String replyTo, String commentID) async {
//   _replyUser = commentID;
//  FocusScope.of(context).requestFocus(_msgFocusNode);
//  _msgTextController.text = '$_replyUser';
 
 
//  }
           

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 100,
          toolbarHeight: 80,
          backgroundColor: Colors.white,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  Text(
                    widget.postData["nama"],
                    style: TextStyle(
                        fontStyle: FontStyle.normal,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                  Text(
                    KomunitasController()
                        .readTimestamp(widget.postData["lasttime"]),
                    style: GoogleFonts.averageSans(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  )
                ],
              )
            ],
          ),
          elevation: 3,
          leading: InkWell(
            onTap: () => Get.back(),
            borderRadius: BorderRadius.circular(100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 5,
                ),
                ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: 
                                Container(height: 60,width: 60,
                                  child: Image.network(
                                    widget.postData['fotoprofil'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
              ],
            ),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("komunitas")
                .doc(widget.postData["postID"])
                .collection("comment")
                .orderBy("lasttimeComment", descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return LinearProgressIndicator();
              return Column(children: [
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFF008269)),
                                color: Color(0xFF008269).withOpacity(0.1),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                )),
                            width: double.infinity,
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                widget.postData['postImage'] != 'NONE'
                                    ? Center(
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Image.network(
                                              widget.postData['postImage'],
                                              width: double.infinity,
                                              // height: double.infinity,
                                              fit: BoxFit.fitWidth,
                                            )),
                                      )
                                    : Container(),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(widget.postData["isiChat"],
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                    )),
                                SizedBox(
                                  height: 10,
                                )
                              ],
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        snapshot.data!.docs.length > 0
                            ? ListView(
                                primary: false,
                                shrinkWrap: true,
                                children: 
                                snapshot.data!.docs.map((document)
                                    //  sortDocumentsByComment(snapshot.data!.docs).map((document)
                                    {
                                  return _CommentListItem(document, size);
                                }).toList(),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
                // INputText(),
                _buildTextComposer()
              ]);
            }));
  }

  Widget _buildTextComposer() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: new IconTheme(
        data: new IconThemeData(color: Colors.black),
        child: new Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: new Row(
            children: <Widget>[
              // new CircleAvatar(
              //         radius: 30,
              //         backgroundImage:
              //             NetworkImage(authC.user.value.photoUrl!),
              //         backgroundColor: Color(0xFF008269),
              //       ),
              new Flexible(
                child: new TextField(
                  cursorColor: Colors.black,
                  focusNode: _msgFocusNode,
                  controller: _msgTextController,
                  onSubmitted: _handleSubmitted,
                  decoration: new InputDecoration(
                      filled: true,
                      fillColor: Color(0xFF008269).withOpacity(0.2),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      hintText: "Write a comment",
                      hintStyle: TextStyle(color: Colors.black)),
                ),
              ),

              new Container(
                margin: new EdgeInsets.symmetric(horizontal: 2.0),
                child: new IconButton(
                    iconSize: 30,
                    icon: new Icon(Icons.send),
                    onPressed: () {
                      _handleSubmitted(_msgTextController.text);
                      print(_msgTextController);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _CommentListItem(DocumentSnapshot data, Size size) {
    return Padding(
      padding : EdgeInsets.all(8.0),
      // padding: data['toUserID'] == widget.postData['nama']
      //     ? E
      //     : EdgeInsets.fromLTRB(20.0, 8.0, 8.0, 8.0),
      child: Stack(
        children: [
          Row(
            children: [
              Padding(padding: EdgeInsets.fromLTRB(10, 15, 10, 14)),
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(data['fotoprofil']),
              ),
              SizedBox(
                width: 5,
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['nama'],
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          color: Colors.grey.shade300,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                      Text(data['isiComment'],
                          maxLines: null,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          )),
                    ],
                  ),
                  width: size.width - 
                  // 150,
                      (data['toUserID'] == data['nama'] ? 140 : 150),
                  decoration: BoxDecoration(
                    color: Color(0xFF007869),
                    // border:
                    // Border.all(color: Colors.pink.shade200),
                    // borderRadius: BorderRadius.only(
                    //   topLeft: Radius.circular(5),
                    //   topRight: Radius.circular(5),
                    //   bottomLeft: Radius.circular(5),
                    // ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 2.0, top: 2.0, bottom: 2),
                  child: Container(
                    width: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          KomunitasController()
                              .readTimestamp(data['lasttimeComment']),
                          style: GoogleFonts.averageSans(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              '${data['commnetlike']}',
                              style: GoogleFonts.averageSans(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'Like',
                              style: GoogleFonts.averageSans(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            _replykomen(data['nama'], data['commentID']);
                          },
                          child: Text(
                            'Reply',
                            style: GoogleFonts.averageSans(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ] // Container
                  )
            ],
          ),
          Positioned(
            bottom: 12,
            right: 2,
            child: Icon(Icons.favorite, size: 20, color: Colors.red[700]),
          ) // Card
        ],
      ),
    );
  }

  // List<DocumentSnapshot> _sortDocumentsByComment(List<DocumentSnapshot> data) {
  //   List<DocumentSnapshot> _originalData = data;

  //   Map<String, List<DocumentSnapshot>> commentDocuments =
  //       Map<String, List<DocumentSnapshot>>();
        
  //   List<int> replyCommentIndex =  <int>[];
  //   for (int i = 0; i < _originalData.length; i++) {
  //     for (int j = 0; j < _originalData.length; j++) {
  //       if (_originalData[i]['toUserID'] == _originalData[j]['commentID']) {
  //         print(
  //             'Do it index is $i and ${_originalData[i]['commentID']} and compare name is ${_originalData[j]['commentID']} ${data[j]['toUserID']}');

  //         List<DocumentSnapshot>? savedCommentData;
  //         if (commentDocuments[_originalData[i]['commentID']] != null &&
  //             commentDocuments[_originalData[i]['commentID']]!.length > 0) {
  //           savedCommentData = commentDocuments[_originalData[i]['commentID']];
         
  //         } else {
  //           savedCommentData = <DocumentSnapshot>[];}
  //           savedCommentData!.add(_originalData[j]);
  //           commentDocuments[_originalData[i]['commentID']] = savedCommentData;
  //           replyCommentIndex.add(j);
           
  //         }
  //       }
  //     }
      
  //     if (replyCommentIndex.length > 0) {
        
  //       for (int i = 0; i < replyCommentIndex.length; i++) {
          
  //         _originalData.removeAt(replyCommentIndex[i]);
          
  //       }
  //     }

  //     print('commentDocuments length is ${commentDocuments.length}');

  //     for (DocumentSnapshot snapshot in _originalData) {
  //       if (commentDocuments[snapshot['commentID']] != null) {
  //         for (int j = 0;
  //             j < commentDocuments[snapshot['commentID']]!.length;
  //             j++) {
  //           print(commentDocuments[snapshot['commentID']]![j]['commentID']);
  //         }
  //       }
  //     }

  //     print('arranged List is');

  //     for (int i = 0; i < _originalData.length; i++) {
  //       if (commentDocuments[_originalData[i]['commentID']] != null) {
         
  //         // _originalData.indexOf(commentDocuments[_originalData[i]['commentID']],i+1);
  //         _originalData.insertAll(
  //             i + 1, commentDocuments[_originalData[i]['commentID']]!); //INI ERRONYA UBAH ITERALE
  //       }
  //       for (DocumentSnapshot snapshot in _originalData) {
  //         print(snapshot['isiComment']);
  //       }
        
  //     }
  //     return  _originalData;
      
  //   }

  static List<DocumentSnapshot> sortDocumentsByComment(List<DocumentSnapshot> data){
    List<DocumentSnapshot> _originalData = data;
    Map<String,List<DocumentSnapshot>> commentDocuments = Map<String,List<DocumentSnapshot>>();
    Map<String,Iterable<DocumentSnapshot>> commentIterable = Map<String,Iterable<DocumentSnapshot>>();
    // Iterable<DocumentSnapshot<Object?>> comment = <DocumentSnapshot<Object?>>(); as Iterable<DocumentSnapshot<Object?>>
    
    List<int> replyCommentIndex = <int>[];
    for(int i = 0; i < _originalData.length; i++){
      for(int j = 0; j < _originalData.length; j++){
        if (_originalData[i]['commentID'] == _originalData[j]['toUserID']){
          List<DocumentSnapshot> savedCommentData;
          if (commentDocuments[_originalData[i]['commentID']] != null && commentDocuments[_originalData[i]['commentID']]!.length > 0) {
            savedCommentData = commentDocuments[_originalData[i]['commentID']]!;
          }else {
            savedCommentData = <DocumentSnapshot>[];
          }
          savedCommentData.add(_originalData[j]);
          commentDocuments[_originalData[i]['commentID']] = savedCommentData;
          replyCommentIndex.add(j);
        }
      }
    }

    replyCommentIndex.sort((a,b){
      return b.compareTo(a);
    });

    // remove comment
    if(replyCommentIndex.length > 0){
      for(int i = 0; i < replyCommentIndex.length; i++){
        _originalData.removeAt(replyCommentIndex[i]);
      }
    }

    // Add list to comment
  
    for(int i = 0; i < _originalData.length; i++){
      if (commentDocuments[_originalData[i]['commentID']] != null){
        // commentIterable = commentDocuments[_originalData[i]['commentID']] as Map<String, Iterable<DocumentSnapshot<Object?>>>;
        // _originalData.insertAll(i+1,commentDocuments[_originalData[i]['commentID']]);
        // 
      }
    }
    return _originalData;
  }
    
  

  Future<void> _handleSubmitted(String text) async {
    try {
      await PertanyaanController().commentToPost(
          _replyCommentID == null
              ? widget.postData['nama']
              : _replyCommentID,
          widget.postData['postID'],
          _msgTextController.text);
      await PertanyaanController().jumlhCommnet(widget.postData);
      FocusScope.of(context).requestFocus(FocusNode());
      _msgTextController.text = '';
    } catch (err) {
      print('INI BAGIAN ERRONYA TOLONG DI BACA    $err');
    }
  }

}

