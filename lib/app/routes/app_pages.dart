import 'package:get/get.dart';


import 'package:tierra_app/app/modules/alamat_pengiriman/bindings/alamat_pengiriman_binding.dart';
import 'package:tierra_app/app/modules/alamat_pengiriman/views/alamat_pengiriman_view.dart';
import 'package:tierra_app/app/modules/artikel/bindings/artikel_binding.dart';
import 'package:tierra_app/app/modules/artikel/views/artikel_view.dart';
import 'package:tierra_app/app/modules/bantuan/bindings/bantuan_binding.dart';
import 'package:tierra_app/app/modules/bantuan/views/bantuan_view.dart';
import 'package:tierra_app/app/modules/bottom_nav_bar/bindings/bottom_nav_bar_binding.dart';
import 'package:tierra_app/app/modules/bottom_nav_bar/views/bottom_nav_bar_view.dart';
import 'package:tierra_app/app/modules/chat_room/bindings/chat_room_binding.dart';
import 'package:tierra_app/app/modules/chat_room/views/chat_room_view.dart';
import 'package:tierra_app/app/modules/detail_saya/bindings/detail_saya_binding.dart';
import 'package:tierra_app/app/modules/detail_saya/views/detail_saya_view.dart';
import 'package:tierra_app/app/modules/favorit/bindings/favorit_binding.dart';
import 'package:tierra_app/app/modules/favorit/views/favorit_view.dart';
import 'package:tierra_app/app/modules/home/bindings/home_binding.dart';
import 'package:tierra_app/app/modules/home/views/home_view.dart';
import 'package:tierra_app/app/modules/intoduction/bindings/intoduction_binding.dart';
import 'package:tierra_app/app/modules/intoduction/views/intoduction_view.dart';
import 'package:tierra_app/app/modules/komunitas/bindings/komunitas_binding.dart';
import 'package:tierra_app/app/modules/komunitas/views/komunitas_view.dart';
import 'package:tierra_app/app/modules/login/bindings/login_binding.dart';
import 'package:tierra_app/app/modules/login/views/login_view.dart';
import 'package:tierra_app/app/modules/pertanyaan/bindings/pertanyaan_binding.dart';
import 'package:tierra_app/app/modules/pertanyaan/views/pertanyaan_view.dart';
import 'package:tierra_app/app/modules/profil/bindings/profil_binding.dart';
import 'package:tierra_app/app/modules/profil/views/profil_view.dart';
import 'package:tierra_app/app/modules/tentang/bindings/tentang_binding.dart';
import 'package:tierra_app/app/modules/tentang/views/tentang_view.dart';


part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.INTODUCTION,
      page: () => IntoductionView(),
      binding: IntoductionBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.BOTTOM_NAV_BAR,
      page: () => BottomNavBarView(),
      binding: BottomNavBarBinding(),
    ),
    GetPage(
      name: _Paths.ARTIKEL,
      page: () => ArtikelView(),
      binding: ArtikelBinding(),
    ),
    GetPage(
      name: _Paths.FAVORIT,
      page: () => FavoritView(),
      binding: FavoritBinding(),
    ),
    GetPage(
      name: _Paths.KOMUNITAS,
      page: () => KomunitasView(),
      binding: KomunitasBinding(),
    ),
    GetPage(
      name: _Paths.PROFIL,
      page: () => ProfilView(),
      binding: ProfilBinding(),
    ),
    GetPage(
      name: _Paths.TENTANG,
      page: () => TentangView(),
      binding: TentangBinding(),
    ),
    GetPage(
      name: _Paths.BANTUAN,
      page: () => BantuanView(),
      binding: BantuanBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_SAYA,
      page: () => DetailSayaView(),
      binding: DetailSayaBinding(),
    ),
    GetPage(
      name: _Paths.ALAMAT_PENGIRIMAN,
      page: () => AlamatPengirimanView(),
      binding: AlamatPengirimanBinding(),
    ),
    GetPage(
      name: _Paths.CHAT_ROOM,
      page: () => ChatRoomView(),
      binding: ChatRoomBinding(),
    ),
    GetPage(
      name: _Paths.PERTANYAAN,
      page: () => PertanyaanView(),
      binding: PertanyaanBinding(),
    ),
    
    
  ];
}
