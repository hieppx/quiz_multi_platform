import 'package:flutter/widgets.dart';
import 'package:quiz_multi_platform/service/user.repo.dart';

class ResetPasswordModel extends ChangeNotifier {
  UserRepo userRepo = UserRepo();

  final TextEditingController _userName = TextEditingController();
  TextEditingController get userName => _userName;

  final TextEditingController _password = TextEditingController();
  TextEditingController get password => _password;

  final TextEditingController _questionSecurity = TextEditingController();
  TextEditingController get questionSecurity => _questionSecurity;

  bool? _isReset;
  bool? get isReset => _isReset;

  Future resetPassword() async {
    await userRepo.resetPassword(
        _userName.text, _questionSecurity.text, _password.text);
    _isReset = userRepo.isReset;
    notifyListeners();
  }
}
