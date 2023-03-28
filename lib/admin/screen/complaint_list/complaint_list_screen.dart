import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:laporin/admin/screen/complaint_list/complaint_detail.dart';
import 'package:laporin/admin/screen/menu/menu_widget.dart';
import 'package:laporin/shared/style.dart';
import 'package:laporin/widget/boxshadow.dart';

class ComplaintListScreen extends StatefulWidget {
  const ComplaintListScreen({Key? key}) : super(key: key);

  @override
  State<ComplaintListScreen> createState() => _ComplaintListScreenState();
}

class _ComplaintListScreenState extends State<ComplaintListScreen> {
  // String? uid;
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: accent,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text("Complaint List", style: appBarTitleWhite,),
        centerTitle: true,
        elevation: 0,
        leading: MenuWidget(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: StreamBuilder<QuerySnapshot>(
            stream: db.collection('complaints').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
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
                                placeholder: AssetImage('assets/loading-spinner.gif'),
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
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => ComplaintDetailScreen(
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
    );
  }
}
