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

  static void updateUserInfo(String firstname, String lastname, String email, String username, String usesMetric, String userID){
    if (username != null) EditPreferences.save("username", username);
    if (email != null) EditPreferences.save("email", email);
    if (usesMetric != null) EditPreferences.save("metric", usesMetric);
    if (userID != null) EditPreferences.save("userID", userID);
    if (firstname != null) EditPreferences.save("first", firstname);
    if (lastname != null) EditPreferences.save("last", lastname);
  }
}