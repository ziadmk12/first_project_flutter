import 'package:flutter/material.dart';
import '../compenent/mydrawer.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Categories',
            style: TextStyle(
                color: Colors.yellowAccent, fontFamily: 'Aardvark Cafe'),
          ),
          backgroundColor: Colors.purple,
          centerTitle: true,
        ),
        drawer: MyDrawer(),
        body: GridView(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          children: [
            // Categories 1
            InkWell(
              child: Card(
                  child: Column(
                children: [
                  Expanded(
                      child: Image.asset(
                    'images/categories/mac.jpg',
                    fit: BoxFit.contain,
                    height: 200,
                    width: 200,
                  )),
                  Container(
                      child: Text(
                    'Mac book pro',
                    style: TextStyle(fontSize: 15),
                  ))
                ],
              )),
              onTap: () {
                Navigator.of(context).pushNamed('macpro');
              },
            ),

            // End Cat 1
            InkWell(
              child: Card(
                  child: Column(
                children: [
                  Expanded(
                      child: Image.asset(
                    'images/categories/iphone.jpg',
                    fit: BoxFit.contain,
                    height: 100,
                    width: 100,
                  )),
                  Container(
                      child: Text(
                    'Iphone',
                    style: TextStyle(fontSize: 15),
                  ))
                ],
              )),
              onTap: () {},
            ),

            InkWell(
              child: Card(
                  child: Column(
                children: [
                  Expanded(
                      child: Image.asset(
                    'images/categories/ipad.jpg',
                    fit: BoxFit.contain,
                    height: 100,
                    width: 100,
                  )),
                  Container(
                      child: Text(
                    'Ipad',
                    style: TextStyle(fontSize: 15),
                  ))
                ],
              )),
              onTap: () {},
            ),

            InkWell(
              child: Card(
                  child: Column(
                children: [
                  Expanded(
                      child: Image.asset(
                    'images/categories/ipod.jpg',
                    fit: BoxFit.contain,
                    height: 150,
                    width: 150,
                  )),
                  Container(
                      child: Text(
                    'Ipod',
                    style: TextStyle(fontSize: 15),
                  ))
                ],
              )),
              onTap: () {},
            ),

            InkWell(
              child: Card(
                  child: Column(
                children: [
                  Expanded(
                      child: Image.asset(
                    'images/categories/imac1.jpg',
                    fit: BoxFit.contain,
                    height: 200,
                    width: 200,
                  )),
                  Container(
                      child: Text(
                    'Imac',
                    style: TextStyle(fontSize: 15),
                  ))
                ],
              )),
              onTap: () {},
            )
          ],
        ));
  }
}
