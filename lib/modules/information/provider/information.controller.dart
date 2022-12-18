import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/user.dart';
import '../../../service/user.repo.dart';

class UserModel extends ChangeNotifier {

  UserRepo userRepo = UserRepo();

  final List<User> _user = [];
  List<User> get user => _user;

  TextEditingController? _username;
  TextEditingController? get username => _username;

  TextEditingController? _password;
  TextEditingController? get password => _password;

  TextEditingController? _phone;
  TextEditingController? get phone => _phone;

  TextEditingController? _bod;
  TextEditingController? get bod => _bod;

  Future getUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString('userlogin');
    List<User> tmp = [];
    tmp = await userRepo.getUser(value!);
    for (int i = 0; i < tmp.length; i++) {
      var item = tmp[i];
      _user.add(item);
    }
    var item = _user[0];
    _password = TextEditingController(text: item.password);
    _phone = TextEditingController(text: item.phone);
    _bod = TextEditingController(text: item.bod);
    _username = TextEditingController(text: item.userName);
    notifyListeners();
  }

  void setAvatar(String imageData) async {
    await userRepo.uploadImage(_username!.text, imageData);
    notifyListeners();
  }

  void updateUser() async {
    await userRepo.updateUser(
        _username!.text, _password!.text, _phone!.text, _bod!.text);
    notifyListeners();
  }
}
