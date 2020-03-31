import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'mine.dart';

class PersonInfo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PersonInfoState();
  }
}

class PersonInfoState extends State<PersonInfo> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    var user = User("" , "");
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: null,
      body: ListView(
        children: <Widget>[
          _buildPersonInfoHeader(),
          Container(
            height: 10,
          ),
          _buildPersonInfoSection("昵称"),
          _buildPersonInfoSection("性别"),
          _buildPersonInfoSection("Email"),
        ],
      ),
    );
  }

  Widget _buildPersonInfoSection(String title) {
    return Container(
      height: 50,
      margin: EdgeInsets.only(left: 15, top: 1),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
          )
        ],
      ),
    );
  }

  Widget _buildPersonInfoHeader() {
    return Container(
      color: Colors.white,
      height: 200,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: new BoxDecoration(
//            border: new Border.all(width: 2.0, color: Colors.black38),
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(35.0)),
                  color: Colors.green),
              width: 70,
              height: 70,
            ),
            Container(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("NAME"),
                IconButton(
                  icon: Icon(Icons.sentiment_neutral),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
