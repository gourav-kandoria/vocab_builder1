import 'package:vocab_builder/models/User.dart';
import 'dart:convert';

User parseTokenToUser(String token) {
  final payload = token.split('.')[1];
  final resp = utf8.decode(
                base64Url.decode(
                    base64Url.normalize(payload)
                ) 
               );
  final payloadmap = json.decode(resp);
  return User(phone: payloadmap["phone"],
              name: payloadmap["name"],
              token: token
              );
}