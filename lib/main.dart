import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import 'package:demo/HomePageModule/home_page.dart';
import 'package:demo/LiveModule/live.dart';
import 'package:demo/CourseModule/course.dart';
import 'package:demo/MyModule/my.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  List<Widget> _pageList = [
    HomePage(),
    Live(),
    Course(),
    My(),
  ];
  // List _appBarTitleList = ['首页', '直播', '课程', '我的'];
  @override
  Widget build(BuildContext context) {
    // var appBar1 = AppBar(
    //   title: Text(_appBarTitleList[_currentIndex]),
    // );
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return MaterialApp(
      home: Scaffold(
        // appBar: appBar1,
        body: this._pageList[this._currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int index) {
            setState(() {
              this._currentIndex = index;
            });
          },
          currentIndex: this._currentIndex,
          fixedColor: Color.fromARGB(255, 233, 63, 53),
          selectedLabelStyle: TextStyle(
              color: Color.fromARGB(255, 233, 63, 53),
              fontSize: 10,
              fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(
              color: Color.fromARGB(255, 153, 153, 153),
              fontSize: 10,
              fontWeight: FontWeight.bold),
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Image(
                  image: AssetImage(
                      'assets/images/Tabbar/tabar_home_normal_icon.png'),
                  width: 32,
                  height: 27,
                ),
                activeIcon: Image(
                  image: AssetImage(
                      'assets/images/Tabbar/tabar_home_selected_icon.png'),
                  width: 32,
                  height: 27,
                ),
                title: Text('首页')),
            BottomNavigationBarItem(
                icon: Image(
                  image: AssetImage(
                      'assets/images/Tabbar/tabar_live_radio_normal_icon.png'),
                  width: 32,
                  height: 27,
                ),
                activeIcon: Image(
                  image: AssetImage(
                      'assets/images/Tabbar/tabar_live_radio_selected_icon.png'),
                  width: 32,
                  height: 27,
                ),
                title: Text('直播')),
            BottomNavigationBarItem(
                icon: Image(
                  image: AssetImage(
                      'assets/images/Tabbar/tabar_course_normal_icon.png'),
                  width: 32,
                  height: 27,
                ),
                activeIcon: Image(
                  image: AssetImage(
                      'assets/images/Tabbar/tabar_course_selected_icon.png'),
                  width: 32,
                  height: 27,
                ),
                title: Text('课程')),
            BottomNavigationBarItem(
                icon: Image(
                  image: AssetImage(
                      'assets/images/Tabbar/tabar_me_normal_icon.png'),
                  width: 32,
                  height: 27,
                ),
                activeIcon: Image(
                  image: AssetImage(
                      'assets/images/Tabbar/tabar_me_selected_icon.png'),
                  width: 32,
                  height: 27,
                ),
                title: Text('我的'))
          ],
        ),
      ),
    );
  }
}
// This widget is the root of your application.
