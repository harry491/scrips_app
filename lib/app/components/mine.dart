import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:my_app/event/event_bus.dart';
import 'package:my_app/event/event_model.dart';
import 'package:my_app/model/user_model_entity.dart';
import 'package:my_app/redux/appState.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Mine extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MineState();
  }
}

class User {
  User(this.name, this.account);

  String name;
  String account;
}

class MineState extends State<Mine> {
  User user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _localUser();

    AppEvent.event.on<LoginNotification>().listen((event) {
      print(event.account);
      User u = User("", "");
      u.account = event.account;
      u.name = event.account;
      setState(() {
        this.user = u;
      });
    });
  }

  void _localUser() async {
    final prefs = await SharedPreferences.getInstance();
    var user = prefs.get("login_user");
    if (user != null) {
      setState(() {
        this.user = User(user, user);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: Column(
        children: <Widget>[
          _buildHeader(context),
          Divider(),
          Expanded(
            child: _buildMenu(),
          ),
          _buildFooter(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (user != null && user.account.length > 0) {
            Navigator.of(context).pushNamed("/personInfo");
          } else {
            Navigator.of(context).pushNamed("/login");
          }
        },
        child: Container(
          padding: const EdgeInsets.fromLTRB(30, 88, 30, 30),
          child: Column(
            children: <Widget>[
              ClipOval(
                child: Image.asset(
                  "images/long.png",
                  width: 80,
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: StoreConnector<AppState, UserModelEntity>(
                    converter: (store) => store.state.userModel,
                    builder: (context, userModel) {
                      return Text(
                        (userModel == null) ? "未登录" : userModel.user.alias,
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      );
                    }),
              )
            ],
          ),
        ));
  }

  Widget _buildMenu() {
    return ListView(
      children: <Widget>[
        ListTile(
          leading: const Icon(Icons.color_lens),
          title: Text("换肤"),
          onTap: () {
            Navigator.pushNamed(context, '/theme');
          },
        ),
        ListTile(
          leading: const Icon(Icons.language),
          title: Text("语言"),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: Text("注销"),
          onTap: () async {
            final prefs = await SharedPreferences.getInstance();
            var user = prefs.clear();
            setState(() {
              this.user = null;
            });
          },
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          FlatButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, "/set");
            },
            icon: Icon(Icons.settings),
            label: Text("设置"),
          ),
          FlatButton.icon(
            onPressed: () {},
            icon: Icon(Icons.local_laundry_service),
            label: Text("客服"),
          ),
        ],
      ),
    );
  }
}
