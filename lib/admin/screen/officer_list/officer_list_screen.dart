import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:laporin/admin/screen/complaint_list/complaint_respond.dart';
import 'package:laporin/admin/screen/menu/menu_widget.dart';
import 'package:laporin/admin/screen/officer_list/officer_edit_screen.dart';
import 'package:laporin/admin/service/officer.dart' as Officer;
import 'package:laporin/history/history_detail_screen.dart';
import 'package:laporin/models/user.dart';
import 'package:laporin/services/trigger.dart';
import 'package:laporin/shared/style.dart';
import 'package:laporin/widget/boxshadow.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class OfficerListScreen extends StatefulWidget {
  const OfficerListScreen({Key? key}) : super(key: key);

  @override
  State<OfficerListScreen> createState() => _OfficerListScreenState();
}

class _OfficerListScreenState extends State<OfficerListScreen> {
  bool? _isLoading;
  int _totalOfficers = 0;
  final db = FirebaseFirestore.instance;
  String? _uid;
  String? _role;

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
        _role = users.role;
      });
    } catch (e) {
      print('Error di blok firestore: $e');
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future countDocumentsInCollection() async {
    setState(() {
      _isLoading = true;
    });
    QuerySnapshot querySnapshot =
        await db.collection('users').where('role', isEqualTo: 'officer').get();
    int count = querySnapshot.size;
    setState(() {
      _totalOfficers = count;
      _isLoading = false;
    });
  }

  Future exportOfficerToExcel() async {
    PermissionStatus status = await Permission.storage.request();
    if (status != PermissionStatus.granted) return;

    Directory? directory = await getExternalStorageDirectory();
    String fileName = "officerData1.xlsx";
    String filePath = "${directory!.path}/$fileName";
    try {
      QuerySnapshot querySnapshot = await db
          .collection('users')
          .where('role', isEqualTo: 'officer')
          .get();
      var workbook = Excel.createExcel();
      var sheet = workbook['Sheet1'];
      // Add headers to worksheet
      sheet.appendRow([
        'ID',
        'Fullname',
        'Username',
        'NIK',
        'Role',
        'Phone',
        'Email',
        'Password'
      ]);
      // Add data to worksheet
      for (var document in querySnapshot.docs) {
        dynamic documentData = document.data();
        var row = [
          documentData!['id'] as String,
          documentData!['fullname'] as String,
          documentData!['username'] as String,
          documentData!['nik'] as int,
          documentData!['role'] as String,
          documentData!['phone'] as String,
          documentData!['email'] as String,
          documentData!['password'] as String,
        ];
        sheet.appendRow(row);
      }
      List<int>? bytes = await workbook.encode();
      await File(filePath).writeAsBytes(bytes!);
      print(filePath);
      print("BERHASIL!!!");
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    currentUser();
    countDocumentsInCollection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Timestamp now = Timestamp.now();
    DateTime dateTime = now.toDate();
    final timestamp = Timestamp.fromDate(dateTime);

    return Scaffold(
      backgroundColor: accent,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text(
          "Officer List",
          style: appBarTitleWhite,
        ),
        centerTitle: true,
        elevation: 0,
        leading: MenuWidget(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.only(top: 20.h, left: 30.w, right: 21.w, bottom: 30.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _isLoading!
                      ? Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: 100.w,
                            height: 25.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                          ),
                        )
                      : Text(
                          "$_totalOfficers Officers",
                          style: officerCount,
                        ),
                  _isLoading!
                      ? SizedBox()
                      : _role! != "admin"
                          ? SizedBox()
                          : TextButton(
                              onPressed: () {
                                exportOfficerToExcel();
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  elevation: 0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.file_open_rounded,
                                    color: Colors.blue,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    "Export",
                                    style: forgotPassword,
                                  ),
                                ],
                              )),
                ],
              ),
              SizedBox(height: 5.h),
              Text(
                "You can manage Officers here",
                style: officerTitleBig,
              ),
              SizedBox(height: 10.h),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/officer-add');
                },
                child: Container(
                  width: 306.w,
                  height: 50.h,
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: mainColor.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(7.r),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 40.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: secondaryColor.withOpacity(0.50),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.add_rounded,
                                color: accent,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            'Add a new Officer',
                            style: officerAdd,
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: secondaryColor,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 35.h),
              StreamBuilder<QuerySnapshot>(
                stream: db
                    .collection('users')
                    .where('role', isEqualTo: 'officer')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image_not_supported, size: 50),
                          SizedBox(height: 10),
                          Text('No data available')
                        ],
                      ),
                    );
                  } else {
                    return ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: snapshot.data!.docs.map((officer) {
                        return Column(
                          children: [
                            Container(
                              width: 306.w,
                              height: 50.h,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(13.r),
                                          child: Image.network(
                                            "https://asset.kompas.com/crops/k4L8-PrL_OyccVkK8SOYj3e-zdg=/0x0:1400x933/750x500/data/photo/2020/02/23/5e51f3cac5ce1.jpg",
                                            width: 50.w,
                                            height: 50.h,
                                            fit: BoxFit.cover,
                                          )),
                                      SizedBox(
                                        width: 7.w,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            officer['fullname'],
                                            style: officerName,
                                          ),
                                          Text(
                                            officer['role'],
                                            style: officerRole,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      OfficerEditScreen(
                                                        officer: officer,
                                                      )));
                                        },
                                        icon: Icon(Icons.edit_rounded),
                                        color: mainColor,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          buildWarningDeleteDialog(
                                                  context,
                                                  officer['id'],
                                                  _uid!.toString(),
                                                  timestamp)
                                              .show();
                                        },
                                        icon: Icon(Icons.delete_rounded),
                                        color: red,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                          ],
                        );
                      }).toList(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

AwesomeDialog buildWarningDeleteDialog(
    BuildContext context, String id, String uid, Timestamp timestamp) {
  return AwesomeDialog(
    context: context,
    dialogType: DialogType.warning,
    headerAnimationLoop: false,
    animType: AnimType.bottomSlide,
    title: 'Perhatian!',
    titleTextStyle: popUpWarningTitle,
    desc: 'Apakah anda yakin ingin menghapus petugas?',
    descTextStyle: popUpWarningDesc,
    buttonsTextStyle: whiteOnBtnSmall,
    buttonsBorderRadius: BorderRadius.circular(6.r),
    btnOkColor: red,
    btnCancelColor: mainColor,
    showCloseIcon: false,
    btnOkText: 'Ya',
    btnCancelText: 'Tidak',
    btnOkOnPress: () {
      try {
        Officer.officerDelete(id);
        onDeleteOfficer(uid, timestamp);
      } catch (e) {
        print(e);
      }
    },
    btnCancelOnPress: () {},
  );
}
