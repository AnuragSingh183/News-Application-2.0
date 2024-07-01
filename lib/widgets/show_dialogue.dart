import 'package:flutter/material.dart';

Future showCustomDialogue(context, error) {
  return showDialog(
    context: context,
    builder: (BuildContext context) => new AlertDialog(
      title: new Text(
        "An error occured",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      content: new Text("Check your internet connection"),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text("Ok"),
        )
      ],
    ),
  );
}
