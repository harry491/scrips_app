import 'package:city_pickers/city_pickers.dart';
import 'package:city_pickers/modal/result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:my_app/components/person_info_component.dart';
import 'package:my_app/http/dartHttp.dart';
import 'package:my_app/redux/appState.dart';
import 'package:my_app/redux/userRedux.dart';
import 'package:my_app/router/NavigatorUtils.dart';
import 'package:my_app/theme/materialColor.dart';

class PersonInfo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PersonInfoState();
  }
}

class PersonInfoState extends State<PersonInfo> {
  Result resultArr = new Result();

  void chooseArea() async {
    Result tempResult = await CityPickers.showCityPicker(
        context: context,
        theme: Theme.of(context).copyWith(primaryColor: Color(0xfffe1314)),
        // 设置主题
        locationCode: resultArr != null
            ? resultArr.areaId ?? resultArr.cityId ?? resultArr.provinceId
            : null,
        // 初始化地址信息
        cancelWidget: Text(
          '取消',
          style: normalFontStyle,
        ),
        confirmWidget: Text(
          '确定',
          style: normalFontStyle,
        ),
        height: 220.0);
    if (tempResult != null) {
      /// 修改地区
      var area =
          tempResult.provinceName + tempResult.cityName + tempResult.areaName;
      var result =
          await HttpUtils.editUserInfo(context, params: {"area": area});
      if (result.code == "200") {
        StoreProvider.of<AppState>(context)
            .dispatch(UserThemeDataAction(result));
      }
    }
  }

  Future<void> showMutiDialog() async {
    int i = await showDialog<int>(
        context: context,
        builder: (context) {
          return Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  title: Text("请选择性别"),
                ),
                Flexible(
                  child: ListView.builder(
                    itemExtent: 60,
                    shrinkWrap: true,
                    itemCount: 2,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(index == 0 ? "女" : "男"),
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
      var result = await HttpUtils.editUserInfo(context, params: {"sex": i});
      if (result.code == "200") {
        StoreProvider.of<AppState>(context)
            .dispatch(UserThemeDataAction(result));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("个人信息"),
        ),
        body: StoreBuilder<AppState>(
          builder: (context, store) {
            return ListView(
              children: <Widget>[
                PersonInfoComponent(
                  "头像",
                  88,
                  right: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      image: DecorationImage(
                          image: store.state.userModel.user.head == ""
                              ? AssetImage("images/long.png")
                              : NetworkImage(HttpUtils.baseImageUrl +
                                  store.state.userModel.user.head),
                          fit: BoxFit.fill),
                    ),
                  ),
                  click: true,
                  callback: () {
                    NavigatorUtils.goEditHeadPage(context);
                  },
                ),
                Divider(
                  height: 0.5,
                ),
                PersonInfoComponent(
                  "名称",
                  60,
                  right: Text(
                    store.state.userModel.user.alias == ""
                        ? "小纸条"
                        : store.state.userModel.user.alias,
                    style: grayTitleFontStyle,
                  ),
                  click: true,
                  callback: () {
                    NavigatorUtils.goEditNamePage(context);
                  },
                ),
                Divider(
                  height: 0.5,
                ),
                PersonInfoComponent(
                  "邮箱",
                  60,
                  right: Text(
                    store.state.userModel.user.email,
                    style: grayTitleFontStyle,
                  ),
                  click: false,
                ),
                Divider(
                  height: 0.5,
                ),
                Container(
                  height: 10,
                ),
                Divider(
                  height: 0.5,
                ),
                PersonInfoComponent(
                  "地区",
                  60,
                  right: Text(
                    store.state.userModel.user.area,
                    style: grayTitleFontStyle,
                  ),
                  click: true,
                  callback: () {
                    chooseArea();
                  },
                ),
                Divider(
                  height: 0.5,
                ),
                PersonInfoComponent(
                  "性别",
                  60,
                  right: Text(store.state.userModel.user.sex == 0 ? "女" : "男"),
                  click: true,
                  callback: () {
                    showMutiDialog();
                  },
                ),
                Divider(
                  height: 0.5,
                ),
              ],
            );
          },
        ));
  }
}
