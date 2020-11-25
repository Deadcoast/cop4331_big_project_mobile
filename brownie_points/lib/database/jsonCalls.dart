import 'dart:async';
import 'dart:convert';
import 'package:brownie_points/database/savePrefs.dart';
import 'package:http/http.dart' as http;

import 'jsonPacks.dart';


class JsonCall {
  static final srv = "http://10.0.2.2:5000/api/";
  static final header = {"Content-Type": "application/json"};

  static Future<String> login(String username, String password) async
  {
    LoginSend ls = LoginSend(username, password);
    Map<String, dynamic> js = ls.toJson();

    final response = await http.post(srv + "login",headers: header, body: jsonEncode(js));
    var loginInfo = LoginReceive.fromJson(jsonDecode(response.body));

    if (loginInfo.success) {
      EditPreferences.save("username", loginInfo.username);
      EditPreferences.save("email", loginInfo.email);
      EditPreferences.save("metric",loginInfo.usesMetric);
      EditPreferences.save("userID", loginInfo.userID);
      EditPreferences.save("first", loginInfo.firstname);
      EditPreferences.save("last", loginInfo.lastname);
      return null;
    }

    return loginInfo.error;
  }

  static Future<String> register(String username, String password, String email, String firstname, String lastname, bool usesMetric) async
  {
    RegisterSend rs = RegisterSend(username, password, email, firstname, lastname, usesMetric);
    final response = await http.post(srv + "registerUser", headers: header, body: jsonEncode(rs));
    RegisterReceive registerInfo = RegisterReceive.fromJson(jsonDecode(response.body));

    if(registerInfo.success) {
      return null;
    }
    return registerInfo.error;
  }

  static Future<String> resetPassword(String username, String email, String newPass) async
  {
    ResetPasswordSend rps = ResetPasswordSend(username, email, newPass);
    final response = await http.post(srv + "resetPassword", headers: header, body: jsonEncode(rps));
    ResetPasswordReceive resetInfo = ResetPasswordReceive.fromJson(jsonDecode(response.body));

    if(resetInfo.success){
      return null;
    }

    return resetInfo.error;
  }

}