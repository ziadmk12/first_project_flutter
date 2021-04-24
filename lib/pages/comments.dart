import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';

class Comments extends StatefulWidget {
  final postID;
  Comments({this.postID});
  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  var id = "";

  TextEditingController commentadd = new TextEditingController();

  Future addcomment() async {
    var url = Uri.parse('http://10.0.2.2:80/flutter_php/add_comment.php');
    var data = {
      'comment': commentadd.text,
      'comment_user': id,
      'comment_post': widget.postID
    };
    var response = await http.post(url, body: data);
    Navigator.of(context).pushNamed('post');
  }

  Future getComment() async {
    var url = Uri.parse('http://10.0.2.2:80/flutter_php/comment.php');
    var data = {'post_id': widget.postID};
    var response = await http.post(url, body: data);
    var responsebody = convert.jsonDecode(response.body);
    return responsebody;
  }

  getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getString('id');
    });
  }

  @override
  void initState() {
    getPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Comments',
            style: TextStyle(color: Colors.yellowAccent),
          ),
          centerTitle: true,
          backgroundColor: Colors.purple,
        ),
        body: Stack(
          children: [
            Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 70,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border(top: BorderSide(color: Colors.grey))),
                      child: Row(
                        children: [
                          IconButton(
                              icon: Icon(
                                Icons.camera_enhance,
                                color: Colors.grey,
                              ),
                              onPressed: () {}),
                          Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              width: MediaQuery.of(context).size.width - 50,
                              child: TextFormField(
                                controller: commentadd,
                                decoration: InputDecoration(
                                  hintText: "Write a comment... ",
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      Icons.send,
                                      color: Colors.grey,
                                    ),
                                    onPressed: addcomment,
                                  ),
                                  contentPadding: EdgeInsets.all(15),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      borderSide:
                                          BorderSide(style: BorderStyle.none)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      borderSide:
                                          BorderSide(style: BorderStyle.none)),
                                ),
                              )),
                          SizedBox(
                            width: 7,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
                child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 157,
              child: SingleChildScrollView(
                  child: FutureBuilder(
                future: getComment(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (int i = 0; i < snapshot.data.length; i++)
                          commentPost(
                            username: snapshot.data[i]['username'],
                            comment: snapshot.data[i]['comment'],
                          )
                      ],
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              )),
            ))
          ],
        ),
      ),
    );
  }
}

class commentPost extends StatelessWidget {
  final username;
  final comment;

  commentPost({this.username, this.comment});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Icon(Icons.person),
      ),
      title: Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(
            username,
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
          )),
      subtitle: Container(
          margin: EdgeInsets.only(top: 3),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: Colors.grey[100]),
          padding: EdgeInsets.all(10),
          //color: Colors.grey[100],
          child: Text(comment)),
    );
  }
}
