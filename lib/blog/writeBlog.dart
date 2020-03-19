import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/event/event_bus.dart';
import 'package:my_app/event/event_model.dart';
import 'package:my_app/http/dartHttp.dart';

class WriteBlog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return WriteBlogState();
  }
}

class WriteBlogState extends State<WriteBlog> {
  String leftCount = "300";

  String content = "";

  List<File> images = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("写纸条"),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.all(Radius.circular(3))),
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                hintText: "输入你所要表达的内容",
              ),
              maxLines: 10,
              onChanged: (e) {
                setState(() {
                  if (e != null) {
                    this.leftCount = (300 - e.length).toString();
                    this.content = e;
                  }
                });
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10, top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("当前剩余字数:"),
                Text("${this.leftCount}/300"),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Row(
              children: [
                images.asMap().keys.map((index) {
                  return Container(
                      width: 60,
                      height: 60,
                      padding: EdgeInsets.only(right: 5),
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: <Widget>[
                          Container(
                            width: 60,
                            height: 60,
                            child: Image.file(
                              images[index],
                              fit: BoxFit.fill,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                images.removeAt(index);
                              });
                            },
                            child: Container(
                              width: 20,
                              height: 20,
                              child: Icon(
                                Icons.remove_circle,
                                color: Colors.red,
                              ),
                            ),
                          )
                        ],
                      ));
                }).toList(),
                images.length >= 3
                    ? [Container()]
                    : [
                        IconButton(
                          icon: Icon(
                            Icons.add,
                            size: 50,
                          ),
                          onPressed: () async {
                            var image = await ImagePicker.pickImage(
                                source: ImageSource.gallery);

                            if (image != null) {
                              setState(() {
                                images.add(image);
                              });
                            }
                          },
                        ),
                      ]
              ].expand((item) => item).toList(),
            ),
          ),
          Container(
              child: Row(
            children: <Widget>[],
          )),
          Container(
            height: 45,
            margin: EdgeInsets.only(left: 30, right: 30, top: 45),
            child: RaisedButton(
              color: Colors.blue,
              child: Text(
                "发布",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                if (this.content.length < 10) {
                  Fluttertoast.showToast(msg: "请输入内容(最少10个字)");
                  return;
                }

                FormData data;

                if (images.length > 0) {
                  List files = [];
                  images.asMap().keys.forEach((index) {
                    files.add(MultipartFile.fromFileSync(images[index].path,
                        filename: "image"));
                  });

                  data = FormData.fromMap({"files": files});
                }

                var result = await HttpUtils.writeScrip(context,
                    params: {"content": content, "account": "Admin"},
                    data: data);
                print(result);
                if (result["code"] == "200") {
                  Fluttertoast.showToast(msg: "Success");
                  AppEvent.event.fire(PublishNotification());
                  Navigator.of(context).pop();
                } else {
                  Fluttertoast.showToast(msg: result["msg"]);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
