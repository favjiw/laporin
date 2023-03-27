import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:laporin/admin/screen/complaint_list/complaint_list_screen.dart';
import 'package:laporin/admin/screen/dashboard/dashboard_screen.dart';
import 'package:laporin/admin/screen/menu/menu_screen.dart';
import 'package:laporin/admin/screen/officer_list/officer_list_screen.dart';
import 'package:laporin/admin/screen/profile/profile_screen.dart';
import 'package:laporin/services/auth.dart';
import 'package:laporin/shared/style.dart';
import 'package:laporin/widget/botnavbar.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class PanelScreen extends StatefulWidget {
  const PanelScreen({Key? key}) : super(key: key);

  @override
  State<PanelScreen> createState() => _PanelScreenState();
}

class _PanelScreenState extends State<PanelScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      menuScreen: MenuScreen(
        setIndex: (index){
          setState(() {
            currentIndex = index;
          });

        },
      ),
      mainScreen: currentScreen(),
      menuBackgroundColor: mainColor2,
      borderRadius: 20.5,
      angle: 0.0,
      showShadow: true,
      openCurve: Curves.fastOutSlowIn,
      closeCurve: Curves.fastOutSlowIn,
    );
  }

  Widget currentScreen() {
    switch(currentIndex) {
      case 0:
        return DashboardScreen(title: "Dashboard");
      case 1:
        return ComplaintListScreen();
      case 2:
        return OfficerListScreen();
      case 3:
        return ProfileAdminScreen();
      default:
        return DashboardScreen(title: "Dashboard");
    }
  }
}
