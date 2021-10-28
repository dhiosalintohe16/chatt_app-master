import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HomeView',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),

      body: Center(
        child: Column( children: [
          Text(
            'HomeView is working',
            style: TextStyle(fontSize: 20),

          ),
          FloatingActionButton(
          elevation: 0,
            onPressed: (){},
            child: Icon(Icons.add_comment),
            backgroundColor: Color(0xFF008269)),
            ]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
