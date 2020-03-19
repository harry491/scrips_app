import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_app/base/mybutton.dart';
import 'package:my_app/base/myimages.dart';
import 'package:my_app/base/myinput.dart';
import 'package:my_app/base/mylistener.dart';
import 'package:my_app/base/myopen.dart';
import 'package:my_app/base/myrow.dart';
import 'package:my_app/base/mytext.dart';

class Save extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new SaveState();
  }
}

class SaveState extends State<Save> {
  var titles = [
    "Text",
    "Button",
    "Images",
    "Switch",
    "Input",
    "Row",
    "Listener"
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        title: Text("我的"),
      ),
      body: new ListView(
          children: titles.map((val) {
        return GestureDetector(
          child: Container(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(val),
                ),
                Divider(),
              ],
            ),
          ),
          onTap: () {
            Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
              int num = titles.indexOf(val);
              if (num == 0) {
                return MyText();
              } else if (num == 1) {
                return MyButton();
              } else if (num == 2) {
                return MyImages_new();
              } else if (num == 3) {
                return MyOpen();
              } else if (num == 4) {
                return MyInput();
              } else if (num == 5) {
                return MyRow();
              } else if (num == 6) {
                return MyListener();
              } else {
                return MyButton();
              }
            }));
          },
        );
      }).toList()),
    );
  }
}
