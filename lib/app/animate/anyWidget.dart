import 'package:flutter/cupertino.dart';

class AnyWidget extends StatelessWidget {
  final Animation<double> animation;

  final Widget child;

  AnyWidget({@required this.animation, @required this.child});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (context, child) {
        return Container(
          height: animation.value,
          child: child,
        );
      },
    );
  }
}
