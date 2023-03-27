import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laporin/admin/screen/menu/menu_widget.dart';
import 'package:laporin/services/auth.dart';
import 'package:laporin/shared/style.dart';
import 'package:laporin/widget/botnavbar.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class DashboardScreen extends StatefulWidget {
  final String title;
  const DashboardScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: accent,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text(widget.title),
        centerTitle: true,
        elevation: 0,
        leading: MenuWidget(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Dashboard'),
          TextButton(onPressed: (){
            FirebaseAuth.instance.signOut();
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/login', (Route<dynamic> route) => false);
          }, child: Text('Logout')),
        ],
      ),
    );
  }
}
