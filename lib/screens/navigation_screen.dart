import 'package:flutter/material.dart';
import 'package:news_app/screens/favorites_screen.dart';
import 'package:news_app/screens/home_screen.dart';

import '../path_painter.dart';

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _page = 0;
  final screens = [
    HomePage(),
    FavoritesScreen()
  ];

  Widget navigationItem(width, page) {
    return GestureDetector(
      onTap: () {
        setState(
          () {
            _page = page;
          },
        );
      },
      child: Container(
        width: width / 2,
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
          ),
        ),
        child: Icon(
          page == 0 ? Icons.home : Icons.favorite, 
          color: page == _page ? Colors.white : Colors.black,
          size: 30,
          )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: CustomPaint(
        painter: PathPainter(_page),
        child: Container(
          width: width,
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              navigationItem(width, 0),
              navigationItem(width, 1),
            ],
          ),
        ),
      ),
        body: screens[_page],
      ),
    );
  }
}
