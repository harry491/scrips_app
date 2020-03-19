import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyListener extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyListenerState();
  }
}

class MyListenerState extends State<MyListener> {
  PointerEvent _event;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("监听事件"),
      ),
      body: Listener(
        child: Container(
          alignment: Alignment.center,
          color: Colors.blue,
          width: 300,
          height: 150,
          child: Text(
            _event?.toString() ?? "",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        onPointerDown: (PointerDownEvent event) =>
            setState(() => _event = event),
        onPointerMove: (PointerMoveEvent event) =>
            setState(() => _event = event),
        onPointerUp: (PointerUpEvent event) => setState(() => _event = event),
      ),
    );
  }
}
