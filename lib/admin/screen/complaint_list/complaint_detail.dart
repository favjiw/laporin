import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:laporin/admin/screen/complaint_list/complaint_respond.dart';
import 'package:laporin/admin/screen/menu/menu_widget.dart';
import 'package:laporin/models/user.dart';
import 'package:laporin/shared/style.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:shimmer/shimmer.dart';

class ComplaintDetailScreen extends StatefulWidget {
  final dynamic complaint;
  const ComplaintDetailScreen({Key? key, required this.complaint})
      : super(key: key);

  @override
  State<ComplaintDetailScreen> createState() => _ComplaintDetailScreenState();
}

class _ComplaintDetailScreenState extends State<ComplaintDetailScreen> {
  dynamic complaint;
  bool? _isLoading;
  String? _imageUrl;
  String? _fullname;
  String? _username;
  int? _nik;
  String? _email;
  String? _phone;

  userComplaint() async {
    setState(() {
      _isLoading = true;
    });
    var checkUsers =
    await FirebaseFirestore.instance.collection('users').doc(complaint['idUser']).get();
    final users = Users.fromJson(checkUsers.data()!, purify: true);
    setState(() {
      _fullname = users.fullname;
      _username = users.username;
      _nik = users.nik;
      _email = users.email;
      _phone = users.phone;
      _isLoading = false;
    });
  }


  Future syncImage() async {
    setState(() {
      _isLoading = true;
    });
    _imageUrl = complaint['image'];
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    complaint = widget.complaint;
    syncImage();
    userComplaint();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final dynamic complaint = widget.complaint;

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
          "Detail Pengaduan",
          style: appBarTitle,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30.h,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 131.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Judul",
                          style: subtitleComplaint,
                        ),
                        Text(
                          ": ",
                          style: subtitleComplaint,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    complaint['title'],
                    style: valueComplaint,
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 131.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tanggal Pengaduan",
                          style: subtitleComplaint,
                        ),
                        Text(
                          ": ",
                          style: subtitleComplaint,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    DateFormat('dd MMMM yyyy')
                        .format(complaint['date'].toDate()),
                    style: valueComplaint,
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 131.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Deskripsi",
                          style: subtitleComplaint,
                        ),
                        Text(
                          ": ",
                          style: subtitleComplaint,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 188.w,
                    child: ReadMoreText(
                      complaint['desc'],
                      style: valueComplaint,
                      textAlign: TextAlign.justify,
                      trimLines: 4,
                      colorClickableText: secondaryColor,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'Show more',
                      trimExpandedText: 'Show less',
                      moreStyle: descMoreDetail,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 131.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "ID Pengaduan",
                          style: subtitleComplaint,
                        ),
                        Text(
                          ": ",
                          style: subtitleComplaint,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    complaint['id'],
                    style: valueComplaint,
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 131.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Status",
                          style: subtitleComplaint,
                        ),
                        Text(
                          ": ",
                          style: subtitleComplaint,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: LayoutBuilder(builder: (context, constraints) {
                      if (complaint['status'] == 0) {
                        return Text(
                          "Diajukan",
                          style: valueComplaint,
                        );
                      } else if (complaint['status'] == 1) {
                        return Text(
                          "Diproses",
                          style: valueComplaint,
                        );
                      } else {
                        return Text(
                          "Selesai",
                          style: valueComplaint,
                        );
                      }
                    }),
                  ),
                ],
              ),
              SizedBox(
                height: 24.h,
              ),
              Container(
                width: 1.sw,
                height: 1.h,
                color: grayB6.withOpacity(0.50),
              ),
              SizedBox(
                height: 10.h,
              ),
              _isLoading!
                  ? Center(
                    child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 300.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                        ),
                      ),
                  )
                  : Center(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(7.r),
                        child: Image.network(
                          _imageUrl!,
                          height: 300.h,
                          fit: BoxFit.cover,
                        )),
                  ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                width: 1.sw,
                height: 1.h,
                color: grayB6.withOpacity(0.50),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text('Dilaporkan oleh', style: titleComplaint,),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 131.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Nama Lengkap",
                          style: subtitleComplaint,
                        ),
                        Text(
                          ": ",
                          style: subtitleComplaint,
                        ),
                      ],
                    ),
                  ),
                  //Fullname
                  _isLoading!
                      ? Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 140.w,
                      height: 25.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.circular(5.r),
                      ),
                    ),
                  )
                      :
                  Text(
                    _fullname!,
                    style: valueComplaint,
                  ),
                ],
              ),
              SizedBox(height: 10.h,),
              //username
              Row(
                children: [
                  SizedBox(
                    width: 131.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Username",
                          style: subtitleComplaint,
                        ),
                        Text(
                          ": ",
                          style: subtitleComplaint,
                        ),
                      ],
                    ),
                  ),
                  _isLoading!
                      ? Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 140.w,
                      height: 25.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.circular(5.r),
                      ),
                    ),
                  )
                      :
                  Text(
                    _username!,
                    style: valueComplaint,
                  ),
                ],
              ),
              SizedBox(height: 10.h,),
              Row(
                children: [
                  SizedBox(
                    width: 131.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "NIK",
                          style: subtitleComplaint,
                        ),
                        Text(
                          ": ",
                          style: subtitleComplaint,
                        ),
                      ],
                    ),
                  ),
                  _isLoading!
                      ? Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 140.w,
                      height: 25.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.circular(5.r),
                      ),
                    ),
                  )
                      :
                  Text(
                    _nik!.toString(),
                    style: valueComplaint,
                  ),
                ],
              ),
              SizedBox(height: 10.h,),
              Row(
                children: [
                  SizedBox(
                    width: 131.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Email",
                          style: subtitleComplaint,
                        ),
                        Text(
                          ": ",
                          style: subtitleComplaint,
                        ),
                      ],
                    ),
                  ),
                  _isLoading!
                      ? Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 140.w,
                      height: 25.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.circular(5.r),
                      ),
                    ),
                  )
                      :
                  Text(
                    _email!,
                    style: valueComplaint,
                  ),
                ],
              ),
              SizedBox(height: 10.h,),
              Row(
                children: [
                  SizedBox(
                    width: 131.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "No. Telepon",
                          style: subtitleComplaint,
                        ),
                        Text(
                          ": ",
                          style: subtitleComplaint,
                        ),
                      ],
                    ),
                  ),
                  _isLoading!
                      ? Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 140.w,
                      height: 25.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.circular(5.r),
                      ),
                    ),
                  )
                      :
                  Text(
                    _phone!,
                    style: valueComplaint,
                  ),
                ],
              ),
              SizedBox(height: 30.h,),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 9.h, horizontal: 20.w),
        width: 1.sw,
        height: 74.h,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              offset: const Offset(0, -2),
              color: Colors.black.withOpacity(0.15),
              blurRadius: 10,
              spreadRadius: 0),
        ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.r),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ComplaintRespond(
                complaint: complaint,
              )));
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(secondaryColor),
            ),
            child: Text(
              "Tanggapi",
              style: whiteOnBtn,
            ),
          ),
        ),
      ),
    );
  }
}
