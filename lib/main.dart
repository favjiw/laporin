import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laporin/admin/screen/panel/panel_screen.dart';
import 'package:laporin/complaint/complaint_edit_screen.dart';
import 'package:laporin/complaint/complaint_screen.dart';
import 'package:laporin/history/history_detail_screen.dart';
import 'package:laporin/history/history_screen.dart';
import 'package:laporin/home/home_screen.dart';
import 'package:laporin/login/login_screen.dart';
import 'package:laporin/login/signup_screen.dart';
import 'package:laporin/login/splash_screen.dart';
import 'package:laporin/login/user_state.dart';
import 'package:laporin/widget/botnavbar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:permission_handler/permission_handler.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const LaporinApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class LaporinApp extends StatefulWidget {
  const LaporinApp({Key? key}) : super(key: key);

  @override
  State<LaporinApp> createState() => _LaporinAppState();
}

class _LaporinAppState extends State<LaporinApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      builder: (context, child){
        return MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          initialRoute: '/splash',
          routes: <String, WidgetBuilder>{
            '/': (context) => UserState(),
            '/splash': (context) => SplashScreen(),
            '/login': (context) => LoginScreen(),
            '/signup': (context) => SignupScreen(),
            '/botnavbar': (context) => BotNavBar(),
            '/home': (context) => HomeScreen(),
            '/complaint': (context) => ComplaintScreen(),
            '/history': (context) => HistoryScreen(),
            '/menu-panel': (context) => PanelScreen(),
          },
        );
      },
    );
  }
}

