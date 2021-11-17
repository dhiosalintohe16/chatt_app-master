import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:tierra_app/app/modules/artikel/views/artikel_view.dart';

import 'package:tierra_app/app/modules/favorit/views/favorit_view.dart';
import 'package:tierra_app/app/modules/home/views/home_view.dart';
import 'package:tierra_app/app/modules/komunitas/views/komunitas_view.dart';
import 'package:tierra_app/app/modules/pertanyaan/views/pertanyaan_view.dart';
import 'package:tierra_app/app/modules/profil/views/profil_view.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:tierra_app/app/utils/theme.dart';

class BottomNavBarView extends StatefulWidget {
  const BottomNavBarView({Key? key}) : super(key: key);

  @override
  _BottomNavBarrState createState() => _BottomNavBarrState();
}

class _BottomNavBarrState extends State<BottomNavBarView> {
  int _selectedIndex = 0;

  final _screens = [
    HomeView(),
    ArtikelView(),
    FavoritView(),
    // ComunityView(),
    KomunitasView(),
    ProfilView(),
    PertanyaanView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(
        color: Color(0xFF008269),
        backgroundColor: Colors.transparent,
        items: <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
            semanticLabel: "Home",
          ),
          Icon(
            Icons.article,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.favorite_outlined,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.message_rounded,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.person,
            size: 30,
            color: Colors.white,
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          //Handle button tap
        },
      ),
      body: Stack(
        children: _screens
            .asMap()
            .map((i, screen) => MapEntry(
                i,
                Offstage(
                  offstage: _selectedIndex != i,
                  child: screen,
                )))
            .values
            .toList(),
      ),
    );
  }
}
