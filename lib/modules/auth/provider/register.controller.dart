import 'package:flutter/material.dart';


import '../../../service/user.repo.dart';

class RegisterController extends ChangeNotifier {
  final TextEditingController _userName = TextEditingController();
  TextEditingController get userName => _userName;

  final TextEditingController _password = TextEditingController();
  TextEditingController get password => _password;

  final TextEditingController _fullName = TextEditingController();
  TextEditingController get fullName => _fullName;

  final TextEditingController _phone = TextEditingController();
  TextEditingController get phone => _phone;

  final TextEditingController _questionSecurity = TextEditingController();
  TextEditingController get questionSecurity => _questionSecurity;

  String? _bod;
  String? get bod => _bod;


  bool? _isPassword;
  bool? get isPassword => _isPassword;

  bool? _isRegister;
  bool? get isRegister => _isRegister;

  var selectedDate = DateTime.now();

  UserRepo userRepo = UserRepo();

  void setBOD(String bOd) {
    _bod = bOd;
    notifyListeners();
  }



  Future<void> register(String imageData) async {
    await userRepo.uploadImage(_userName.text, imageData);
    await userRepo.register(
        _userName.text,
        _password.text,
        fullName.text,
        phone.text,
        questionSecurity.text,
        _bod ?? selectedDate.toString().substring(0, 10),
        );
    _isRegister = userRepo.isRegister;
    notifyListeners();
  }
}
