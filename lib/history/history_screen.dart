import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:laporin/history/history_detail_screen.dart';
import 'package:laporin/shared/style.dart';
import 'package:laporin/widget/boxshadow.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int tabIndex = 1;

  @override
  void initState() {
    // TODO: implement initState
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();

    return Scaffold(
      backgroundColor: accent,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: black,
          ),
        ),
        title: Text(
          "Riwayat",
          style: appBarTitle,
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: tabController,
          labelStyle: tabTitle,
          labelColor: secondaryColor,
          unselectedLabelStyle: unselectedTabTitle,
          unselectedLabelColor: HexColor('#757575'),
          tabs: const [
            Tab(
              child: Text("Diajukan"),
            ),
            Tab(
              child: Text("Diproses"),
            ),
            Tab(
              child: Text("Selesai"),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        physics: BouncingScrollPhysics(),
        dragStartBehavior: DragStartBehavior.down,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              child: StreamBuilder<QuerySnapshot>(
                stream: db.collection('complaints').where('status', isEqualTo: 0).where('idUser', isEqualTo: uid).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/null-history.png', width: 287.w, height: 272.h,),
                        SizedBox(
                            width: 227.w,
                            child: Text('Sepertinya kamu belum mengajukan pengaduan apapun', style: noData, textAlign: TextAlign.center,))
                      ],
                    );
                  } else {
                    return ListView(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      children: snapshot.data!.docs.map((complaints) {
                        return Column(
                          children: [                            Container(
                              width: 332.w,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(3.r),
                                  border: Border.all(
                                    color: HexColor('#B9B9B9'),
                                    width: 0.5.w,
                                  ),
                                  boxShadow: [mainBoxShadow]),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 12.w, top: 4.h, bottom: 5.h),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          complaints['title'],
                                          style: itemTitleHistory,
                                        ),
                                        Container(
                                          child: LayoutBuilder(builder: (context, constraints){
                                           if(complaints['status'] == 0){
                                             return Text(
                                               "Diajukan",
                                               style: itemStatusRed,
                                             );
                                           }else if(complaints['status'] == 1){
                                             return Text(
                                               "Diproses",
                                               style: itemStatusYellow,
                                             );
                                           }else{
                                             return Text(
                                               "Selesai",
                                               style: itemStatusGreen,
                                             );
                                           }
                                          }),
                                        ),
                                        SizedBox(
                                          height: 4.h,
                                        ),
                                      ],
                                    ),
                                  ),
                                  FadeInImage(
                                    placeholder: AssetImage('assets/loading-circle.gif'),
                                    image: NetworkImage(complaints['image']),
                                    width: 332.w,
                                    height: 113.h,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    height: 6.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        width: 70.w,
                                        height: 30.h,
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                            backgroundColor: secondaryColor,
                                            padding: EdgeInsets.zero,
                                          ),
                                          onPressed: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryDetailScreen(
                                              complaint: complaints,
                                            )));
                                          },
                                          child: Text(
                                            "Lihat",
                                            style: itemSee,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 6.w,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 17.h,),
                          ],
                        );
                      }).toList(),
                    );
                  }
                },
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              child: StreamBuilder<QuerySnapshot>(
                stream: db.collection('complaints').where('status', isEqualTo: 1).where('idUser', isEqualTo: uid).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/null-history.png', width: 287.w, height: 272.h,),
                        SizedBox(
                            width: 227.w,
                            child: Text('Sepertinya laporan kamu belum ada yang diproses', style: noData, textAlign: TextAlign.center,))
                      ],
                    );
                  } else {
                    return ListView(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      children: snapshot.data!.docs.map((complaints) {
                        return Column(
                          children: [
                            Container(
                              width: 332.w,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(3.r),
                                  border: Border.all(
                                    color: HexColor('#B9B9B9'),
                                    width: 0.5.w,
                                  ),
                                  boxShadow: [mainBoxShadow]),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 12.w, top: 4.h, bottom: 5.h),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          complaints['title'],
                                          style: itemTitleHistory,
                                        ),
                                        Container(
                                          child: LayoutBuilder(builder: (context, constraints){
                                            if(complaints['status'] == 0){
                                              return Text(
                                                "Diajukan",
                                                style: itemStatusRed,
                                              );
                                            }else if(complaints['status'] == 1){
                                              return Text(
                                                "Diproses",
                                                style: itemStatusYellow,
                                              );
                                            }else{
                                              return Text(
                                                "Selesai",
                                                style: itemStatusGreen,
                                              );
                                            }
                                          }),
                                        ),
                                        SizedBox(
                                          height: 4.h,
                                        ),
                                      ],
                                    ),
                                  ),
                                  FadeInImage(
                                    placeholder: AssetImage('assets/loading-circle.gif'),
                                    image: NetworkImage(complaints['image']),
                                    width: 332.w,
                                    height: 113.h,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    height: 6.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        width: 70.w,
                                        height: 30.h,
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                            backgroundColor: secondaryColor,
                                            padding: EdgeInsets.zero,
                                          ),
                                          onPressed: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryDetailScreen(
                                              complaint: complaints,
                                            )));
                                          },
                                          child: Text(
                                            "Lihat",
                                            style: itemSee,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 6.w,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 17.h,),
                          ],
                        );
                      }
                      ).toList(),
                    );
                  }
                },
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              child: StreamBuilder<QuerySnapshot>(
                stream: db.collection('complaints').where('status', isEqualTo: 2).where('idUser', isEqualTo: uid).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/null-history.png', width: 287.w, height: 272.h,),
                        SizedBox(
                            width: 227.w,
                            child: Text('Mohon maaf, sepertinya laporan kamu belum ada yang selesai', style: noData, textAlign: TextAlign.center,))
                      ],
                    );
                  } else {
                    return ListView(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      children: snapshot.data!.docs.map((complaints) {
                        return Column(
                          children: [
                            Container(
                              width: 332.w,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(3.r),
                                  border: Border.all(
                                    color: HexColor('#B9B9B9'),
                                    width: 0.5.w,
                                  ),
                                  boxShadow: [mainBoxShadow]),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 12.w, top: 4.h, bottom: 5.h),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          complaints['title'],
                                          style: itemTitleHistory,
                                        ),
                                        Container(
                                          child: LayoutBuilder(builder: (context, constraints){
                                            if(complaints['status'] == 0){
                                              return Text(
                                                "Diajukan",
                                                style: itemStatusRed,
                                              );
                                            }else if(complaints['status'] == 1){
                                              return Text(
                                                "Diproses",
                                                style: itemStatusYellow,
                                              );
                                            }else{
                                              return Text(
                                                "Selesai",
                                                style: itemStatusGreen,
                                              );
                                            }
                                          }),
                                        ),
                                        SizedBox(
                                          height: 4.h,
                                        ),
                                      ],
                                    ),
                                  ),
                                  FadeInImage(
                                    placeholder: AssetImage('assets/loading-circle.gif'),
                                    image: NetworkImage(complaints['image']),
                                    width: 332.w,
                                    height: 113.h,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    height: 6.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        width: 70.w,
                                        height: 30.h,
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                            backgroundColor: secondaryColor,
                                            padding: EdgeInsets.zero,
                                          ),
                                          onPressed: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryDetailScreen(
                                              complaint: complaints,
                                            )));
                                          },
                                          child: Text(
                                            "Lihat",
                                            style: itemSee,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 6.w,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 17.h,),
                          ],
                        );
                      }).toList(),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
