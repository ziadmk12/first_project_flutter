import 'package:first_project/compenent/mydrawer.dart';
import 'package:flutter/material.dart';
import '../compenent/macprolist.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';

class MacPro extends StatefulWidget {
  @override
  _MacProState createState() => _MacProState();
}

class _MacProState extends State<MacPro> {
  var country_pref;

  Future getData() async {
    var url = Uri.parse("http://10.0.2.2:80/flutter_php/index.php");
    var data = {"Cat": "1"};
    var response = await http.post(url, body: data);
    var responsebody = convert.jsonDecode(response.body);
    return responsebody;
  }

  getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      country_pref = prefs.getString('country');
      print(country_pref);
    });
  }

  void initState() {
    // TODO: implement initState

    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Mac Pro',
            style: TextStyle(
                color: Colors.yellowAccent, fontFamily: 'Aardvark Cafe'),
          ),
          backgroundColor: Colors.purple,
          centerTitle: true,
        ),
        drawer: MyDrawer(),
        body: FutureBuilder(
          future: getData(),
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
                    priceUS: snapshot.data[i]['priceUS'],
                    priceUK: snapshot.data[i]['priceUK'],
                    priceFR: snapshot.data[i]['priceFR'],
                    priceMR: snapshot.data[i]['priceMR'],
                    country: country_pref,
                  );
                },
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }
}
