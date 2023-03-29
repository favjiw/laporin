import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laporin/admin/screen/menu/menu_widget.dart';
import 'package:laporin/models/user.dart';
import 'package:laporin/shared/style.dart';
import 'package:laporin/widget/boxshadow.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class ProfileAdminScreen extends StatefulWidget {
  const ProfileAdminScreen({Key? key}) : super(key: key);

  @override
  State<ProfileAdminScreen> createState() => _ProfileAdminScreenState();
}

class _ProfileAdminScreenState extends State<ProfileAdminScreen> {
  bool? _isLoading;
  String _uid = '';
  String _fullname = '';
  String _username = '';
  int _nik = 0;
  String _email = '';
  String _phone = '';
  String _role = '';

  @override
  void initState() {
    currentUser();
    super.initState();
  }

  Future<String?> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('uid');
  }

  currentUser() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await getSharedPrefs().then((value) async {
        setState(() {
          _uid = '$value';
        });
      });
    } catch (e) {
      print('Error di blok getSharedPrefs: $e');
    }
    try {
      var checkUsers =
          await FirebaseFirestore.instance.collection('users').doc(_uid).get();
      final users = Users.fromJson(checkUsers.data()!, purify: true);
      setState(() {
        _fullname = users.fullname!;
        _username = users.username!;
        _nik = users.nik!;
        _email = users.email!;
        _phone = users.phone!;
        _role = users.role!;
      });
    } catch (e) {
      print('Error di blok firestore: $e');
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: accent,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text(
          "Profile",
          style: appBarTitleWhite,
        ),
        centerTitle: true,
        elevation: 0,
        leading: MenuWidget(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 360.w,
            height: 145.h,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    width: 1.sw,
                    height: 90.h,
                    decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.r),
                        bottomRight: Radius.circular(10.r),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 45.h,
                  left: 137.w,
                  child: Container(
                    width: 86.w,
                    height: 86.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: accent,
                      boxShadow: [
                        secondaryBoxShadow,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Center(
              child: _isLoading!
                  ? Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 80.w,
                  height: 24.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                ),
              )
                  : Text(
                _fullname,
                style: profileMain,
              ),
          ),
          Center(
              child: _isLoading!
                  ? Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 168.w,
                  height: 21.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                ),
              )
                  : Text(
                _role,
                style: profileMain,
              ),),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 19.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Information',
                  style: information,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 87.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Fullname",
                            style: profileSub,
                          ),
                          Text(
                            ": ",
                            style: profileSub,
                          ),
                        ],
                      ),
                    ),
                    _isLoading!
                        ? Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: 168.w,
                              height: 21.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                            ),
                          )
                        : Text(
                            _fullname,
                            style: profileMain,
                          ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 87.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Username",
                            style: profileSub,
                          ),
                          Text(
                            ": ",
                            style: profileSub,
                          ),
                        ],
                      ),
                    ),
                    _isLoading!
                        ? Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: 168.w,
                        height: 21.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                      ),
                    )
                        : Text(
                      _username,
                      style: profileMain,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 87.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Email",
                            style: profileSub,
                          ),
                          Text(
                            ": ",
                            style: profileSub,
                          ),
                        ],
                      ),
                    ),
                    _isLoading!
                        ? Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: 168.w,
                        height: 21.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                      ),
                    )
                        : Text(
                      _email,
                      style: profileMain,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 87.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "NIK",
                            style: profileSub,
                          ),
                          Text(
                            ": ",
                            style: profileSub,
                          ),
                        ],
                      ),
                    ),
                    _isLoading!
                        ? Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: 168.w,
                        height: 21.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                      ),
                    )
                        : Text(
                      _nik.toString(),
                      style: profileMain,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 87.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Phone",
                            style: profileSub,
                          ),
                          Text(
                            ": ",
                            style: profileSub,
                          ),
                        ],
                      ),
                    ),
                    _isLoading!
                        ? Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: 168.w,
                        height: 21.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                      ),
                    )
                        : Text(
                      _phone,
                      style: profileMain,
                    ),
                  ],
                ),
                SizedBox(
                  height: 37.h,
                ),
                Center(
                  child: SizedBox(
                    width: 160.w,
                    height: 40.h,
                    child: TextButton(
                      onPressed: () async {
                        FirebaseAuth.instance.signOut();
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        await preferences.clear();
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/login', (Route<dynamic> route) => false);
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.r),
                          )),
                      child: Text(
                        'Logout',
                        style: logoutWhite,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
