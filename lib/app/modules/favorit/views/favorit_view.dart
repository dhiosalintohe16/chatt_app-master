import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/favorit_controller.dart';

class FavoritView extends GetView<FavoritController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FavoritView'),
        backgroundColor: Colors.green.shade600,
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Text(
          'FavoritView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
