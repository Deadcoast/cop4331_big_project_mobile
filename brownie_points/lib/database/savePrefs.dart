import 'package:shared_preferences/shared_preferences.dart';
class EditPreferences {
  static Future<String> read(final key) async
  {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static void save(final key, final value) async
  {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value.toString());
  }

  static Future<Map<String, String>> fetchProfileInfo() async {
    return{
      'username': await read("username"),
      'email' : await read("email"),
      'first' : await read("first"),
      'last': await read("last"),
      'metric' :await read("metric"),
      'userID' : await read("userID"),
    };
  }
}