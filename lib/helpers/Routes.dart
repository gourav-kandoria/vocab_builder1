import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vocab_builder/screens/AskName.dart';
import 'package:vocab_builder/screens/HomePage.dart';
import 'package:vocab_builder/screens/LoginPage.dart';

class Routes {
  static const loginpage= 'loginpage';
  static const askname= 'askname';
  static const homepage = 'homepage';
}

Route<dynamic> generateRoute(settings) {
  if(settings.name == Routes.loginpage) {
    return MaterialPageRoute(
      builder: (context)=>LoginPage(), 
    );
  }
  if(settings.name == Routes.askname) {
    return MaterialPageRoute(
      builder: (context)=>AskName(settings.arguments), 
    );
  }
  if(settings.name == Routes.homepage) {
    return MaterialPageRoute(
      builder: (context) => HomePage(settings.arguments) 
    );
  }

}