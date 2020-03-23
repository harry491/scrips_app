import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/discover/hot.dart';
import 'package:my_app/discover/latest.dart';
import 'package:my_app/discover/recommend.dart';
import 'package:my_app/redux/appState.dart';

class Discover extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DiscoverState();
  }
}

class DiscoverState extends State<Discover> with TickerProviderStateMixin {
  TabController _tabController;

  List _tabTitles = ["推荐", "热门", "最新"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    print(ScreenUtil.instance.width);
    print(ScreenUtil.instance.setWidth(60));
    // TODO: implement build
    return StoreBuilder<AppState>(
      builder: (context, store) {
        return Scaffold(
          backgroundColor: store.state.themeData.primaryColor,
          body: MediaQuery.removePadding(
            context: context,
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  Container(
                    height: kToolbarHeight,
                    child: Stack(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              left: ScreenUtil.instance.setWidth(15),
                              right: ScreenUtil.instance.setWidth(100)),
                          child: TabBar(
                              labelStyle: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              unselectedLabelStyle: TextStyle(fontSize: 16),
                              labelColor: Colors.black,
                              unselectedLabelColor: Colors.black54,
                              indicatorColor: Colors.black,
                              indicatorSize: TabBarIndicatorSize.label,
                              controller: _tabController,
                              tabs: _tabTitles.map((value) {
                                return Tab(
                                  text: value,
                                );
                              }).toList()),
                        ),
                        Positioned(
                          child: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {},
                          ),
                          right: 15,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: <Widget>[Recommand(), Hot(), Latest()],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
