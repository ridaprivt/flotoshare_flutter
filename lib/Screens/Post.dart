// ignore_for_file: prefer_final_fields, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Post extends StatefulWidget {
  const Post({super.key});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  final TextEditingController _caption = TextEditingController();
  final TextEditingController _user = TextEditingController();
  String imageurl = '';
  XFile? _image;
  final _formKey = GlobalKey<FormState>();
  CollectionReference _reference =
      FirebaseFirestore.instance.collection('Picture_list');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Post',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Container(
        color: Colors.black,
        child: ListView(
          padding: EdgeInsets.all(0),
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  InkWell(
                    onTap: get_Image,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey[800]!,
                          width: 1.0,
                        ),
                      ),
                      child: _image != null
                          ? Image.file(
                              File(_image!.path),
                              fit: BoxFit.cover,
                            )
                          : Center(
                              child: Container(
                                height: 15.h,
                                width: 100.w,
                                alignment: Alignment.center,
                                child: Text(
                                  'Tap to select image',
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _user,
                          style: TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Username',
                            labelStyle: TextStyle(
                              color: Colors.grey[400],
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[800]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[800]!),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          controller: _caption,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your caption';
                            }
                            return null;
                          },
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Caption',
                            labelStyle: TextStyle(
                              color: Colors.grey[400],
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[800]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[800]!),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: updatePost,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      onPrimary: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      'Post',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
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

  void get_Image() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    print('${file?.path}');

    if (file != null) {
      setState(() {
        _image = XFile(file.path);
      });
    }
    if (file == null) return;

    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    //
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child(
        'images'); //this will create directory of images in storage of firebase

    // now to upload the file creating ref of image to be stored
    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);
    try {
      //upload/store image
      await referenceImageToUpload.putFile(File(file!.path));
      imageurl = await referenceImageToUpload.getDownloadURL();
    } catch (e) {
      print(e.toString());
    }
  }

  void updatePost() async {
    if (_formKey.currentState!.validate()) {
      if (imageurl.isEmpty) {
        Get.snackbar(
          'Upload failed',
          'Please select an image',
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        Map<String, dynamic> dataToSend = {
          'name': _user.text,
          'image': imageurl,
          'caption': _caption.text
        };

        // Save the Map to the "post" document with document id "postId" in the "posts" collection
        _reference.add(dataToSend);

        // Show a success message
        Get.snackbar(
          'Upload successful',
          'Your post has been uploaded',
          duration: Duration(seconds: 3),
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Clear the form and image URL
        setState(() {
          // Reset variables and clear form
          imageurl = '';
          _formKey.currentState!.reset();
          _user.clear();
          _caption.clear();
        });
      }
    }
  }
}
