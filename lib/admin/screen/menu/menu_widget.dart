import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laporin/services/auth.dart';
import 'package:laporin/shared/style.dart';
import 'package:laporin/widget/botnavbar.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => IconButton(
    icon: Icon(Icons.menu_rounded),
    onPressed: () {
      ZoomDrawer.of(context)!.toggle();
    }
  );
}

