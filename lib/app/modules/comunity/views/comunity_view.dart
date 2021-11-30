import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/comunity_controller.dart';

class ComunityView extends GetView<ComunityController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ComunityView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ComunityView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
