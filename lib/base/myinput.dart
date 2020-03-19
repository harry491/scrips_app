import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyInput extends StatelessWidget {


  TextEditingController _user = TextEditingController();
  TextEditingController _pwd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        title: new Text("输入"),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            autofocus: false,
            decoration: InputDecoration(
              labelText: "用户名",
              hintText: "用户名或者邮箱",
              prefixIcon: Icon(Icons.person),
            ),
            controller: _user,
          ),

          TextField(
            autofocus: false,
            decoration: InputDecoration(
              labelText: "密码",
              hintText: "您的密码",
              prefixIcon: Icon(Icons.lock),
            ),
            obscureText: true,
            controller: _pwd,
          ),

          RaisedButton(
            child: new Text("提交"),
            onPressed: (){
              print(_user.text);
            },
          ),
        ],
      ),
    );
  }
}
