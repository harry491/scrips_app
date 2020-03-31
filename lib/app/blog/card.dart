import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Card extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CardState();
  }
}

class CardState extends State<Card> {
  List<String> _dataSource = ["1", "2", "3"];
  int _pageIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
  }

  Widget _buildIndicator(int currentIndex) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _dataSource.asMap().keys.map((v) {
          return Container(
            margin: EdgeInsets.only(left: 5, right: 5),
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: currentIndex == v ? Colors.red : Colors.grey,
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 580,
            child: PageView.builder(
                itemCount: 3,
                pageSnapping: true,
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _pageIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Center(
                      child: AnimatedContainer(
                    curve: Curves.easeInOut,
                    duration: Duration(milliseconds: 300),
                    height: _pageIndex == index ? 500 : 450,
                    margin:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                    child: Stack(),
                  ));
                }),
          ),
          _buildIndicator(_pageIndex),
        ],
      ),
    );
  }
}
