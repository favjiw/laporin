import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:laporin/admin/screen/panel/panel_screen.dart';
import 'package:laporin/services/auth.dart';
import 'package:laporin/shared/style.dart';
import 'package:laporin/widget/botnavbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  late bool _isPasswordVisible;
  final TextEditingController _emailController = TextEditingController(text: 'this.admin@gmail.com');
  final TextEditingController _passwordController = TextEditingController(text: '12345678');

  @override
  void initState() {
    // TODO: implement initState
    _isLoading = false;
    _isPasswordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        backgroundColor: accent,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  "assets/login-img.png",
                  width: 180.w,
                  height: 215.h,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 17.h,
                    ),
                    Text(
                      "Login",
                      style: loginTitle,
                    ),
                    SizedBox(
                      height: 21.h,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _emailController,
                            style: inputLogin,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email Required';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "Email",
                              hintStyle: hintLogin,
                              prefixIcon: Image.asset(
                                "assets/ic-at-sign.png",
                                width: 20.w,
                                height: 20.h,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 21.h,
                          ),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: !_isPasswordVisible,
                            style: inputLogin,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password Required';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                              hintText: "Password",
                              hintStyle: hintLogin,
                              prefixIcon: Image.asset(
                                "assets/ic-lock.png",
                                width: 20.w,
                                height: 20.h,
                              ),
                              // prefixIcon: Icon(Icons.alternate_email_rounded, color: grayUnselect,),
                            ),
                          ),
                          SizedBox(
                            height: 13.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Forgot Password?",
                                  style: forgotPassword,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 13.h,
                          ),
                          SizedBox(
                            width: 315.w,
                            height: 50.h,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: secondaryColor,
                              ),
                              onPressed: () {
                                login(_emailController.text,
                                    _passwordController.text);
                              },
                              child: Text(
                                "Login",
                                style: loginBtn,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Belum memiliki akun? ",
                            style: noAccLogin,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/signup');
                            },
                            child: Text(
                              "Sign Up",
                              style: forgotPassword,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future login(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      _showLoadingIndicator(context);
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        //do something with logged user
        Navigator.pushNamedAndRemoveUntil(
            context, '/botnavbar', (route) => false);
        buildSnackBarSuccess(context, "Login Success");
        print('user logged in');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('User dengan email tersebut belum terdaftar. Mencoba di firestore');
          try{
            final users = await FirebaseFirestore.instance
                .collection('users')
                .where('email', isEqualTo: email)
                .limit(1)
                .get();

            if (users.docs.isNotEmpty) {
              final user = users.docs.first.data();
              if (user['password'] == password) {
                // Login berhasil, menyimpan informasi pengguna ke dalam state aplikasi
                // dan beralih ke halaman utama
                final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.setString('uid', user['id']);
                print(sharedPreferences.get('uid'));
                if(user['role'] == 'officer' || user['role'] == 'admin'){
                  Navigator.of(context).pushNamedAndRemoveUntil('/menu-panel', (route) => false);
                  buildSnackBarSuccess(context, "Login Success as Officer");
                }else if(user['role'] == 'admin'){
                  Navigator.of(context).pushNamedAndRemoveUntil('/menu-panel', (route) => false);
                  buildSnackBarSuccess(context, "Login Success as Admin");
                }
              } else {
                // Password salah
                buildSnackBarError(context, "Wrong Password");

              }
            } else {
              //user not found
              buildSnackBarError(context, "Please Register First");

            }
          }catch(e){
            print(e);
          }
        } else if (e.code == 'wrong-password') {
          print('Password yang dimasukkan salah.');
          buildSnackBarError(context, "Wrong Password");
        }
      }
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).maybePop();
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

void buildSnackBarError(BuildContext context, String title) {
  final snackBar = SnackBar(
    content: Text(title, style: snackBarTitle,),
    backgroundColor: HexColor('#FF6C6C'),
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.all(20),
    elevation: 30,
    action: SnackBarAction(
      label: 'Dismiss',
      disabledTextColor: Colors.white,
      textColor: Colors.yellow,
      onPressed: () {
        //Do whatever you want
      },
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void buildSnackBarSuccess(BuildContext context, String title) {
  final snackBar = SnackBar(
    content: Text(title, style: snackBarTitle,),
    backgroundColor: mainColor,
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.all(20),
    elevation: 30,
    action: SnackBarAction(
      label: 'Dismiss',
      disabledTextColor: Colors.white,
      textColor: Colors.yellow,
      onPressed: () {
        //Do whatever you want
      },
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}