import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:laporin/admin/service/respond.dart';
import 'package:laporin/shared/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ComplaintRespond extends StatefulWidget {
  final dynamic complaint;

  const ComplaintRespond({Key? key, required this.complaint}) : super(key: key);

  @override
  State<ComplaintRespond> createState() => _ComplaintRespondState();
}

class _ComplaintRespondState extends State<ComplaintRespond> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  dynamic complaint;
  String? uid;
  TextEditingController _respond = TextEditingController();
  int? _selectedValue;

  void _handleRadioValueChanged(int? value) {
    setState(() {
      _selectedValue = value!;
    });
  }

  void _setStatus() async {
    setState(() {
      _selectedValue = complaint['status'];
    });
  }

  void _getSharedPrefs() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = _prefs.getString('uid');
    });
  }

  @override
  void initState() {
    complaint = widget.complaint;
    _getSharedPrefs();
    _setStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
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
            "Tanggapan",
            style: appBarTitle,
          ),
          actions: [
            TextButton(onPressed: (){
              if(_formKey.currentState!.validate()){
                setState(() {
                  _isLoading = true;
                });
                _showLoadingIndicator(context);
                respondAdd(_respond.text, complaint['id'], _selectedValue!, uid!).then((value){
                  setState(() {
                    _isLoading = false;
                  });
                  Navigator.of(context).pop();
                  buildSuccessSubmitDialog(context).show();
                }).catchError((error){
                  setState(() {
                    _isLoading = false;
                  });
                  print(error);
                });
              }
            }, child: Text('Submit')),
          ],
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30.h,),
                  RichText(
                    text: TextSpan(
                      text: "Berikan tanggapan kamu terhadap pengaduan ",
                      style: titleMainRespond,
                      children: [
                        TextSpan(text: complaint['title'], style: titleBlackRespond),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  Stack(
                    children: [
                      Container(
                        width: 325.w,
                        height: 151.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.r),
                          border: Border.all(color: HexColor('#CECECE')),
                        ),
                      ),
                      SizedBox(
                        width: 325.w,
                        height: 171.h,
                        child: TextFormField(
                          controller: _respond,
                          maxLines: 10,
                          style: inputComplaint,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Isi Tanggapan';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 5.w, right: 3.w, top: 5.h ),
                            hintText: "Isi tanggapanmu di sini",
                            hintStyle: hintComplaint,
                            border: UnderlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  RadioListTile(
                    activeColor: HexColor('#FF0000'),
                    contentPadding: EdgeInsets.zero,
                    title: Text('Diajukan', style: itemStatusRed),
                    value: 0,
                    groupValue: _selectedValue,
                    onChanged: _handleRadioValueChanged,
                  ),
                  RadioListTile(
                    activeColor: HexColor('#E4DA00'),
                    contentPadding: EdgeInsets.zero,
                    title: Text('Diproses', style: itemStatusYellow),
                    value: 1,
                    groupValue: _selectedValue,
                    onChanged: _handleRadioValueChanged,
                  ),
                  RadioListTile(
                    activeColor: mainColor,
                    contentPadding: EdgeInsets.zero,
                    title: Text('Selesai', style: itemStatusGreen),
                    value: 2,
                    groupValue: _selectedValue,
                    onChanged: _handleRadioValueChanged,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void _showLoadingIndicator(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Container(
          height: 64.h,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    },
  );
}

AwesomeDialog buildSuccessSubmitDialog(BuildContext context) {
  return AwesomeDialog(
    context: context,
    dialogType: DialogType.success,
    headerAnimationLoop: false,
    animType: AnimType.bottomSlide,
    title: 'Berhasil mengirim tanggapan!',
    titleTextStyle: popUpWarningTitle,
    desc: 'Kamu sudah berhasil mengirim tanggapan terhadap pengaduan ini.',
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
