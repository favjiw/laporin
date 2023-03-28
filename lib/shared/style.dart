import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';

Color mainColor = HexColor('#1D8B89');
Color secondaryColor = HexColor('#164069');
Color accent = HexColor('#F3FCFB');
Color red = HexColor('#FF6C6C');
Color grayUnselect = HexColor('#A8A8A8');
Color blue = HexColor('#0165FF');
Color grayB6 = HexColor('#B6C1C5');
Color black = Colors.black;
const mainColor2 = const Color(0xff1D8B89);


TextStyle loginTitle = GoogleFonts.poppins(
  fontSize: 26.sp,
  fontWeight: FontWeight.w600,
  color: mainColor,
);

TextStyle hintLogin = GoogleFonts.poppins(
  fontSize: 14.sp,
  fontWeight: FontWeight.w400,
  color: grayUnselect,
);

TextStyle inputLogin = GoogleFonts.poppins(
  fontSize: 14.sp,
  fontWeight: FontWeight.w500,
  color: black,
);

TextStyle forgotPassword = GoogleFonts.poppins(
  fontSize: 12.sp,
  fontWeight: FontWeight.w500,
  color: blue,
);

TextStyle loginBtn = GoogleFonts.poppins(
  fontSize: 16.sp,
  fontWeight: FontWeight.w600,
  color: accent,
);

TextStyle noAccLogin = GoogleFonts.poppins(
  fontSize: 12.sp,
  fontWeight: FontWeight.w400,
  color: mainColor,
);

//botnavbar
TextStyle botNavActive = GoogleFonts.poppins(
  fontSize: 12.sp,
  color: Colors.black,
  fontWeight: FontWeight.w400,
);

TextStyle botNavInactive = GoogleFonts.poppins(
  fontSize: 12.sp,
  color: grayUnselect,
  fontWeight: FontWeight.w400,
);

//homepage
TextStyle homeWelcome = GoogleFonts.poppins(
  fontSize: 14.sp,
  color: HexColor('#353535'),
  fontWeight: FontWeight.w400,
);

TextStyle homeUser = GoogleFonts.poppins(
  fontSize: 16.sp,
  color: black,
  fontWeight: FontWeight.w500,
);

TextStyle homeTitle = GoogleFonts.poppins(
  fontSize: 24.sp,
  color: accent,
  fontWeight: FontWeight.w600,
);

TextStyle homeSubtitle = GoogleFonts.poppins(
  fontSize: 14.sp,
  color: accent.withOpacity(0.70),
  fontWeight: FontWeight.w400,
);

TextStyle homeItem = GoogleFonts.poppins(
  fontSize: 14.sp,
  color: black,
  fontWeight: FontWeight.w500,
);

//pengaduan
TextStyle appBarTitle = GoogleFonts.poppins(
  fontSize: 18.sp,
  color: mainColor,
  fontWeight: FontWeight.w600,
);

TextStyle whiteOnBtn = GoogleFonts.poppins(
  fontSize: 20.sp,
  color: accent,
  fontWeight: FontWeight.w500,
);

TextStyle hintComplaint = GoogleFonts.poppins(
  fontSize: 11.sp,
  color: grayUnselect,
  fontWeight: FontWeight.w300,
);

TextStyle inputComplaint = GoogleFonts.poppins(
  fontSize: 12.sp,
  color: black,
  fontWeight: FontWeight.w400,
);

TextStyle inputLabelComplaint = GoogleFonts.poppins(
  fontSize: 14.sp,
  color: mainColor,
  fontWeight: FontWeight.w500,
);

TextStyle uploadBtn = GoogleFonts.poppins(
  fontSize: 11.sp,
  color: black,
  fontWeight: FontWeight.w500,
);

//profile
TextStyle profileUsername = GoogleFonts.poppins(
  fontSize: 18.sp,
  color: Colors.white,
  fontWeight: FontWeight.w600,
);

TextStyle profileEmail = GoogleFonts.poppins(
  fontSize: 16.sp,
  color: Colors.white,
  fontWeight: FontWeight.w400,
);

