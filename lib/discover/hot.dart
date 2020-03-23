import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_app/http/dartHttp.dart';
import 'package:my_app/model/movie_entity.dart';
import 'package:my_app/router/NavigatorUtils.dart';
import 'package:my_app/theme/materialColor.dart';

class Hot extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HotState();
  }
}

class HotState extends State<Hot> {
  List<MovieMovie> list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getData();
  }

  void _getData() async {
    var result = await HttpUtils.getNewMovies(context, params: {});
    if (result.code == "200") {
      setState(() {
        list = result.movies;
      });
    } else {
      Fluttertoast.showToast(msg: "网络请求失败");
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: StaggeredGridView.countBuilder(
            primary: false,
            crossAxisCount: 4,
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
            itemCount: list.length,
            staggeredTileBuilder: (index) => new StaggeredTile.fit(2),
            itemBuilder: (context, index) {
              return _buildChildWidget(list[index]);
            },
          ),
        ));
  }

  Widget _buildChildWidget(MovieMovie movie) {
    return GestureDetector(
      onTap: (){
        NavigatorUtils.goWebPage(context, {
          "url": movie.href
        });
      },
      child: Column(
        children: <Widget>[
          new Stack(
            children: <Widget>[
              //new Center(child: new CircularProgressIndicator()),
              new ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: new FadeInImage.assetNetwork(
                  placeholder: "images/place.png",
                  image: movie.head,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 5 , bottom: 10 , left: 10 , right: 10),
            child: Column(
              children: <Widget>[
                Text(movie.title , style: bigFontStyle,),
                Container(height: 5,),
                Text(movie.other , style: normalFontStyle,),
              ],
            ),
          )
        ],
      ),
    );
  }
}
