import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laporin/home/home_screen.dart';
import 'package:laporin/profile/profile_screen.dart';
import 'package:laporin/shared/style.dart';

class BotNavBar extends StatefulWidget {
  const BotNavBar({Key? key}) : super(key: key);

  @override
  State<BotNavBar> createState() => _BotNavBarState();
}

class _BotNavBarState extends State<BotNavBar> {
  int currentIndex = 0;
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: secondaryColor,
        child: Image.asset(
          'assets/ic-plus.png',
          width: 40.w,
          height: 40.h,
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/complaint');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          height: 56.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.r),
                  child: MaterialButton(
                    onPressed: (){
                      setState(() {
                        currentScreen = HomeScreen();
                        currentIndex = 0;
                      });
                    },
                    minWidth: 100.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          currentIndex == 0
                              ? 'assets/home-ic-active.png'
                              : 'assets/home-ic-inactive.png',
                          width: 24.w,
                          height: 24.h,
                        ),
                        Text("Home", style: currentIndex == 0 ? botNavActive : botNavInactive,),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20.h),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.r),
                  child: MaterialButton(
                    onPressed: (){
                      setState(() {
                        currentScreen = ProfileScreen();
                        currentIndex = 1;
                      });
                    },
                    minWidth: 100.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          currentIndex == 1
                              ? 'assets/profile-ic-active.png'
                              : 'assets/profile-ic-inactive.png',
                          width: 24.w,
                          height: 24.h,
                        ),
                        Text("Profile", style: currentIndex == 1 ? botNavActive : botNavInactive,),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
