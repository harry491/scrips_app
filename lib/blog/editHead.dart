import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_luban/flutter_luban.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/http/dartHttp.dart';
import 'package:my_app/redux/appState.dart';
import 'package:my_app/redux/userRedux.dart';
import 'package:my_app/router/NavigatorUtils.dart';
import 'package:path_provider/path_provider.dart';

class EditHead extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EditHeadState();
  }
}

class EditHeadState extends State<EditHead> {
  File choose;

  Future<void> showMutiDialog() async {
    int i = await showDialog<int>(
        context: context,
        builder: (context) {
          return Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  title: Text("请选择"),
                ),
                Flexible(
                  child: ListView.builder(
                    itemExtent: 60,
                    shrinkWrap: true,
                    itemCount: 2,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(index == 0 ? "相机" : "相册"),
                        onTap: () => Navigator.of(context).pop(index),
                      );
                    },
                  ),
                )
              ],
            ),
          );
        });

    if (i != null) {
      File image;
      if (i == 0) {
        image = await ImagePicker.pickImage(source: ImageSource.camera);
      } else {
        image = await ImagePicker.pickImage(source: ImageSource.gallery);
      }

      if (image == null) return;
      final tempDir = await getTemporaryDirectory();

      CompressObject compressObject = CompressObject(
        imageFile: image, //image
        path: tempDir.path, //compress to path
        quality: 85, //first compress quality, default 80
        step:
            9, //compress quality step, The bigger the fast, Smaller is more accurate, default 6
//      mode: CompressMode.LARGE2SMALL,//default AUTO
      );
      Luban.compressImage(compressObject).then((_path) {
        setState(() {
          choose = File(_path);
          saveUserHead(choose);
        });
      });
    }
  }

  void saveUserHead(File image) async {
    FormData data = FormData.fromMap({
      "files": [MultipartFile.fromFileSync(image.path, filename: "image")]
    });
    // 保存
    var result = await HttpUtils.editUserInfo(context, params: {}, data: data);
    if (result.code == "200") {
      StoreProvider.of<AppState>(context).dispatch(UserThemeDataAction(result));
      NavigatorUtils.back(context);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("头像"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.more_horiz,
              color: Colors.white,
            ),
            onPressed: () {
              showMutiDialog();
            },
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(top: 80),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        child: choose == null
            ? Image.asset("images/long.png")
            : Image.file(choose),
      ),
    );
  }
}
