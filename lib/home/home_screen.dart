import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:laporin/models/user.dart';
import 'package:laporin/shared/style.dart';
import 'package:laporin/widget/boxshadow.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  String? _username;

  currentUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    var checkUsers =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final users = Users.fromJson(checkUsers.data()!, purify: true);
    setState(() {
      _username = users.username;
      isLoading = false;
    });
  }

  @override
  void initState() {
    currentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: accent,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 21.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 39.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selamat datang,',
                        style: homeWelcome,
                      ),
                      SizedBox(
                        width: 240.w,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: isLoading
                                ? Column(
                                    children: [
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Shimmer.fromColors(
                                        baseColor: Colors.grey[300]!,
                                        highlightColor: Colors.grey[100]!,
                                        child: Container(
                                          width: 140.w,
                                          height: 25.h,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5.r),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Text(
                                    _username!,
                                    style: homeUser,
                                    textAlign: TextAlign.left,
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 20.r,
                    backgroundImage: const NetworkImage(
                        "https://asset.kompas.com/crops/k4L8-PrL_OyccVkK8SOYj3e-zdg=/0x0:1400x933/750x500/data/photo/2020/02/23/5e51f3cac5ce1.jpg"),
                    backgroundColor: Colors.transparent,
                  ),
                ],
              ),
              SizedBox(
                height: 26.h,
              ),
              Container(
                width: 314.w,
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.circular(10.r),
                  image: DecorationImage(
                    image: AssetImage("assets/home-bg-img.png"),
                    alignment: Alignment.bottomCenter,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 52.h, left: 15.w, right: 5.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Ayo Lapor!",
                        style: homeTitle,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Mari kita bangun\nIndonesia\nmenjadi lebih baik\ndengan\nmelaporkan\npengaduanmu!",
                            style: homeSubtitle,
                          ),
                          Align(
                              alignment: Alignment.bottomRight,
                              child: Image.asset(
                                "assets/woman-img.png",
                                width: 160.w,
                                height: 174.h,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 26.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/complaint");
                      // print(currentId);
                    },
                    child: Container(
                      width: 142.w,
                      height: 94.h,
                      padding: EdgeInsets.only(top: 13.h, bottom: 13.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7.r),
                        boxShadow: [
                          mainBoxShadow,
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 40.w,
                            height: 40.h,
                            padding: EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              color: secondaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              "assets/ic-report.png",
                              width: 25.w,
                              height: 25.h,
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            "Pengaduan",
                            style: homeItem,
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/history");
                    },
                    child: Container(
                      width: 142.w,
                      height: 94.h,
                      padding: EdgeInsets.only(top: 13.h, bottom: 13.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7.r),
                        boxShadow: [
                          mainBoxShadow,
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 40.w,
                            height: 40.h,
                            padding: EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              color: HexColor('#D5D84E'),
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              "assets/ic-history.png",
                              width: 25.w,
                              height: 25.h,
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            "Riwayat",
                            style: homeItem,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
