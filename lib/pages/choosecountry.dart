import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class ChooseCountry extends StatefulWidget {
  @override
  _ChooseCountryState createState() => _ChooseCountryState();
}

class _ChooseCountryState extends State<ChooseCountry> {
  savePref(String country) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('country', country);
    print(prefs.getString('country'));
  }

  getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var country = prefs.getString('country');
    if (country != null) {
      Navigator.of(context).pushNamed('home');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Country'),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(50),
        child: ListView(
          children: [
            ListTile(
              title: Text('Morocco'),
              onTap: () {
                savePref('Morocco');
              },
              trailing: Image.asset(
                'images/flags/mr.png',
                width: 40,
                height: 40,
              ),
            ),
            ListTile(
              title: Text('France'),
              onTap: () {
                savePref('France');
              },
              trailing: Image.asset(
                'images/flags/fr.png',
                width: 40,
                height: 40,
              ),
            ),
            ListTile(
              title: Text('United Kingdom'),
              onTap: () {
                savePref('United Kingdom');
              },
              trailing: Image.asset(
                'images/flags/uk.png',
                width: 40,
                height: 40,
              ),
            ),
            ListTile(
              title: Text('United States'),
              onTap: () {
                savePref('United States');
              },
              trailing: Image.asset(
                'images/flags/us.png',
                width: 40,
                height: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
