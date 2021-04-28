import 'package:flutter/material.dart';

ShowDialog(context) {
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

showDialogAll(context, String mytitle, String mycontent) {
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
              child: Text('close'),
            ),
          ],
        );
      });
}
