import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/user.dart';
import '../../../service/user.repo.dart';

class LoginController extends ChangeNotifier {
  final TextEditingController _userName = TextEditingController();
  TextEditingController get userName => _userName;

  final TextEditingController _password = TextEditingController();
  TextEditingController get password => _password;

  final TextEditingController _questionSecurity = TextEditingController();
  TextEditingController get questionSecurity => _questionSecurity;

  UserRepo userRepo = UserRepo();

  bool? _isLogin;
  bool? get isLogin => _isLogin;
  Future login() async {
    await userRepo.login(_userName.text, _password.text);
    _isLogin = userRepo.isLogin;
    getUser(_userName.text);
    notifyListeners();
  }

  User _user = User();
  User get user => _user;

  Future getUser(String userName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userlogin', userName);
    var listUser = await userRepo.getUser(_userName.text);
    _user = listUser[0];
    await prefs.setInt('userID', _user.id!);
    await prefs.setString('fullname', _user.fullName!);
    notifyListeners();
  }
}
