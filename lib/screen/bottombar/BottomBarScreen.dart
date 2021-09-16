import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:superindo/constant/Constant.dart';
import 'package:superindo/screen/home/HomeScreen.dart';
import 'package:superindo/screen/profile/ProfileScreen.dart';

class BottomBarScreen extends StatefulWidget {
  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen>{
  PageController controller = new PageController();
  int _currentIndex = 0;

  List children = [
    HomeScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    timeDilation = 1;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constant.swatch.PRIMARY,
        title: Image.asset(
          "assets/logo-superindo.png",
          width: 50,
          height: 50,
        ),
        centerTitle: true,
      ),
      body: PageView.builder(
        onPageChanged: (page) {

        },
        controller: controller,
        itemCount: 2,
        itemBuilder: (context, position) {
          return children[position];
        },
      ),
      floatingActionButton:FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, Pages.PRODUCT_ADD_SCREEN).then((value) {
            setState(() {

            });
          });
        },
        backgroundColor: Constant.swatch.PRIMARY,
        child: Icon(Icons.add),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Constant.swatch.PRIMARY,
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        child: Row(
          // mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(icon: Icon(Icons.home, color: Colors.white,), onPressed: () {controller.jumpToPage(0);},),
            IconButton(icon: Icon(Icons.person, color: Colors.white,), onPressed: () {controller.jumpToPage(1);},),
          ],
        ),
      ),
    );
  }
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
