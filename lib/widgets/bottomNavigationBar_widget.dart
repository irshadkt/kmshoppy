import 'package:flutter/material.dart';

class BottomBarListWidget extends StatelessWidget {
  const BottomBarListWidget({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: BottomNavigationBar(
        elevation: 8.0,
        currentIndex: 0,
        backgroundColor: Colors.white,
        //fixedColor: Colors.black,
        unselectedLabelStyle: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
        selectedLabelStyle: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
        //unselectedLabelStyle: FontWeight.bold,
        selectedIconTheme: const IconThemeData(
          color: Colors.indigo,
        ),
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.black,
        unselectedIconTheme: const IconThemeData(color: Colors.black),
        onTap: (index) {},
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 25,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search_rounded,
                size: 25,
                // color: Colors.black,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.play_arrow,
                size: 25,
                // color: Colors.black,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.comment_rounded,
                size: 25,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.account_box_sharp,
                size: 25,
                //color: Colors.black,
              ),
              label: ""),

        ],
      ),
    );
  }
}
