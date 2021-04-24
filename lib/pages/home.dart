import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import '../compenent/mydrawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../compenent/macprolist.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  List listSearch = [];
  var country;
  Future getData() async {
    var url1 = Uri.parse('http://10.0.2.2:80/flutter_php/search.php');
    var response = await http.get(url1);
    var responsebody = convert.jsonDecode(response.body);
    for (int i = 0; i < responsebody.length; i++) {
      listSearch.add(responsebody[i]['name']);
    }
    print(responsebody);
  }

  getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var country = prefs.getString('country');
    print(country);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    getPref();
  }

  @override
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'MobiTech',
            style: TextStyle(color: Colors.yellowAccent),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                    context: context, delegate: DataSearch(list: listSearch));
              },
            ),
          ],
          backgroundColor: Colors.purple,
          //centerTitle: true,
          elevation: 10,
        ),
        drawer: MyDrawer(),
        body: ListView(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              child: Carousel(
                images: [
                  AssetImage(
                    'images/slider/1.jpg',
                  ),
                  AssetImage(
                    'images/slider/2.png',
                  ),
                  AssetImage(
                    'images/slider/3.png',
                  ),
                ],
                dotSize: 7,
                dotBgColor: Colors.purple.withOpacity(0.5),
                indicatorBgPadding: 10,
                boxFit: BoxFit.contain,
                //borderRadius: true,
                overlayShadow: true,
                //overlayShadowColors: Colors.purple,
              ),
              //end carousel
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: Text(
                'Categories',
                style: TextStyle(fontSize: 30, color: Colors.purple),
              ),
            ),
            //start Categorie
            Container(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                      height: 100,
                      width: 100,
                      child: ListTile(
                        title: Image.asset(
                          'images/categories/mac.jpg',
                          fit: BoxFit.fill,
                          width: 80,
                          height: 80,
                        ),
                        subtitle: Container(
                            child: Text(
                          'Mac',
                          textAlign: TextAlign.center,
                        )),
                      )),
                  Container(
                      height: 100,
                      width: 100,
                      child: ListTile(
                        title: Image.asset(
                          'images/categories/iphone.jpg',
                          fit: BoxFit.fill,
                          width: 80,
                          height: 80,
                        ),
                        subtitle: Container(
                            child: Text(
                          'Iphone',
                          textAlign: TextAlign.center,
                        )),
                      )),
                  Container(
                      height: 100,
                      width: 100,
                      child: ListTile(
                        title: Image.asset(
                          'images/categories/ipad.jpg',
                          fit: BoxFit.fill,
                          width: 80,
                          height: 80,
                        ),
                        subtitle: Container(
                            child: Text(
                          'Ipad',
                          textAlign: TextAlign.center,
                        )),
                      )),
                  Container(
                      height: 100,
                      width: 110,
                      child: ListTile(
                        title: Image.asset(
                          'images/categories/ipod.jpg',
                          fit: BoxFit.fill,
                          width: 80,
                          height: 80,
                        ),
                        subtitle: Container(
                            child: Text(
                          'Ipod',
                          textAlign: TextAlign.center,
                        )),
                      )),
                  Container(
                      height: 100,
                      width: 100,
                      child: ListTile(
                        title: Image.asset(
                          'images/categories/imac1.jpg',
                          fit: BoxFit.fill,
                          width: 80,
                          height: 80,
                        ),
                        subtitle: Container(
                            child: Text(
                          'Imac',
                          textAlign: TextAlign.center,
                        )),
                      )),
                ],
              ),
            ),
            //End Categories
            Container(
              padding: EdgeInsets.all(15),
              child: Text(
                'Latest Products',
                style: TextStyle(fontSize: 30, color: Colors.purple),
              ),
            ),
            Container(
              height: 400,
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                children: [
                  InkWell(
                    child: GridTile(
                      child: Image.asset('images/slider/1.jpg'),
                      footer: Container(
                        color: Colors.purple.withOpacity(0.5),
                        child: Text('Iphone 11',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.yellowAccent,
                                fontWeight: FontWeight.w700)),
                      ),
                    ),
                    onTap: () {},
                  ),
                  InkWell(
                    child: GridTile(
                      child: Image.asset('images/slider/2.jpg'),
                      footer: Container(
                        color: Colors.purple.withOpacity(0.5),
                        child: Text(
                          'Iphone 12 pro',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.yellowAccent,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    onTap: () {},
                  ),
                  InkWell(
                    child: GridTile(
                      child: Image.asset('images/slider/3.jpg'),
                      footer: Container(
                        color: Colors.purple.withOpacity(0.5),
                        child: Text(
                          'Iphone 12',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.yellowAccent,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    onTap: () {},
                  ),
                  InkWell(
                    child: GridTile(
                      child: Image.asset('images/slider/4.jpg'),
                      footer: Container(
                        color: Colors.purple.withOpacity(0.5),
                        child: Text(
                          'Iphone 11',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.yellowAccent,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    onTap: () {},
                  ),
                  InkWell(
                    child: GridTile(
                      child: Image.asset('images/slider/6.png'),
                      footer: Container(
                        color: Colors.purple.withOpacity(0.5),
                        child: Text(
                          'Iphone x',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.yellowAccent,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    onTap: () {},
                  ),
                  InkWell(
                    child: GridTile(
                      child: Image.asset('images/slider/1.jpg'),
                      footer: Container(
                        color: Colors.purple.withOpacity(0.5),
                        child: Text(
                          'Iphone 12 pro max',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.yellowAccent,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    onTap: () {},
                  )
                ],
              ),
            )
          ],
        ));
  }
}

class DataSearch extends SearchDelegate<String> {
  @override
  List<dynamic> list;
  DataSearch({this.list});

  Future getMacbyPhone() async {
    var url = Uri.parse("http://10.0.2.2:80/flutter_php/searchByMac.php");
    var data = {"mac": query};
    var response = await http.post(url, body: data);
    var responsebody = convert.jsonDecode(response.body);
    print(responsebody);

    return responsebody;
  }

  List<Widget> buildActions(BuildContext context) {
    // Action for appBar
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icon Leading
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // Results search
    return FutureBuilder(
      future: getMacbyPhone(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, i) {
              return MacList(
                name: snapshot.data[i]['name'],
                ram: snapshot.data[i]['ram'],
                storage: snapshot.data[i]['storage'],
                processor: snapshot.data[i]['processor'],
                price: snapshot.data[i]['price'],
              );
            },
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show what someone search for
    var searchList =
        query.isEmpty ? list : list.where((p) => p.startsWith(query)).toList();
    return ListView.builder(
        itemCount: searchList.length,
        itemBuilder: (context, i) {
          return ListTile(
            leading: Icon(Icons.mobile_screen_share),
            title: Text(searchList[i]),
            onTap: () {
              query = searchList[i];
              showResults(context);
            },
          );
        });
  }
}
