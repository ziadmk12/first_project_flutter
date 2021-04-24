import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// class MyDrawer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {

//   }
// }
class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  bool isSignIn = false;
  var username;
  var email;
  getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    username = prefs.getString('username');
    email = prefs.getString('email');

    if (username != null) {
      setState(() {
        username = prefs.getString('username');
        email = prefs.getString('email');
        isSignIn = true;
      });
    }
  }

  void initState() {
    // TODO: implement initState
    getPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountEmail: isSignIn ? Text(email) : Text(''),
            accountName: isSignIn ? Text(username) : Text(''),
            currentAccountPicture: CircleAvatar(child: Icon(Icons.person)),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/drawer.png"), fit: BoxFit.cover)),
          ),
          ListTile(
            title: Text(
              'Home',
              style: TextStyle(fontSize: 17),
            ),
            leading: Icon(
              Icons.home,
              color: Colors.purple,
            ),
            // subtitle: Text('Home Page'),
            // isThreeLine: true,
            // dense: true,
            // contentPadding: EdgeInsets.all(10),
            onTap: () {
              Navigator.of(context).pushNamed('home');
            },
          ),
          ListTile(
            title: Text(
              'Categories',
              style: TextStyle(fontSize: 17),
            ),
            leading: Icon(
              Icons.category,
              color: Colors.purple,
            ),
            // subtitle: Text('Home Page'),
            // isThreeLine: true,
            // dense: true,
            // contentPadding: EdgeInsets.all(10),
            onTap: () {
              Navigator.of(context).pushNamed('categories');
            },
          ),
          isSignIn
              ? ListTile(
                  title: Text(
                    'Add post',
                    style: TextStyle(fontSize: 17),
                  ),
                  leading: Icon(
                    Icons.post_add,
                    color: Colors.purple,
                  ),
                  // subtitle: Text('Home Page'),
                  // isThreeLine: true,
                  // dense: true,
                  // contentPadding: EdgeInsets.all(10),
                  onTap: () {
                    Navigator.of(context).pushNamed('post');
                  },
                )
              : SizedBox(
                  height: 0,
                ),
          ListTile(
            title: Text(
              'Contact us',
              style: TextStyle(fontSize: 17),
            ),
            leading: Icon(
              Icons.contact_page,
              color: Colors.purple,
            ),
            // subtitle: Text('Home Page'),
            // isThreeLine: true,
            // dense: true,
            // contentPadding: EdgeInsets.all(10),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              'About us',
              style: TextStyle(fontSize: 17),
            ),
            leading: Icon(
              Icons.info,
              color: Colors.purple,
            ),
            // subtitle: Text('Home Page'),
            // isThreeLine: true,
            // dense: true,
            // contentPadding: EdgeInsets.all(10),
            onTap: () {},
          ),
          Divider(
            color: Colors.purple,
            height: 15,
          ),
          ListTile(
            title: Text(
              'Settings',
              style: TextStyle(fontSize: 17),
            ),
            leading: Icon(
              Icons.settings,
              color: Colors.purple,
            ),
            // subtitle: Text('Home Page'),
            // isThreeLine: true,
            // dense: true,
            // contentPadding: EdgeInsets.all(10),
            onTap: () {},
          ),
          isSignIn
              ? ListTile(
                  title: Text(
                    'Logout',
                    style: TextStyle(fontSize: 17),
                  ),
                  leading: Icon(
                    Icons.logout,
                    color: Colors.purple,
                  ),
                  // subtitle: Text('Home Page'),
                  // isThreeLine: true,
                  // dense: true,
                  // contentPadding: EdgeInsets.all(10),
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.remove('username');
                    prefs.remove('email');
                    Navigator.of(context).pushNamed('login');
                  },
                )
              : ListTile(
                  title: Text(
                    'Login',
                    style: TextStyle(fontSize: 17),
                  ),
                  leading: Icon(
                    Icons.logout,
                    color: Colors.purple,
                  ),
                  // subtitle: Text('Home Page'),
                  // isThreeLine: true,
                  // dense: true,
                  // contentPadding: EdgeInsets.all(10),
                  onTap: () {
                    Navigator.of(context).pushNamed('login');
                  },
                ),
        ],
      ),
    );
  }
}
