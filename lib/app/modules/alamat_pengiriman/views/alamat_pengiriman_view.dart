import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/alamat_pengiriman_controller.dart';

class AlamatPengirimanView extends GetView<AlamatPengirimanController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AlamatPengirimanView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'AlamatPengirimanView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
