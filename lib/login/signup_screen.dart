import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laporin/services/auth.dart';
import 'package:laporin/shared/style.dart';
import 'package:firebase_auth/firebase_auth.dart';

final navigatorKey = GlobalKey<NavigatorState>();
class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 45.h,
            ),
            Center(
              child: Image.asset(
                "assets/signup-img.png",
                width: 180.w,
                height: 180.h,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 7.h,
                  ),
                  Text(
                    "Sign Up",
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
                          controller: _fullnameController,
                          style: inputLogin,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Fullname required';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Nama Lengkap",
                            hintStyle: hintLogin,
                            prefixIcon: Image.asset(
                              "assets/ic-fullname.png",
                              width: 20.w,
                              height: 20.h,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 21.h,
                        ),
                        TextFormField(
                          controller: _nikController,
                          style: inputLogin,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'NIK required';
                            }else if(value.length != 16){
                              return 'NIK perlu 16 digit';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "NIK",
                            hintStyle: hintLogin,
                            prefixIcon: Image.asset(
                              "assets/ic-idcard.png",
                              width: 20.w,
                              height: 20.h,
                            ),
                            // prefixIcon: Icon(Icons.alternate_email_rounded, color: grayUnselect,),
                          ),
                        ),
                        SizedBox(
                          height: 21.h,
                        ),
                        TextFormField(
                          controller: _phoneController,
                          style: inputLogin,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Phone required';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "Telepon",
                            hintStyle: hintLogin,
                            prefixIcon: Image.asset(
                              "assets/ic-phonenumber.png",
                              width: 20.w,
                              height: 20.h,
                            ),
                            // prefixIcon: Icon(Icons.alternate_email_rounded, color: grayUnselect,),
                          ),
                        ),
                        SizedBox(
                          height: 21.h,
                        ),
                        TextFormField(
                          controller: _usernameController,
                          style: inputLogin,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Username required';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Username",
                            hintStyle: hintLogin,
                            prefixIcon: Image.asset(
                              "assets/ic-username.png",
                              width: 20.w,
                              height: 20.h,
                            ),
                            // prefixIcon: Icon(Icons.alternate_email_rounded, color: grayUnselect,),
                          ),
                        ),
                        SizedBox(
                          height: 21.h,
                        ),
                        TextFormField(
                          controller: _emailController,
                          style: inputLogin,
                          keyboardType: TextInputType.emailAddress,
                          // autovalidateMode: AutovalidateMode.onUserInteraction,
                          // validator: (email) =>
                          //     email != null
                          //         ? 'Enter a valid email'
                          //         : null,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email required';
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
                            // prefixIcon: Icon(Icons.alternate_email_rounded, color: grayUnselect,),
                          ),
                        ),
                        SizedBox(
                          height: 21.h,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          style: inputLogin,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          // validator: (value) => value != null && value.length >= 8
                          //     ? 'Enter min. 8 characters'
                          //     : null,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password required';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: hintLogin,
                            prefixIcon: Image.asset(
                              "assets/ic-lock.png",
                              width: 20.w,
                              height: 20.h,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        SizedBox(
                          width: 315.w,
                          height: 50.h,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: secondaryColor,
                            ),
                            onPressed: () async {
                              signUp();
                            },
                            child: Text(
                              "Sign Up",
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
                          "Sudah memiliki akun? ",
                          style: noAccLogin,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Login",
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
    );
  }
  Future signUp() async {
    if(_formKey.currentState!.validate()){
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()),
      );
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
            email: _emailController.text,
            password: _passwordController.text);
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/botnavbar',
                (Route<dynamic> route) => false);
        userSetup(
            _fullnameController.text,
            int.parse(_nikController.text),
            _phoneController.text,
            _usernameController.text,
            _emailController.text);
      } on FirebaseAuthException catch (e) {
        print(e);
        _emailController.text = "";
        _passwordController.text = "";
      }
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
