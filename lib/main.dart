import 'package:event_bus/event_bus.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:my_app/redux/appState.dart';
import 'package:my_app/router/application.dart';
import 'package:my_app/router/router.dart';
import 'blog/blogSplash.dart';
import 'event/event_bus.dart';
import 'package:redux/redux.dart';

import 'event/event_model.dart';

void main() {
  var router = Router();
  Routers.configureRouters(router);
  Application.router = router;
  // Create your store as a final variable in a base Widget. This works better
  // with Hot Reload than creating it directly in the `build` function.
  runApp(MyApp());
}

//void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  var defaultColor = Colors.white;

  final store = new Store<AppState>(
    appReducer,
    initialState: AppState(
      themeData: ThemeData(
        primaryColor: Colors.red,
      ),
    ),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final eventBus = new EventBus();
    AppEvent.event = eventBus;

    AppEvent.event.on<ThemeChangeNotification>().listen((event) {
      setState(() {
        print("did receive ThemeChangeNotification");
        defaultColor = event.color;
      });
    });

  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: StoreBuilder<AppState>(builder:(context , store){
        return MaterialApp(
          theme: store.state.themeData,
//        ThemeData(primaryColor: defaultColor),
//        store.state.themeData,
          title: 'Flutter Demo',
          home: BlogSplash(
            images: [
              "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2327995546,2815924863&fm=26&gp=0.jpg",
            ],
          ),
//        MyHomePage(title: 'Flutter'),
        );
      })
    );
  }
}
