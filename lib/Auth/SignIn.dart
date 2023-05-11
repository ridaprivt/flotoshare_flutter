// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'SignUp.dart';
import 'package:auth/main.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final email = TextEditingController();
  final pw = TextEditingController();
  @override
  void dispose() {
    email.dispose();
    pw.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        padding: EdgeInsets.all(0),
        children: [
          SizedBox(height: 40.h),
          Container(
            padding: EdgeInsets.only(left: 7.w, right: 7.w, top: 1.2.h),
            height: 60.h,
            width: 100.w,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.sp),
                    topRight: Radius.circular(25.sp))),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 0.6.h,
                        width: 22.w,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20.sp)),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Text('Sign  In',
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              fontSize: 23.sp, fontWeight: FontWeight.bold))),
                  SizedBox(height: 3.h),
                  box('Email', TextInputType.emailAddress, email, false),
                  SizedBox(height: 2.h),
                  box('Password', TextInputType.visiblePassword, pw, true),
                  SizedBox(height: 2.5.h),
                  GestureDetector(
                    onTap: SignIn,
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(left: 2.w),
                      height: 5.3.h,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20.sp),
                        border: Border.all(
                            width: 0.2.w,
                            color: Color.fromARGB(255, 206, 206, 206)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 15,
                            offset: Offset(5, 12), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Text('Login Account',
                          style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  fontSize: 16.5.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Container(
                      margin: EdgeInsets.only(left: 2.w, right: 2.w),
                      child: Divider(
                        color: Colors.grey,
                        height: 2.h,
                      )),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('  Do you have an account?',
                          style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  fontSize: 15.5.sp,
                                  fontWeight: FontWeight.w500))),
                      GestureDetector(
                        onTap: () {
                          Get.to(SignUp());
                        },
                        child: Text(' Sign Up',
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    fontSize: 15.7.sp,
                                    fontWeight: FontWeight.bold))),
                      ),
                    ],
                  ),
                ]),
          ),
        ],
      ),
    );
  }

  Future SignIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(
                color: Colors.grey,
              ),
            ));

    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text.trim(), password: pw.text.trim());

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  box(String hint, TextInputType typ, TextEditingController controller,
      bool what) {
    return Container(
      padding: EdgeInsets.only(left: 2.w),
      height: 5.h,
      decoration: BoxDecoration(
        color: Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(20.sp),
        border:
            Border.all(width: 0.2.w, color: Color.fromARGB(255, 206, 206, 206)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 15,
            offset: Offset(5, 12), // changes position of shadow
          ),
        ],
      ),
      child: TextField(
        obscureText: what,
        controller: controller,
        style: TextStyle(
            fontSize: 16.5.sp,
            fontWeight: FontWeight.w400,
            color: Colors.black),
        decoration: InputDecoration(
          hintText: hint,
          contentPadding: EdgeInsets.only(top: 1.h, bottom: 1.6.h),
          hintStyle: TextStyle(
              color: Color.fromARGB(169, 0, 0, 0),
              fontWeight: FontWeight.w400,
              fontSize: 16.5.sp),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(0, 44, 44, 44))),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            color: Color.fromARGB(0, 44, 44, 44),
          )),
          prefixIcon: Image.asset(
            'assets/lock.png',
            height: 5.h,
          ),
        ),
        keyboardType: typ,
      ),
    );
  }
}
