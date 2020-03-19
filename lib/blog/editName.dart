import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:my_app/http/dartHttp.dart';
import 'package:my_app/redux/appState.dart';
import 'package:my_app/redux/userRedux.dart';
import 'package:my_app/router/NavigatorUtils.dart';
import 'package:my_app/theme/materialColor.dart';

class EditName extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EditNameState();
  }
}

class EditNameState extends State<EditName> {
  bool edit = false;

  String name = "";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("修改名称"),
        actions: <Widget>[
          (edit && name != "")
              ? IconButton(
                  icon: Icon(
                    Icons.save,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    // 保存
                    var result = await HttpUtils.editUserInfo(context,
                        params: {"name": name});
                    if (result.code == "200") {
                      StoreProvider.of<AppState>(context)
                          .dispatch(UserThemeDataAction(result));
                      NavigatorUtils.back(context);
                    }
                  },
                )
              : IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    NavigatorUtils.back(context);
                  },
                )
        ],
      ),
      body: Container(
          alignment: Alignment.centerLeft,
          color: Colors.white,
          padding: EdgeInsets.only(left: 15, right: 15),
          height: 100,
          child: TextField(
            style: bigFontStyle,
            maxLength: 8,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "输入昵称",
              hintStyle: placeStyle,
            ),
            onChanged: (value) {
              setState(() {
                name = value;
                edit = true;
              });
            },
            cursorColor: Colors.red,
          )),
    );
  }
}
