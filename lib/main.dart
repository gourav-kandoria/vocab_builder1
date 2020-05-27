import 'package:flutter/material.dart';
import 'package:vocab_builder/helpers/Routes.dart';

void main() async{
  var myapp = MyApp();
  runApp(myapp);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  String initial_route = 'loginpage';
  String tk;
  @override
  Widget build(BuildContext context) {
    var materialApp = MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: Colors.green,
        primaryColorDark: Colors.greenAccent,
      ),
      initialRoute: initial_route,
      onGenerateRoute: generateRoute,
   );
    return materialApp;
  }
}