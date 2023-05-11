// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile',
            style: GoogleFonts.roboto(
                textStyle: TextStyle(
                    fontSize: 19.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white))),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    radius: 40.0,
                    backgroundImage: AssetImage('assets/me.png'),
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Username',
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    fontSize: 19.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white))),
                        SizedBox(height: 8.0),
                        Text('123k followers • 456 following',
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white))),
                      ]),
                ],
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            ListTile(
              leading: Icon(
                Icons.bookmark_border,
                color: Colors.white,
              ),
              title: Text('Saved',
                  style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          fontSize: 17.5.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.white))),
              onTap: () {
                // Navigate to saved posts page
              },
            ),
            Divider(
              color: Colors.grey,
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              title: Text('Settings',
                  style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          fontSize: 17.5.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.white))),
              onTap: () {
                // Navigate to settings page
              },
            ),
            Divider(
              color: Colors.grey,
            ),
            SizedBox(height: 2.h),
            Container(
              width: 100.w,
              child: ElevatedButton(
                onPressed: () => FirebaseAuth.instance.signOut(),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text('Sign Out',
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            fontSize: 17.5.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
