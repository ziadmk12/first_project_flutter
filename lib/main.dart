import 'package:first_project/pages/categories.dart';
import 'package:first_project/pages/comments.dart';
import 'package:first_project/pages/home.dart';
import 'package:first_project/pages/login.dart';
import 'package:first_project/pages/post.dart';
import 'package:first_project/pages/test2.dart';
import 'package:flutter/material.dart';
import './pages/home.dart';
import './pages/categories.dart';
import '/compenent/macprolist.dart';
import '/pages/macpro.dart';
import '/pages/macprodetails.dart';
import '/pages/test2.dart';
import 'pages/home.dart';
import 'pages/choosecountry.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'mobitech',
        theme: ThemeData(fontFamily: 'Raleway'),
        //theme: ThemeData(fontFamily: 'Noto Sans JP'),
        home: Login(),
        routes: {
          'categories': (context) {
            return Categories();
          },
          'home': (context) {
            return Home();
          },
          'macpro': (context) {
            return MacPro();
          },
          'choosecountry': (context) {
            return ChooseCountry();
          },
          'login': (context) {
            return Login();
          },
          'post': (context) {
            return Post();
          },
          'comments': (context) {
            return Comments();
          },
        });
  }
}
