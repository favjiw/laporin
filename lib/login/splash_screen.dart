import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laporin/models/user.dart';
import 'package:laporin/shared/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;
  bool? isUser;

  @override
  void initState() {
    super.initState();
    userCheck().whenComplete(() {
      _timer = Timer(const Duration(seconds: 3), navigateToScreen);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void navigateToScreen() async {
    if (isUser == true) {
      String? role = await roleCheck();
      if (role == 'public') {
        Navigator.pushNamedAndRemoveUntil(
            context, '/botnavbar', (route) => false);
      } else if (role == 'officer') {
        Navigator.pushNamedAndRemoveUntil(
            context, '/menu-panel', (route) => false);
      }
    } else {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }
  }

  Future<void> userCheck() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        if(mounted) {
          setState(() {
          isUser = true;
        });
        }
        print(user.uid);
        print("is User: $isUser");
      } else {
        if(mounted) {
          setState(() {
          isUser = false;
        });
        }
        print("is User: $isUser");
      }
    });
  }

  Future<String?> roleCheck() async {
    String? role;
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    final userDoc =
    await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final users = Users.fromJson(userDoc.data()!, purify: true);
    setState(() {
      role = users.role;
    });
    return role;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Image.asset('assets/logo.png', width: 294.w, height: 294.h,)),
          Text("Laporin", style: titleSplash,),
        ],
      ),
    );
  }
}
