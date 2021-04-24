import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:async';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  Future getData() async {
    var url = Uri.parse("http://10.0.2.2:80/flutter_php/index.php");

    var response = await http.get(url);
    var responsebody = convert.jsonDecode(response.body);
    print(responsebody);
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Title'),
        ),
        body: FutureBuilder(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Container(child: Text(snapshot.data[0]['id']));
              }
              return CircularProgressIndicator();
            }));
  }
}
