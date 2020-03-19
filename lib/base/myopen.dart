import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyOpen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        title: new Text("单选框_复选框"),
      ),
      body: new ListView(
        children: <Widget>[
          SwitchAndCheckBox(),
        ],
      ),
    );
  }
}

class SwitchAndCheckBox extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SwitchAndCheckBoxState();
  }
}

class _SwitchAndCheckBoxState extends State<SwitchAndCheckBox> {
  bool _switchSelect = true;
  bool _checkBoxSelect = true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Switch(
          value: _switchSelect,
          onChanged: (val) {
            setState(() {
              _switchSelect = val;
            });
          },
        ),
        Checkbox(
          value: _checkBoxSelect,
          activeColor: Colors.red,
          onChanged: (val){
            setState(() {
              _checkBoxSelect = val;
            });
          },
        ),
      ],
    );
  }
}
