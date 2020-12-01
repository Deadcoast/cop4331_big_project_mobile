import 'dart:async';
import 'dart:convert';
import 'package:brownie_points/database/awsIntegration.dart';
import 'package:brownie_points/database/savePrefs.dart';
import 'package:brownie_points/forms/submitImageForm.dart';
import 'package:http/http.dart' as http;
import 'package:brownie_points/database/jwtDecode.dart';

import 'jsonPacks.dart';


class JsonCall {
  static final srv = "https://brownie-points-4331-6.herokuapp.com/api/";
  static final header = {"Content-Type": "application/json"};

  static Future<String> login(String username, String password) async
  {
    LoginSend ls = LoginSend(username, password);
    Map<String, dynamic> js = ls.toJson();

    final response = await http.post(srv + "login",headers: header, body: jsonEncode(js));
    final responseMap = JwtDecoder.getBodyDecoded(response.body);
    var loginInfo = LoginReceive.fromJson(responseMap);

    if (loginInfo.success) {
      EditPreferences.updateUserInfo(loginInfo.firstname, loginInfo.lastname, loginInfo.email, loginInfo.username, loginInfo.usesMetric.toString(), loginInfo.userID);
      return null;
    }

    return loginInfo.error;
  }

  static Future<String> register(String username, String password, String email, String firstname, String lastname, bool usesMetric) async
  {
    RegisterSend rs = RegisterSend(username, password, email, firstname, lastname, usesMetric);
    final response = await http.post(srv + "registerUser", headers: header, body: jsonEncode(rs));
    final responseMap = JwtDecoder.getBodyDecoded(response.body);
    RegisterReceive registerInfo = RegisterReceive.fromJson(responseMap);

    if(registerInfo.success) {
      return null;
    }
    return registerInfo.error;
  }

  static Future<String> resetPassword(String username, String email, String newPass) async
  {
    ResetPasswordSend rps = ResetPasswordSend(username, email, newPass);
    final response = await http.post(srv + "SendResetPasswordEmail", headers: header, body: jsonEncode(rps));
    print("/${response.body}/");
    final responseMap = JwtDecoder.getBodyDecoded(response.body);
    ResetPasswordReceive resetInfo = ResetPasswordReceive.fromJson(responseMap);
    if(resetInfo.success){
      return null;
    }
    return resetInfo.error;
  }


  static Future<String> createRecipe(String title, List<String> steps,  List<String> amt, List<String> names, List<String> units, bool public, String category) async
  {
    String jsonEncodedRecipe = "";
    Map<String, String> prefs = await EditPreferences.fetchProfileInfo();
    String imageURL = await AwsIntegration.uploadImage(ImageFormState.image);
    jsonEncodedRecipe += "{\"isMetric\":${prefs['metric']},\"picture\": \"$imageURL\",\"publicRecipe\":$public,\"title\":\"$title\", \"author\":\"${prefs['userID']}\",\"instructions\":[";
    for(int i = 0; i < steps.length; i++)
    {
        jsonEncodedRecipe += "{\"instruction\":\"${steps.elementAt(i)}\"},";
    }
    jsonEncodedRecipe =jsonEncodedRecipe.substring(0,jsonEncodedRecipe.length-1) + "],";
    jsonEncodedRecipe += "\"categories\":[\"$category\"],";
    jsonEncodedRecipe += "\"ingredients\":[";
    for(int i = 0; i < amt.length; i++)
    {
      jsonEncodedRecipe += "{\"ingredient\":\"${names.elementAt(i)}\",";
      double amts = double.parse(amt.elementAt(i));
      jsonEncodedRecipe += "\"quantity\":$amts,";
      jsonEncodedRecipe += "\"unit\":\"${units.elementAt(i)}\"},";
    }
    jsonEncodedRecipe =jsonEncodedRecipe.substring(0,jsonEncodedRecipe.length-1) + "]}";
    final response = await http.post(srv + "createRecipe", headers: header, body: jsonEncodedRecipe);
    final responseMap = JwtDecoder.getBodyDecoded(response.body);
    return responseMap['error'];
  }

  static Future<FetchRecipesReceive> fetchRecipe(String title, String category, bool userRecipes, int currentPage, int pageCapacity) async
  {
    if (title == "")
      title = null;
    FetchRecipesSend frs = FetchRecipesSend(title, category, userRecipes, (await EditPreferences.fetchProfileInfo())['userID'], currentPage, pageCapacity);
    final response = await http.post(srv + "fetchRecipes", headers: header, body: jsonEncode(frs));
    final responseMap = JwtDecoder.getBodyDecoded(response.body);
    FetchRecipesReceive recipes = FetchRecipesReceive.fromJson(responseMap);
    return recipes;
  }

  static Future<String> deleteRecipe(String id) async
  {
    DeleteSend ds = DeleteSend(id);
    final response = await http.post(srv + "deleteRecipe", headers: header, body: jsonEncode(ds));
    final responseMap = JwtDecoder.getBodyDecoded(response.body);

    if(responseMap['success'])
      return responseMap['error'];
    return null;
  }

  static Future<String> updateUserInfo(String first, String last, String user, String email, bool metric) async
  {
    String id = await EditPreferences.read('userID');
    String jsonPack = "{\"userID\":\"$id\",\"newInfo\":{";
    if(first != null)
      jsonPack += "\"firstName\":\"${first.trim()}\",";
    if(last != null)
      jsonPack += "\"lastName\":\"${last.trim()}\",";
    if(user != null)
      jsonPack += "\"userName\":\"${user.trim()}\",";
    if(email != null)
      jsonPack += "\"email\":\"${email.trim()}\",";
    jsonPack += "\"usesMetric\":$metric}}";
    final response = await http.post(srv + "updateUserInfo", headers: header, body: jsonPack);
    final responseMap = JwtDecoder.getBodyDecoded(response.body);
    EditPreferences.updateUserInfo(first, last, email, user, metric.toString(), id);
    if(responseMap['success'])
      return null;
    return responseMap['error'];
  }
}
