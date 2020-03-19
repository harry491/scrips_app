import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_app/http/myDialog.dart';

class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<bool> showAlertDialog() {
      return showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("tips"),
              content: Text("这是一个弹框"),
              actions: <Widget>[
                FlatButton(
                  child: Text("取消"),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                FlatButton(
                  child: Text("删除"),
                  onPressed: () {
                    //关闭对话框并返回true
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            );
          });
    }

    Future<void> showSimpleDialog() async {
      int i = await showDialog<int>(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              title: Text("选择"),
              children: <Widget>[
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, 1);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 6),
                    child: Text("中文"),
                  ),
                ),
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, 2);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 6),
                    child: Text("英文"),
                  ),
                )
              ],
            );
          });

      if (i != null) {
        print("选择了：${i == 1 ? "中文简体" : "美国英语"}");
      }
    }

    Future<void> showMutiDialog() async {
      int i = await showDialog<int>(
          context: context,
          builder: (context) {
            return Dialog(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text("请选择"),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 30,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text("$index"),
                          onTap: () => Navigator.of(context).pop(index),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          });

      if (i != null) {
        print("点击了: $i");
      }
    }

    Future<DateTime> _showDatePicker1() {
      var date = DateTime.now();
      return showDatePicker(
        context: context,
        initialDate: date,
        firstDate: date,
        lastDate: date.add(
          //未来30天可选
          Duration(days: 30),
        ),
      );
    }

    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        title: new Text("按钮"),
      ),
      body: new ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          // RaisedButton 即"漂浮"按钮
          new Text("RaisedButton 即 漂浮 按钮，它默认带有阴影和灰色背景。按下后，阴影会变大，如图3-10所示："),
          new RaisedButton(
            child: Text("Normal"),
            onPressed: () {
//              showAlertDialog();
              showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return MyDialog(text: "loading...",);
                  });
              Timer(Duration(seconds: 10) , (){
                Navigator.of(context).pop();
              });
            },
          ),

          new Text("FlatButton即扁平按钮，默认背景透明并不带阴影。按下后，会有背景色，如图3-11所示："),
          // FlatButton即扁平按钮
          new FlatButton(
            child: Text("FlatButton"),
            onPressed: () {
              showSimpleDialog();
            },
          ),

          new Text(
              "OutlineButton默认有一个边框，不带阴影且背景透明。按下后，边框颜色会变亮、同时出现背景和阴影(较弱)，如图3-12所示："),
          // OutlineButton默认有一个边框
          new OutlineButton(
            child: Text("OutlineButton"),
            onPressed: () {
              showMutiDialog();
            },
          ),

          new Text("IconButton是一个可点击的Icon，不包括文字，默认没有背景，点击后会出现背景，如图3-13所示："),
          new IconButton(
            icon: Icon(Icons.thumb_up),
            onPressed: () {
              _showDatePicker1();
            },
          ),
        ],
      ),
    );
  }
}
