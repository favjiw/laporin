import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laporin/admin/screen/menu/menu_widget.dart';
import 'package:laporin/models/user.dart';
import 'package:laporin/shared/style.dart';
import 'package:laporin/widget/boxshadow.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class DashboardScreen extends StatefulWidget {
  final String title;
  const DashboardScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool? _isLoading;
  String _username = '';
  String? _uid;
  double _requestedComplaint = 0.0;
  double _processedComplaint = 0.0;
  double _successComplaint = 0.0;
  int _totalComplaint = 0;
  int _totalUser = 0;

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
        _uid = users.id;
        _username = users.username!;
      });
    } catch (e) {
      print('Error di blok firestore: $e');
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future countUsersInCollection() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final db = FirebaseFirestore.instance;
      QuerySnapshot user =
          await db.collection('users').where('role', isEqualTo: 'public').get();
      int countUser = user.size;
      setState(() {
        _totalUser = countUser;
      });
    } catch (e) {
      print('error in countUser : $e');
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future countComplaintsInCollection() async {
    final db = FirebaseFirestore.instance;
    setState(() {
      _isLoading = true;
    });

    try {
      QuerySnapshot requested =
          await db.collection('complaints').where('status', isEqualTo: 0).get();
      int countRequested = requested.size;
      QuerySnapshot processed =
          await db.collection('complaints').where('status', isEqualTo: 1).get();
      int countProcessed = processed.size;
      QuerySnapshot success =
          await db.collection('complaints').where('status', isEqualTo: 2).get();
      int countSuccess = success.size;
      QuerySnapshot total = await db.collection('complaints').get();
      int countTotal = total.size;
      setState(() {
        _requestedComplaint = countRequested.toDouble();
        _processedComplaint = countProcessed.toDouble();
        _successComplaint = countSuccess.toDouble();
        _totalComplaint = countTotal;
      });
    } catch (e) {
      print('error complaint count : $e');
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    currentUser();
    countComplaintsInCollection();
    countUsersInCollection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap = {
      "Diajukan": _requestedComplaint,
      "Diproses": _processedComplaint,
      "Selesai": _successComplaint,
    };

    return Scaffold(
      backgroundColor: accent,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text(widget.title),
        centerTitle: true,
        elevation: 0,
        leading: MenuWidget(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 19.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 37.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Selamat datang,",
                        style: welcome,
                      ),
                      _isLoading!
                          ? Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                width: 50.w,
                                height: 25.h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                              ),
                            )
                          : Text(
                              _username,
                              style: username,
                            ),
                    ],
                  ),
                  Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        secondaryBoxShadow,
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 38.h,
              ),
              _isLoading!
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: 314.w,
                        height: 302.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                      ),
                    )
                  : PieChart(
                      dataMap: dataMap,
                      chartRadius: 200.r,
                      chartLegendSpacing: 20.h,
                      legendOptions: LegendOptions(
                          legendPosition: LegendPosition.bottom,
                          showLegendsInRow: true,
                          legendTextStyle: chartLegend),
                      animationDuration: Duration(milliseconds: 1400),
                      colorList: [
                        secondaryColor,
                        secondaryColor.withOpacity(0.30),
                        mainColor
                      ],
                    ),
              SizedBox(
                height: 38.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _isLoading!
                      ? Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: 155.w,
                            height: 75.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                          ),
                        )
                      : Container(
                          width: 155.w,
                          height: 75.h,
                          decoration: BoxDecoration(
                              color: secondaryColor.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(5.r)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 4.h),
                              Text(
                                'Total Pengguna',
                                style: totalUser,
                              ),
                              Text(
                                '(masyarakat)',
                                style: masyarakatDashboard,
                              ),
                              Text(
                                _totalUser.toString(),
                                style: totalDashboard,
                              ),
                            ],
                          ),
                        ),
                  _isLoading!
                      ? Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: 155.w,
                            height: 75.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                          ),
                        )
                      : Container(
                          width: 155.w,
                          height: 75.h,
                          decoration: BoxDecoration(
                              color: secondaryColor.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(5.r)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 4.h),
                              Text(
                                'Total Pengaduan',
                                style: totalUser,
                              ),
                              Text(
                                '',
                                style: masyarakatDashboard,
                              ),
                              Text(
                                _totalComplaint.toString(),
                                style: totalDashboard,
                              ),
                            ],
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
