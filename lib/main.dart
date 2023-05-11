// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';
import 'Auth/AuthPage.dart';
import 'Screens/HomePage.dart';
import 'Screens/Post.dart';
import 'Screens/Profile.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return GetMaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          home: MainPage());
    });
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Home();
            } else {
              return AuthPage();
            }
          }),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  myAppController controller = myAppController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<myAppController>(
      // specify type as Controller
      init: myAppController(), // intialize with the Controller
      builder: (myAppController controller) => Scaffold(
        body: Container(
            child: IndexedStack(
          index: controller.myIndex,
          children: [
            HomePage(),
            Post(),
            Profile(),
          ],
        )),
        bottomNavigationBar: BottomAppBar(
            color: Color(0xFF2D2D2D),
            child: Container(
                padding: EdgeInsetsDirectional.only(top: 1.h, bottom: 0.5.h),
                height: 8.h,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MaterialButton(
                        minWidth: 10,
                        onPressed: () {
                          controller.changeIndex(0);
                        },
                        child: Image.asset(
                          'assets/Home.png',
                          color: controller.myIndex == 0
                              ? Color.fromARGB(255, 255, 255, 255)
                              : Color.fromARGB(178, 255, 255, 255),
                        ),
                      ),
                      MaterialButton(
                        minWidth: 10,
                        onPressed: () {
                          controller.changeIndex(1);
                        },
                        child: Image.asset(
                          'assets/Tick-Square.png',
                          color: controller.myIndex == 1
                              ? Color.fromARGB(255, 255, 255, 255)
                              : Color.fromARGB(178, 255, 255, 255),
                        ),
                      ),
                      MaterialButton(
                        minWidth: 10,
                        onPressed: () {
                          controller.changeIndex(2);
                        },
                        child: Image.asset(
                          'assets/Profile.png',
                          color: controller.myIndex == 2
                              ? Color.fromARGB(255, 255, 255, 255)
                              : Color.fromARGB(178, 255, 255, 255),
                        ),
                      ),
                    ]))),
      ),
    );
  }
}

class myAppController extends GetxController {
  var myIndex = 0;

  void changeIndex(int index) {
    myIndex = index;
    update();
  }
}
