import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vocab_builder/helpers/generateRoute.dart';
import 'package:vocab_builder/screens/HomePage.dart';
import 'package:vocab_builder/screens/LoginPage.dart';

void main() async{
  var myapp = MyApp();
  final store = await SharedPreferences.getInstance();
  try {String token = store.getString('vocab_builder');
    myapp.tk = token;
    if(token!= null){
      myapp.initial_route = 'homepage';
      runApp(myapp);
    }
    else {
      myapp.initial_route = 'loginpage';
      runApp(myapp);
    }
  }
  catch(e) {
    print(e);
  }
  runApp(myapp);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  String initial_route = null;
  String tk;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      initialRoute: initial_route,
      onGenerateRoute: generateRoute,
      routes: {
        '/': (context) => HomePage(),
        'homepage': (context) => HomePage(),
        'loginpage': (context) => LoginPage(),
        'confirm_otp_page':(context) => 
      },
    );
  }
}