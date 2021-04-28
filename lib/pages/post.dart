import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'comments.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'dart:convert' as convert;
import 'dart:io';

class Post extends StatefulWidget {
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  var id = '';
  var username = 'none';
  File file;
  var email;

  TextEditingController addpost = new TextEditingController();

  Future pickercamera() async {
    final myFile = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      file = File(myFile.path);
    });
  }

  Future getPost() async {
    var url = Uri.parse('http://10.0.2.2:80/flutter_php/post.php');
    var response = await http.get(url);
    var responsebody = convert.jsonDecode(response.body);
    return responsebody;
  }

  Future addPost() async {
    if (file == null) return;
    String base64 = convert.base64Encode(file.readAsBytesSync());
    String imagename = file.path.split('/').last;
    var url = Uri.parse('http://10.0.2.2:80/flutter_php/add_post.php');
    var data = {
      'post': addpost.text,
      'post_user': id,
      'imagename': imagename,
      'image64': base64
    };
    var response = await http.post(url, body: data);
    Navigator.of(context).pushNamed('post');
  }

  getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id');
    username = prefs.getString('username');
    email = prefs.getString('email');

    setState(() {
      id = prefs.getString('id');
      username = prefs.getString('username');
      email = prefs.getString('email');
    });
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
          title: Text(
            'Post',
            style: TextStyle(color: Colors.yellowAccent),
          ),
          centerTitle: true,
          backgroundColor: Colors.purple,
        ),
        body: ListView(
          children: [
            Padding(padding: EdgeInsets.only(top: 5)),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    title: TextFormField(
                      maxLines: 10,
                      minLines: 1,
                      controller: addpost,
                      maxLength: 225,
                      decoration: InputDecoration(
                          hintText: 'add your post',
                          contentPadding: EdgeInsets.only(left: 10),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.grey))),
                    ),
                  ),
                  IconButton(
                      icon: Icon(Icons.camera_enhance),
                      onPressed: pickercamera),
                  Row(
                    children: [
                      Expanded(
                          child: InkWell(
                        onTap: addPost,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                                      color: Colors.grey.withOpacity(0.2)))),
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Add Post',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 15),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Icon(
                                Icons.add_box,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      ))
                    ],
                  ),
                ],
              ),
            ),
            FutureBuilder(
                future: getPost(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    // return Column(
                    //   children: [
                    //     for (int i = snapshot.data.length - 1; i >= 0; i--)
                    //       postList(
                    //         username: snapshot.data[i]['username'],
                    //         postcontent: snapshot.data[i]['post'],
                    //         post_id: snapshot.data[i]['post_id'],
                    //         post_image: snapshot.data[i]['post_image'],
                    //       )
                    //   ],
                    // );
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int i) {
                          return postList(
                            username: snapshot.data[i]['username'],
                            postcontent: snapshot.data[i]['post'],
                            post_id: snapshot.data[i]['post_id'],
                            post_image: snapshot.data[i]['post_image'],
                          );
                        });
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                })
          ],
        ));
  }
}

class postList extends StatelessWidget {
  final username;
  final postcontent;
  final post_id;
  final post_image;
  postList({this.username, this.postcontent, this.post_id, this.post_image});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            isThreeLine: true,
            leading: CircleAvatar(child: Icon(Icons.person)),
            title: Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(username,
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.w800)),
            ),
            trailing: Icon(Icons.filter_list_alt),
            subtitle: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Text(postcontent),
                ),
                SizedBox(
                  height: 10,
                ),
                Image.network(
                    'http://10.0.2.2:80/flutter_php/upload/$post_image')
              ],
            ),
          ),
          Divider(
            color: Colors.grey.withOpacity(0.5),
          ),
          Row(
            children: [
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                    border: Border(right: BorderSide(color: Colors.grey))),
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.thumb_up, color: Colors.grey),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        'Like',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                padding: EdgeInsets.only(top: 2, bottom: 5),
              )),
              Expanded(
                  child: Padding(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return Comments(
                        postID: post_id,
                      );
                    }));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.comment,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        'comments',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                padding: EdgeInsets.only(top: 2, bottom: 5),
              ))
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 5))
        ],
      ),
    );
  }
}
