import 'package:http/http.dart' as http;
import 'package:quiz_multi_platform/common/url.dart';
import 'dart:async';
import 'dart:convert';
import '../models/user.dart';

class UserRepo {
  bool? _isLogin;
  bool? get isLogin => _isLogin;

  bool? _isRegister;
  bool? get isRegister => _isRegister;

  String? _userLogin;
  String? get userLogin => _userLogin;

  bool? _isReset;
  bool? get isReset => _isReset;

  Future<List<User>> getUser(String userName) async {
    var url = Uri.parse(Url.getUser);
    var res = await http.post(url, body: {"username": userName});
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      return body.map((e) => User.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load!');
    }
  }

  Future<void> uploadImage(String name, String imageData) async {
    var url = Uri.parse(Url.uploadAvatar);
    await http.post(url, body: {
      'name': name,
      'image': imageData,
    });
  }

  Future<void> login(String userName, String password) async {
    var url = Uri.parse(Url.login);
    var response = await http.post(url, body: {
      "username": userName,
      "password": password,
    });

    var data = json.decode(response.body);
    if (data.toString() == "Success") {
      _isLogin = true;
    } else {
      _isLogin = false;
    }
  }

  Future<void> register(String userName, String password, String fullName,
      String phone, String questionSecurity, String bod) async {
    var url = Uri.parse(Url.register);
    var response = await http.post(url, body: {
      "username": userName,
      "password": password,
      "full_name": fullName,
      "phone": phone,
      "question_security": questionSecurity,
      "bod": bod,
    });

    var data = json.decode(response.body);
    if (data.toString() == "Success") {
      _isRegister = true;

    } else {
      _isRegister = false;
    }
  }

  Future<void> updateUser(
      String userName, String password, String phone, String bod) async {
    var url = Uri.parse(Url.editUser);
    await http.post(url, body: {
      "username": userName,
      "password": password,
      "phone": phone,
      "bod": bod,
    });
  }

  Future<void> resetPassword(
      String userName, String questionSecurity, String password) async {
    var url = Uri.parse(Url.resetPassword);
    var res = await http.post(url, body: {
      "username": userName,
      "question_security": questionSecurity,
      "password": password
    });
    var data = json.decode(res.body);
    if (data.toString() == "Success") {
      _isReset = true;
    } else {
       _isReset = false;
    }
  }
}
