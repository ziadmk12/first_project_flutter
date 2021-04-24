import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController username = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController confirmpassword = new TextEditingController();
  GlobalKey<FormState> formstatesignup = new GlobalKey<FormState>();
  GlobalKey<FormState> formstatesignin = new GlobalKey<FormState>();
  Pattern pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
  showdialog(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Row(
              children: [Text('Loading '), CircularProgressIndicator()],
            ),
          );
        });
  }

  showdialogAll(context, String mytitle, String mycontent) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(mycontent),
            title: Text(mytitle),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('done'),
              ),
            ],
          );
        });
  }

  savePref(String id, String username, String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('id', id);
    prefs.setString('username', username);
    prefs.setString('email', email);
    print(prefs.getString('username'));
    print(prefs.getString('email'));
    print(prefs.getString('id'));
  }

  signin() async {
    var formdata = formstatesignin.currentState;
    if (formdata.validate()) {
      formdata.save();

      //showdialog(context);
      var data = {'email': email.text, 'password': password.text};
      var url = Uri.parse('http://10.0.2.2:80/flutter_php/login.php');
      var response = await http.post(url, body: data);
      var responsebody = convert.jsonDecode(response.body);
      if (responsebody['status'] == 'success') {
        savePref(responsebody['id'], responsebody['username'],
            responsebody['email']);
        Navigator.of(context).pushNamed('home');
      } else {
        showdialogAll(context, 'Faild', 'email or password incorrect');
      }
    } else {
      print('no valid');
    }
  }

  signup() async {
    var formdata = formstatesignup.currentState;
    if (formdata.validate()) {
      formdata.save();
      var data = {
        'username': username.text,
        'email': email.text,
        'password': password.text
      };
      var url = Uri.parse('http://10.0.2.2:80/flutter_php/signup.php');
      var response = await http.post(url, body: data);
      var responsebody = convert.jsonDecode(response.body);
      if (responsebody['status'] == 'success') {
        print('succes');
        Navigator.of(context).pushNamed('home');
      } else {
        showdialogAll(context, 'Faild', 'this email is used before');
      }
    } else {
      print('no valid');
    }
  }

  String validGlobal(String val) {
    if (val.trim().isEmpty) {
      return 'faild is empty';
    }
  }

  String validUsername(String val) {
    if (val.trim().isEmpty) {
      return 'username should not be impty';
    }
    if (val.trim().length < 4) {
      return 'username should not be less than 4 lettre';
    }
    if (val.trim().length > 10) {
      return 'username should not be larger than 10 lettre';
    }
  }

  String validPassword(String val) {
    if (val.trim().isEmpty) {
      return 'password should not be impty';
    }
    if (val.trim().length < 4) {
      return 'password should not be less than 4 lettre';
    }
    if (val.trim().length > 10) {
      return 'password should not be larger than 10 lettre';
    }
  }

  String validConfirmPassword(String val) {
    if (val != password.text) {
      return 'password incorect';
    }
  }

  String validEmail(String val) {
    if (val.trim().isEmpty) {
      return 'email should not be impty';
    }
    if (val.trim().length < 4) {
      return 'email should not be less than 4 lettre';
    }
    if (val.trim().length > 20) {
      return 'email should not be larger than 20 lettre';
    }

    RegExp regExp = new RegExp(pattern);
    if (!regExp.hasMatch(val)) {
      return 'email form not match (exemple@gmail.com)';
    }
  }

  TapGestureRecognizer _changesign;
  bool showsignin = true;

  @override
  void initState() {
    _changesign = new TapGestureRecognizer()
      ..onTap = () {
        setState(() {
          showsignin = !showsignin;
          print(showsignin);
        });
      };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mdw = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
        ),
        buildPostionTop(mdw),
        buildPostionBottom(mdw),
        Container(
          //height: 900,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 60),
                    child: Text(
                      showsignin ? 'sign in' : 'sign up',
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 20)),
                buildContainerAvatar(mdw),
                showsignin ? buildFormBoxSignIn(mdw) : buildFormBoxSignup(mdw),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Column(
                    children: [
                      showsignin
                          ? InkWell(
                              onTap: () {},
                              child: Text(
                                'did you forget password ?',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 17),
                              ),
                            )
                          : SizedBox(),
                      Container(
                        padding: EdgeInsets.only(top: showsignin ? 14 : 4),
                        child: Container(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                primary: showsignin
                                    ? Colors.blue[700]
                                    : Colors.grey[700]),
                            onPressed: showsignin ? signin : signup,
                            label: Text(
                              showsignin ? 'Sign in' : 'Create account',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            icon: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        child: RichText(
                          text: TextSpan(
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 16),
                              children: [
                                TextSpan(
                                    text: showsignin
                                        ? "if you don't have account you can ! -"
                                        : 'if you have account - ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey[800])),
                                TextSpan(
                                    text: showsignin
                                        ? " Create new account"
                                        : ' sign in',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                    recognizer: _changesign),
                              ]),
                        ),
                      ),
                      SizedBox(height: 18),
                      showsignin
                          ? Row(
                              children: [
                                Padding(padding: EdgeInsets.only(left: 10)),
                                Expanded(
                                    child: ElevatedButton(
                                  onPressed: () {},
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'images/media/facebook.png',
                                        width: 25,
                                        height: 25,
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(left: 10)),
                                      Text(
                                        'Sign in Facebook',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 17),
                                      )
                                    ],
                                  ),
                                )),
                                Padding(padding: EdgeInsets.all(10)),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.red[500])),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'images/media/google.png',
                                          width: 25,
                                          height: 25,
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(left: 10)),
                                        Text(
                                          'Sign in Google',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(right: 10)),
                              ],
                            )
                          : Text(''),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }

  Center buildFormBoxSignIn(double mdw) {
    return Center(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 600),
        curve: Curves.easeInOutBack,
        margin: EdgeInsets.only(top: 70),
        height: 230,
        width: mdw / 1.5,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Colors.black,
              spreadRadius: .1,
              blurRadius: 1,
              offset: Offset(1, 1))
        ]),
        child: Form(
          autovalidate: true,
          key: formstatesignin,
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(top: 15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //start textflied username
                  Text(
                    'Email',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  textFieldForm(false, 'enter your email', email, validEmail),

                  SizedBox(
                    height: 15,
                  ),
                  Text('Password',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                          fontSize: 16)),
                  SizedBox(
                    height: 15,
                  ),
                  textFieldForm(
                      true, 'enter your password', password, validPassword)
                ],
                //end textfield username
              ),
            ),
          ),
        ),
      ),
    );
  }

  Center buildFormBoxSignup(double mdw) {
    return Center(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 600),
        curve: Curves.easeInOutBack,
        margin: EdgeInsets.only(top: showsignin ? 70 : 25),
        height: 425,
        width: mdw / 1.5,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Colors.black,
              spreadRadius: .1,
              blurRadius: 1,
              offset: Offset(1, 1))
        ]),
        child: Form(
          autovalidate: true,
          key: formstatesignup,
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(top: 15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //start textflied username
                  Text(
                    'Username',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  textFieldForm(
                      false, 'enter your username', username, validUsername),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Email',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  textFieldForm(false, 'enter your email', email, validEmail),
                  SizedBox(
                    height: 15,
                  ),
                  Text('Password',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                          fontSize: 16)),
                  SizedBox(
                    height: 15,
                  ),
                  textFieldForm(
                      true, 'enter new password', password, validPassword),
                  SizedBox(
                    height: 15,
                  ),
                  Text('Re-peat password',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                          fontSize: 16)),
                  SizedBox(
                    height: 15,
                  ),
                  textFieldForm(true, 'Re-peat your password again',
                      confirmpassword, validConfirmPassword),
                ],
                //end textfield username
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField textFieldForm(bool pass, String myHintText,
      TextEditingController myController, myValid) {
    return TextFormField(
      obscureText: pass,
      validator: myValid,
      controller: myController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(4),
          hintText: myHintText,
          filled: true,
          fillColor: Colors.grey[200],
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.grey[500], style: BorderStyle.solid, width: 1)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.blue, style: BorderStyle.solid, width: 1))),
    );
  }

  AnimatedContainer buildContainerAvatar(double mdw) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      height: 90,
      width: 90,
      decoration: BoxDecoration(
          color: showsignin ? Colors.yellowAccent : Colors.grey[600],
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(color: Colors.black, blurRadius: 3, spreadRadius: 1)
          ]),
      child: InkWell(
        onTap: () {
          setState(() {
            showsignin = !showsignin;
          });
        },
        child: Stack(
          children: [
            Positioned(
                left: 23,
                top: 18,
                child: Icon(
                  Icons.person_outline,
                  size: 45,
                  color: Colors.white,
                )),
            Positioned(
                left: 8,
                top: 27,
                child: Icon(
                  Icons.arrow_back,
                  size: 25,
                  color: Colors.white,
                ))
          ],
        ),
      ),
    );
  }

  Positioned buildPostionTop(double mdw) {
    return Positioned(
        child: Transform.scale(
      scale: 1.5,
      child: Transform.translate(
        offset: Offset(0, -mdw / 1.7),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          height: mdw,
          width: mdw,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(mdw),
            color: showsignin ? Colors.grey[800] : Colors.blue,
          ),
        ),
      ),
    ));
  }

  Positioned buildPostionBottom(double mdw) {
    return Positioned(
        top: 300,
        right: mdw / 1.5,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          height: mdw,
          width: mdw,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(mdw),
            color: showsignin
                ? Colors.blue[800].withOpacity(0.3)
                : Colors.grey[800].withOpacity(0.3),
          ),
        ));
  }
}
