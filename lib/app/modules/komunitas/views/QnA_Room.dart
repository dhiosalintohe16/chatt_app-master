import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tierra_app/app/controllers/auth_controller.dart';
import 'package:tierra_app/app/modules/komunitas/controllers/komunitas_controller.dart';
import 'package:tierra_app/app/modules/komunitas/views/cekKomen.dart';
import 'package:tierra_app/app/modules/pertanyaan/controllers/pertanyaan_controller.dart';

class QnARoom extends StatefulWidget {
  final DocumentSnapshot postData;
  QnARoom({required this.postData});
  @override
  State<StatefulWidget> createState() => _QnARoom();
}

class _QnARoom extends State<QnARoom> {
  final authC = Get.find<AuthController>();
  String? _replyUserID;
  String? _replyCommentID;
  
  FocusNode _writingTextFocus = FocusNode();
  final TextEditingController _msgTextController = new TextEditingController();
  @override

void initState() {
    
    _msgTextController.addListener(_msgTextControllerListener);
    super.initState();
  }

  void _msgTextControllerListener(){
    if(_msgTextController.text.length == 0 || _msgTextController.text.split(" ")[0] != _replyUserID) {
      _replyUserID = null;
      _replyCommentID = null;
   
    }
  }

void _replyComment(List<String> commentData) async{//String replyTo,String replyCommentID,String replyUserToken) async {
    _replyUserID = commentData[0];
    _replyCommentID = commentData[1];
   
    FocusScope.of(context).requestFocus(_writingTextFocus);
    _msgTextController.text = '${commentData[0]} ';
  }

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
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(authC.user.value.photoUrl!),
                )
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
                  child : SingleChildScrollView(
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
                              children: snapshot.data!.docs.map((document) {
                                return CommentItem(data: document, size: size, replyComment: _replyComment);}).toList(),
                            
                            
                                // _CommentListItem(document, size);
                              // }).toList(),
                            )
                          : Container(),
                    ],
                  ),
                  ),
                ),
                // INputText(),
                _buildTextComposer()
              ]
              );
            }
            )
            );
  }

  Widget _buildTextComposer() {
    return Container(
      color: Color(0xFF008269),
      height:80,
      child: new IconTheme(
        data: new IconThemeData(color: Colors.white),
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
                  cursorColor: Colors.white,
                  focusNode: _writingTextFocus,
                  controller: _msgTextController,
                  onSubmitted: _handleSubmitted,
                  decoration: new InputDecoration(
                    enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                      hintText: "Write a comment", hintStyle: TextStyle(color: Colors.white) ),
                
                ),
              ),

              new Container(
                margin: new EdgeInsets.symmetric(horizontal: 2.0),
                child: new IconButton(
                  icon: new Icon(Icons.send),
                  onPressed: () {
                    _handleSubmitted(_msgTextController.text);
                  }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  

  Widget _CommentListItem(DocumentSnapshot data, Size size) {
    return Stack(
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
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data['nama'],
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 12),
                        ),
                        Text(
                          data['isiComment'],
                          maxLines: null,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    width: size.width - 90,
                    decoration: BoxDecoration(
                      color: Colors.pink[100],
                      border: Border.all(color: Colors.pink.shade200),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 2.0, top: 2.0,bottom: 2),
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
                          Text(
                            'Reply',
                            style: GoogleFonts.averageSans(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
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
    );
  }

  Future<void> _handleSubmitted(String text) async {
    try {
      await PertanyaanController()
          .commentToPost(_replyUserID == null ? widget.postData['nama'] : _replyUserID,
                         _replyCommentID == null ? widget.postData['commentID']:_replyCommentID,
                         widget.postData['postID'],
                         _msgTextController);
        await PertanyaanController().jumlhCommnet(widget.postData);
      FocusScope.of(context).requestFocus(FocusNode());
      _msgTextController.text = '';
      // await FBCloudStore.commentToPost(_replyUserID == null ? widget.postData['userName'] : _replyUserID,_replyCommentID == null ? widget.postData['commentID'] : _replyCommentID,widget.postData['postID'], _msgTextController.text, widget.myData,_replyUserID == null ? widget.postData['FCMToken'] : _replyUserFCMToken);
      // await FBCloudStore.updatePostCommentCount(widget.postData);
      // FocusScope.of(context).requestFocus(FocusNode());
      // _msgTextController.text = '';
    } catch (err) {
      print(err);
    }
  }
}
