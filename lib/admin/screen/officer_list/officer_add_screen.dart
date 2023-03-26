import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:laporin/shared/style.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:laporin/widget/boxshadow.dart';
import 'package:laporin/admin/service/officer.dart' as Officer;

class OfficerAddScreen extends StatefulWidget {
  const OfficerAddScreen({Key? key}) : super(key: key);

  @override
  State<OfficerAddScreen> createState() => _OfficerAddScreenState();
}

class _OfficerAddScreenState extends State<OfficerAddScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
          "Add Officer",
          style: appBarTitle,
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 17.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Center(
                  child: Container(
                      width: 86.w,
                      height: 86.h,
                      decoration: BoxDecoration(
                        color: mainColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.person_pin,
                          color: Colors.white,
                          size: 80,
                        ),
                      )),
                ),
                SizedBox(
                  height: 19.h,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 327.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.r),
                              border: Border.all(color: HexColor('#CECECE')),
                              boxShadow: [secondaryBoxShadow],
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(bottom: 12.h, left: 5.w),
                                child: Icon(Icons.person_rounded),
                              ),
                              SizedBox(
                                height: 55.h,
                                width: 295.w,
                                child: TextFormField(
                                  controller: _fullnameController,
                                  style: inputComplaint,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Isi Nama Lengkap';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10.h,
                                    ),
                                    hintText: "Nama Lengkap",
                                    hintStyle: hintComplaint,
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Stack(
                        children: [
                          Container(
                            width: 327.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.r),
                              border: Border.all(color: HexColor('#CECECE')),
                              boxShadow: [secondaryBoxShadow],
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(bottom: 12.h, left: 5.w),
                                child: Icon(FontAwesome.credit_card),
                              ),
                              SizedBox(
                                height: 55.h,
                                width: 295.w,
                                child: TextFormField(
                                  controller: _nikController,
                                  style: inputComplaint,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Isi NIK';
                                    } else if (value.length != 16) {
                                      return 'NIK perlu 16 digit';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10.h),
                                    hintText: "NIK",
                                    hintStyle: hintComplaint,
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Stack(
                        children: [
                          Container(
                            width: 327.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.r),
                              border: Border.all(color: HexColor('#CECECE')),
                              boxShadow: [secondaryBoxShadow],
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(bottom: 12.h, left: 5.w),
                                child: Icon(FontAwesome.phone),
                              ),
                              SizedBox(
                                height: 55.h,
                                width: 295.w,
                                child: TextFormField(
                                  controller: _phoneController,
                                  style: inputComplaint,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Isi Telepon';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10.h),
                                    hintText: "Telepon",
                                    hintStyle: hintComplaint,
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Stack(
                        children: [
                          Container(
                            width: 327.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.r),
                              border: Border.all(color: HexColor('#CECECE')),
                              boxShadow: [secondaryBoxShadow],
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(bottom: 12.h, left: 5.w),
                                child: Icon(Icons.person_pin_rounded),
                              ),
                              SizedBox(
                                height: 55.h,
                                width: 295.w,
                                child: TextFormField(
                                  controller: _usernameController,
                                  style: inputComplaint,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Isi Username';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10.h),
                                    hintText: "Username",
                                    hintStyle: hintComplaint,
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Stack(
                        children: [
                          Container(
                            width: 327.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.r),
                              border: Border.all(color: HexColor('#CECECE')),
                              boxShadow: [secondaryBoxShadow],
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(bottom: 12.h, left: 5.w),
                                child: Icon(Icons.alternate_email_rounded),
                              ),
                              SizedBox(
                                height: 55.h,
                                width: 295.w,
                                child: TextFormField(
                                  controller: _emailController,
                                  style: inputComplaint,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Isi Email';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10.h),
                                    hintText: "Email",
                                    hintStyle: hintComplaint,
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Stack(
                        children: [
                          Container(
                            width: 327.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.r),
                              border: Border.all(color: HexColor('#CECECE')),
                              boxShadow: [secondaryBoxShadow],
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(bottom: 12.h, left: 5.w),
                                child: Icon(Icons.lock_rounded),
                              ),
                              SizedBox(
                                height: 55.h,
                                width: 295.w,
                                child: TextFormField(
                                  controller: _passwordController,
                                  style: inputComplaint,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Isi Password';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10.h),
                                    hintText: "Password",
                                    hintStyle: hintComplaint,
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 15.h,),
                      SizedBox(
                        width: 327.w,
                        height: 50.h,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: secondaryColor,
                          ),
                          onPressed: () async {
                            if(_formKey.currentState!.validate()){
                              try{
                                Officer.officerAdd(_fullnameController.text, int.parse(_nikController.text), _phoneController.text.toString(), _usernameController.text, _emailController.text, _passwordController.text.toString());
                                buildSuccessSubmitDialog(context).show();
                              }catch (e){
                                print(e);
                              }
                            }
                          },
                          child: Text(
                            "Add Officer",
                            style: loginBtn,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

AwesomeDialog buildSuccessSubmitDialog(BuildContext context) {
  return AwesomeDialog(
    context: context,
    dialogType: DialogType.success,
    headerAnimationLoop: false,
    animType: AnimType.bottomSlide,
    title: 'Berhasil menambahkan petugas!',
    titleTextStyle: popUpWarningTitle,
    desc: 'Kamu sudah berhasil menambahkan petugas',
    descTextStyle: popUpWarningDesc,
    buttonsTextStyle: whiteOnBtnSmall,
    buttonsBorderRadius: BorderRadius.circular(6.r),
    btnOkColor: mainColor,
    showCloseIcon: false,
    btnOkText: 'Ok',
    btnOkOnPress: () {
      // Navigator.pushNamedAndRemoveUntil(context, '/botnavbar', (route) => false);
      Navigator.pop(context);
    },
  );
}
