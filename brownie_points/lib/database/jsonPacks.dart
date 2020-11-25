
class LoginSend {
  final String username;
  final String password;

  LoginSend(this.username, this.password);

  Map<String, dynamic> toJson() {
    return {
      'username' : username,
      'password' : password,
    };
  }
}

class LoginReceive {
  final bool success;
  final String userID;
  final String username;
  final String email;
  final String firstname;
  final String lastname;
  final bool usesMetric;
  final String error;


  LoginReceive(
      this.success,
      this.userID,
      this.username,
      this.email,
      this.firstname,
      this.lastname,
      this.usesMetric,
      this.error);

  LoginReceive.fromJson(Map<String, dynamic> json)
    : success = json['success'],
      userID = json['userID'],
      username = json['username'],
      email = json['email'],
      firstname = json['firstname'],
      lastname = json['lastname'],
      usesMetric = json['usesMetric'],
      error = json['error'];
}

class RegisterSend{
  final String username;
  final String password;
  final String email;
  final String firstname;
  final String lastname;
  final bool usesMetric;

  RegisterSend(this.username, this.password, this.email, this.firstname, this.lastname, this.usesMetric);

  Map<String, dynamic> toJson() {
    return {
      'username' : username,
      'password' : password,
      'email' : email,
      'firstname' : firstname,
      'lastname' : lastname,
      'usesMetric' : usesMetric,
    };
  }
}

class RegisterReceive {
  final bool success;
  final String userID;
  final String username;
  final String email;
  final String firstname;
  final String lastname;
  final bool usesMetric;
  final String error;


  RegisterReceive(
      this.success,
      this.userID,
      this.username,
      this.email,
      this.firstname,
      this.lastname,
      this.usesMetric,
      this.error);

  RegisterReceive.fromJson(Map<String, dynamic> json)
      : success = json['success'],
        userID = json['userID'],
        username = json['username'],
        email = json['email'],
        firstname = json['firstname'],
        lastname = json['lastname'],
        usesMetric = json['usesMetric'],
        error = json['error'];
}

class ResetPasswordSend {
  final String username;
  final String email;
  final String password;

  ResetPasswordSend(this.username, this.email, this.password);

  Map<String, dynamic> toJson() {
    return {
      'username' : username,
      'email' : email,
      'password' : password,
    };
  }
}

class ResetPasswordReceive {
  final String userID;
  final bool success;
  final String error;


  ResetPasswordReceive(this.userID, this.success, this.error);

  ResetPasswordReceive.fromJson(Map<String, dynamic> json)
      : userID = json['userID'],
        success = json['success'],
        error = json['error'];
}

