import 'package:flutter/material.dart'; // ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Post.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<FeedPost> posts = [];

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('Picture_list')
          .get(); // Replace 'Picture_list' with the actual collection name

      final List<FeedPost> fetchedPosts = snapshot.docs.map((doc) {
        final data = doc.data();
        return FeedPost(
          username: data['name'] ?? '',
          caption: data['caption'] ?? '',
          imageUrl: data['image'] ?? '',
        );
      }).toList();

      setState(() {
        posts.addAll(fetchedPosts.reversed);
      });
    } catch (e) {
      print('Error fetching posts: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'FlotoShare',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.black,
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (BuildContext context, int index) {
          return FeedPostItem(post: posts[index]);
        },
      ),
    );
  }
}

class FeedPost {
  final String username;
  final String caption;
  final String imageUrl;
  //final String pfp;

  FeedPost({
    required this.username,
    required this.caption,
    required this.imageUrl,
    //required this.pfp,
  });
}

class FeedPostItem extends StatelessWidget {
  final FeedPost post;

  const FeedPostItem({required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // CircleAvatar(
              //   radius: 15,
              //   backgroundImage: AssetImage(post.pfp),
              // ),
              SizedBox(width: 2),
              Text(post.username,
                  style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white))),
            ],
          ),
          SizedBox(height: 8),
          Image.network(
            post.imageUrl,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ImageIcon(
                AssetImage('assets/Icon.png'),
                color: Colors.white,
                size: 22.sp,
              ),
              SizedBox(width: 8),
              ImageIcon(
                AssetImage('assets/Comment.png'),
                color: Colors.white,
                size: 22.sp,
              ),
              SizedBox(width: 8),
              ImageIcon(
                AssetImage('assets/Send.png'),
                color: Colors.white,
                size: 24.sp,
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: post.username,
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      TextSpan(
                        text: ' ',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      TextSpan(
                        text: post.caption,
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 0.5.h),
        ],
      ),
    );
  }
}
