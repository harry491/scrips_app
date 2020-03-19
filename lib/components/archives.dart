import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_app/event/event_bus.dart';
import 'package:my_app/event/event_model.dart';
class Archives extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ArchivesState();
  }
}

class ArchivesState extends State<Archives> {
  ArchivesState() {

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return NotificationListener(
      onNotification: (notification) {
        return true;
      },
      child: Container(
        child: IconButton(
          icon: Icon(Icons.person),
          onPressed: () {
            Navigator.of(context).pushNamed("/login");
          },
        ),
        padding: EdgeInsets.all(15),
        color: Colors.red,
      ),
    );
  }
}
