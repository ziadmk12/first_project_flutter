import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  File file;
  Future pickercamera() async {
    final myFile = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      file = File(myFile.path);
    });
  }

  Future upload() async {
    if (file == null) return;
    String base64 = convert.base64Encode(file.readAsBytesSync());
    String imagename = file.path.split('/').last;
    print(imagename);
    var url = Uri.parse('http://10.0.2.2:80/flutter_php/uploadimage.php');
    var data = {'imagename': imagename, 'image64': base64};
    var response = await http.post(url, body: data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
      ),
      body: Container(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: pickercamera,
              child: Text('get Image'),
            ),
            Center(
              child:
                  file == null ? Text('image not selected') : Image.file(file),
            ),
            ElevatedButton(
              onPressed: upload,
              child: Text('Upload Image'),
            )
          ],
        ),
      ),
    );
  }
}