TextStyle logoutBtn = GoogleFonts.poppins(
  fontSize: 13.sp,
  color: Colors.white,
  fontWeight: FontWeight.w600,
);

//history
TextStyle tabTitle = GoogleFonts.poppins(
  fontSize: 14.sp,
  color: secondaryColor,
  fontWeight: FontWeight.w600,
);

TextStyle unselectedTabTitle = GoogleFonts.poppins(
  fontSize: 14.sp,
  color: HexColor('#757575'),
  fontWeight: FontWeight.w400,
);

TextStyle itemTitleHistory = GoogleFonts.poppins(
  fontSize: 14.sp,
  color: black,
  fontWeight: FontWeight.w500,
);

TextStyle itemStatusRed = GoogleFonts.poppins(
  fontSize: 11.sp,
  color: HexColor('#FF0000'),
  fontWeight: FontWeight.w400,
);

TextStyle itemStatusYellow = GoogleFonts.poppins(
  fontSize: 11.sp,
  color: HexColor('#E4DA00'),
  fontWeight: FontWeight.w400,
);

TextStyle itemStatusGreen = GoogleFonts.poppins(
  fontSize: 11.sp,
  color: mainColor,
  fontWeight: FontWeight.w400,
);

TextStyle itemSee = GoogleFonts.poppins(
  fontSize: 10.sp,
  color: Colors.white,
  fontWeight: FontWeight.w500,
);

//history detail
TextStyle detailTitle = GoogleFonts.poppins(
  fontSize: 16.sp,
  color: mainColor,
  fontWeight: FontWeight.w600,
);

TextStyle appBarTitleWhite = GoogleFonts.poppins(
  fontSize: 18.sp,
  color: Colors.white,
  fontWeight: FontWeight.w600,
);

TextStyle itemTitleDetail = GoogleFonts.poppins(
  fontSize: 14.sp,
  color: black,
  fontWeight: FontWeight.w500,
);

TextStyle itemDateDetail = GoogleFonts.poppins(
  fontSize: 14.sp,
  color: HexColor('#818181'),
  fontWeight: FontWeight.w400,
);

TextStyle itemDescDetail = GoogleFonts.poppins(
  fontSize: 12.sp,
  color: grayUnselect,
  fontWeight: FontWeight.w400,
);

TextStyle descMoreDetail = GoogleFonts.poppins(
  fontSize: 12.sp,
  color: mainColor,
  fontWeight: FontWeight.w600,
);

TextStyle responderDetail = GoogleFonts.poppins(
  fontSize: 12.sp,
  color: HexColor('#818181'),
  fontWeight: FontWeight.w500,
);

TextStyle responderDescDetail = GoogleFonts.poppins(
  fontSize: 12.sp,
  color: HexColor('#818181'),
  fontWeight: FontWeight.w400,
);

TextStyle responderDateDetail = GoogleFonts.poppins(
  fontSize: 11.sp,
  color: secondaryColor,
  fontWeight: FontWeight.w400,
);

//splashscreen
TextStyle titleSplash = GoogleFonts.poppins(
  fontSize: 40.sp,
  color: secondaryColor,
  fontWeight: FontWeight.w600,
);

//dialog

TextStyle popUpWarningTitle = GoogleFonts.poppins(
  fontSize: 15.sp,
  color: Colors.black,
  fontWeight: FontWeight.w500,
);

TextStyle popUpWarningDesc = GoogleFonts.poppins(
  fontSize: 12.sp,
  color: grayUnselect,
  fontWeight: FontWeight.w400,
);

TextStyle whiteOnBtnSmall = GoogleFonts.poppins(
  fontSize: 13.sp,
  color: Colors.white,
  fontWeight: FontWeight.w500,
);

TextStyle subtitleImage = GoogleFonts.poppins(
  fontSize: 10.sp,
  color: Colors.red,
  fontWeight: FontWeight.w400,
);

//admin panel
TextStyle itemTitle = GoogleFonts.poppins(
  fontSize: 12.sp,
  fontWeight: FontWeight.w400,
);

