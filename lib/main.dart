import 'package:flutter/material.dart';
import 'package:news_app/screens/navigation_screen.dart';
import 'package:news_app/screens/test_screen.dart';
import 'package:news_app/screens/web_view.dart';
import './screens/news_detail.dart';
import 'package:provider/provider.dart';
import 'providers/news_provider.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NewsProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          hintColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.black),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: Theme.of(context).iconTheme,
          ),
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.black),
        ),
        home: AnimatedSplashScreen(
          splash: Text(
            'News App',
            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          ),
          nextScreen: NavigationScreen(),
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: Colors.white,
        ),
        routes: {
          NewsDetail.routeName: (context) => NewsDetail(),
          CustomWebView.routeName: (context) => CustomWebView(),
          TestScreen.routeName: (context) => TestScreen()
        },
      ),
    );
  }
}
