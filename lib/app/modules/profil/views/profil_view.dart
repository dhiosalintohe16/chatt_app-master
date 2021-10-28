import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tierra_app/app/controllers/auth_controller.dart';
import 'package:tierra_app/app/modules/tentang/views/tentang_view.dart';
import 'package:tierra_app/app/routes/app_pages.dart';

class ProfilView extends StatelessWidget {
  ProfilView({Key? key}) : super(key: key);
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFFFFFFF),
      body: SafeArea(
        child: ListView(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                // color: Colors.amber,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15, top: 10),
                            child: ContainerProfile(),
                          ),

                          const SizedBox(width: 25),
                          // Nama Profile
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 30),
                              Obx(
                                () => Text(
                                  "${authC.user.value.name!}",
                                  style: GoogleFonts.nunito(
                                      
                                      fontStyle: FontStyle.normal,fontWeight: FontWeight.w800,
                                      fontSize: 18),
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                "${authC.user.value.email!}",
                                style: GoogleFonts.nunito(
                                    fontStyle: FontStyle.normal, fontSize: 18),
                              ),
                              authC.user.value.phoneNumber! == ""
                                  ? Text(
                                      "",
                                      style: GoogleFonts.abhayaLibre(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF181725),
                                      ),
                                    )
                                  : Text(
                                      "${authC.user.value.phoneNumber!}",
                                      style: GoogleFonts.abhayaLibre(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF181725),
                                      ),
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    //Widget Button
                    const ButtonToko(),
                    const ButtonPesanan(),
                    const ButtonDetail(),
                    const ButtonPengiriman(),
                    const ButtonPemberitahuan(),
                    const ButtonBantuan(),
                    const ButtonTentang(),
                    const SizedBox(height: 15),

                    //Tombol keluar
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // const Icon(
                          //   Icons.logout,
                          //   color: Color(0xFF53B175),
                          // ),
                          Container(
                            width: 200,
                            height: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Color(0xFF008269),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () => authC.logout(),
                                child: Center(
                                  child: Text(
                                    'Keluar',
                                    style: GoogleFonts.aBeeZee(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1,
                                      fontSize: 15
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonTentang extends StatelessWidget {
  const ButtonTentang({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.TENTANG),
      child: Card(
        child: ListTile(
          trailing: const Icon(
            Icons.navigate_next,
            color: Colors.black,
          ),
          leading: const Icon(
            Icons.info_outline_rounded,
            color: Colors.black,
          ),
          title: Text(
            'Tentang',
            style: GoogleFonts.aBeeZee(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonBantuan extends StatelessWidget {
  const ButtonBantuan({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.BANTUAN),
      child: Card(
        child: ListTile(
          trailing: const Icon(
            Icons.navigate_next,
            color: Colors.black,
          ),
          leading: const Icon(
            Icons.help_outline_sharp,
            color: Colors.black,
          ),
          title: Text(
            'Bantuan',
            style: GoogleFonts.aBeeZee(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonPemberitahuan extends StatelessWidget {
  const ButtonPemberitahuan({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        child: ListTile(
          trailing: const Icon(
            Icons.navigate_next,
            color: Colors.black,
          ),
          leading: const Icon(
            Icons.notifications_none,
            color: Colors.black,
          ),
          title: Text(
            'Pemberitahuan',
            style: GoogleFonts.aBeeZee(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonPengiriman extends StatelessWidget {
  const ButtonPengiriman({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.ALAMAT_PENGIRIMAN),
      child: Card(
        child: ListTile(
          trailing: const Icon(
            Icons.navigate_next,
            color: Colors.black,
          ),
          leading: const Icon(
            Icons.location_on_outlined,
            color: Colors.black,
          ),
          title: Text(
            'Alamat Pengiriman',
            style: GoogleFonts.aBeeZee(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonDetail extends StatelessWidget {
  const ButtonDetail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.DETAIL_SAYA),
      child: Card(
        child: ListTile(
          trailing: const Icon(
            Icons.navigate_next,
            color: Colors.black,
          ),
          leading: const Icon(
            Icons.account_circle_outlined,
            color: Colors.black,
          ),
          title: Text(
            'Informasi Pribadi',
            style: GoogleFonts.aBeeZee(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonPesanan extends StatelessWidget {
  const ButtonPesanan({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        child: ListTile(
          trailing: const Icon(
            Icons.navigate_next,
            color: Colors.black,
          ),
          leading: const Icon(
            Icons.shopping_bag_outlined,
            color: Colors.black,
          ),
          title: Text(
            'Pesanan',
            style: GoogleFonts.aBeeZee(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonToko extends StatelessWidget {
  const ButtonToko({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        child: ListTile(
          trailing: const Icon(
            Icons.navigate_next,
            color: Colors.black,
          ),
          leading: const Icon(
            Icons.storefront_outlined,
            color: Colors.black,
          ),
          title: Text(
            'Toko Saya',
            style: GoogleFonts.aBeeZee(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

class ContainerProfile extends StatelessWidget {
  ContainerProfile({
    Key? key,
  }) : super(key: key);
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => ClipRRect(
          borderRadius: BorderRadius.circular(200),
          child: Container(
            width: 60,
            height: 60,
            // color: Colors.red,
            child: authC.user.value.photoUrl! == "noimage"
                ? Image.asset(
                    "assets/icons/profile.png",
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    authC.user.value.photoUrl!,
                    fit: BoxFit.cover,
                  ),
          ),
        ));
  }
}
