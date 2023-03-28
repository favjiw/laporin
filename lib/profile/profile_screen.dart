import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:laporin/models/user.dart';
import 'package:laporin/shared/style.dart';
import 'package:shimmer/shimmer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = true;
  String? _fullname;
  String? _email;

  currentUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    var checkUsers =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final users = Users.fromJson(checkUsers.data()!, purify: true);
    setState(() {
      _fullname = users.fullname;
      _email = users.email;
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 38.h,
          ),
          Center(
            child: Container(
              padding: EdgeInsets.only(bottom: 20.h),
              width: 328.w,
              // height: 355.h,
              decoration: BoxDecoration(
                color: HexColor('#120616'),
                borderRadius: BorderRadius.circular(10.r),
                image: DecorationImage(
                  alignment: Alignment.bottomCenter,
                  image: AssetImage("assets/profile-img.png"),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 72.h,
                  ),
                  CircleAvatar(
                    radius: 60.r,
                    backgroundImage: NetworkImage(
                        "https://asset.kompas.com/crops/k4L8-PrL_OyccVkK8SOYj3e-zdg=/0x0:1400x933/750x500/data/photo/2020/02/23/5e51f3cac5ce1.jpg"),
                    backgroundColor: Colors.transparent,
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  SizedBox(
                    width: 297.w,
                    child: Align(
                      alignment: Alignment.center,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: isLoading
                            ? Column(
                              children: [
                                Shimmer.fromColors(
                                    baseColor: Colors.black.withOpacity(0.3),
                                    highlightColor: Colors.white12,
                                    child: Container(
                                      width: 251.w,
                                      height: 30.h,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5.r),
                                      ),
                                    ),
                                  ),
                                SizedBox(height: 10.h,),
                              ],
                            )
                            : Text(_fullname!, style: profileUsername),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 297.w,
                    child: Align(
                      alignment: Alignment.center,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: isLoading
                            ? Shimmer.fromColors(
                                baseColor: Colors.black.withOpacity(0.3),
                                highlightColor: Colors.white12,
                                child: Container(
                                  width: 251.w,
                                  height: 30.h,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                ),
                              )
                            : Text(_email!, style: profileEmail),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  SizedBox(
                    width: 100.w,
                    height: 30.h,
                    child: TextButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/login', (Route<dynamic> route) => false);
                      },
                      style: TextButton.styleFrom(
                          backgroundColor:
                              HexColor("#FF0000").withOpacity(0.40),
                          padding: EdgeInsets.zero,
                          side: BorderSide(
                            color: HexColor('#FAEAB1'),
                            width: 0.5.w,
                          )),
                      child: Text(
                        "Logout",
                        style: logoutBtn,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
