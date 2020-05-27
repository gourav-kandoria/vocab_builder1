import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vocab_builder/models/User.dart';

String url = 'https://jsonplaceholder.typicode.com/albums';

Future<Map<String,dynamic> > recieveOTP(String phone) async {
 http.Response res = await http.post("$url/recieveOTP/",
  headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  body: jsonEncode({
    'phone': phone,
  }),
  );
  return jsonDecode(res.body);
}

Future<User> registerUser(String phone, String name) async {
  return User(name: "Gaurav", phone: "8219669915", token: "sqwertyuiop");
  try {
    http.Response res = await http.post("$url/registerUser/",
      headers: <String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'phone': phone,
        'name': name,
      },
      )
    ).timeout(
      Duration(seconds: 5),
    ); 
    final mp = jsonDecode(res.body);
    if(res.statusCode==200 && mp["registered"]==true) {
      return User(name: mp["name"], phone: mp["phone"], token: mp["token"]);
    }
    print("I reached here\n");
    throw "Could not register";
  }
  on SocketException {
    print("I sochedkd here");
    throw "No internet Connection";
  }
  on TimeoutException {
    print("I timed out here");
    throw "Request Timeout!";
  }
}