TextStyle usernameTitle = GoogleFonts.poppins(
  fontSize: 14.sp,
  color: accent,
  fontWeight: FontWeight.w500,
);

TextStyle snackBarTitle = GoogleFonts.poppins(
  fontSize: 12.sp,
  fontWeight: FontWeight.w400,
);

//admin officer list
TextStyle officerName = GoogleFonts.poppins(
  fontSize: 14.sp,
  color: Colors.black,
  fontWeight: FontWeight.w500,
);

TextStyle officerRole = GoogleFonts.poppins(
  fontSize: 12.sp,
  color: grayUnselect,
  fontWeight: FontWeight.w400,
);

TextStyle officerCount = GoogleFonts.poppins(
  fontSize: 14.sp,
  color: grayUnselect,
  fontWeight: FontWeight.w500,
);


TextStyle officerTitleBig = GoogleFonts.poppins(
  fontSize: 20.sp,
  color: mainColor,
  fontWeight: FontWeight.w600,
);

TextStyle officerAdd = GoogleFonts.poppins(
  fontSize: 14.sp,
  color: mainColor,
  fontWeight: FontWeight.w600,
);

//complaint Detail
TextStyle subtitleComplaint = GoogleFonts.poppins(
  fontSize: 12.sp,
  color: grayB6,
  fontWeight: FontWeight.w400,
);

TextStyle valueComplaint = GoogleFonts.poppins(
  fontSize: 12.sp,
  color: HexColor('#4D3126'),
  fontWeight: FontWeight.w400,
);

TextStyle titleComplaint = GoogleFonts.poppins(
  fontSize: 12.sp,
  color: black,
  fontWeight: FontWeight.w500,
);

//respond
TextStyle titleMainRespond = GoogleFonts.poppins(
  fontSize: 14.sp,
  color: mainColor,
  fontWeight: FontWeight.w500,
);

TextStyle titleBlackRespond = GoogleFonts.poppins(
  fontSize: 14.sp,
  color: black,
  fontWeight: FontWeight.w500,
);

//profile admin
TextStyle mainUsername = GoogleFonts.poppins(
  fontSize: 16.sp,
  color: Colors.black,
  fontWeight: FontWeight.w600,
);

TextStyle mainRole = GoogleFonts.poppins(
  fontSize: 14.sp,
  color: mainColor,
  fontWeight: FontWeight.w400,
);

TextStyle information = GoogleFonts.poppins(
  fontSize: 14.sp,
  color: black,
  fontWeight: FontWeight.w500,
);

TextStyle profileSub = GoogleFonts.poppins(
  fontSize: 14.sp,
  color: grayUnselect,
  fontWeight: FontWeight.w400,
);

TextStyle profileMain = GoogleFonts.poppins(
  fontSize: 14.sp,
  color: Colors.black,
  fontWeight: FontWeight.w400,
);

TextStyle logoutWhite = GoogleFonts.poppins(
  fontSize: 16.sp,
  color: Colors.white,
  fontWeight: FontWeight.w500,
);

//dashboard admin
TextStyle welcome = GoogleFonts.poppins(
  fontSize: 16.sp,
  color: grayUnselect,
  fontWeight: FontWeight.w400,
);

TextStyle username = GoogleFonts.poppins(
  fontSize: 16.sp,
  color: Colors.black,
  fontWeight: FontWeight.w500,
);

TextStyle chartLegend = GoogleFonts.poppins(
  fontSize: 14.sp,
  color: Colors.black,
  fontWeight: FontWeight.w400,
);

TextStyle totalUser = GoogleFonts.poppins(
  fontSize: 12.sp,
  color: mainColor,
  fontWeight: FontWeight.w500,
);

TextStyle masyarakatDashboard = GoogleFonts.poppins(
  fontSize: 12.sp,
  color: grayB6,
  fontWeight: FontWeight.w500,
);

TextStyle totalDashboard = GoogleFonts.poppins(
  fontSize: 20.sp,
  color: secondaryColor,
  fontWeight: FontWeight.w600,
);



