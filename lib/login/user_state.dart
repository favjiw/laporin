import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laporin/home/home_screen.dart';
import 'package:laporin/login/login_screen.dart';
import 'package:laporin/login/splash_screen.dart';
import 'package:laporin/widget/botnavbar.dart';


class UserState extends StatefulWidget {
  const UserState({Key? key}) : super(key: key);

  @override
  State<UserState> createState() => _UserStateState();
}

class _UserStateState extends State<UserState> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return BotNavBar();
          }else{
            return SplashScreen();
          }
        },
      ),
    );
  }
}
