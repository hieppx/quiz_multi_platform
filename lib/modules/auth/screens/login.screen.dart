// ignore_for_file: use_build_context_synchronously

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:quiz_multi_platform/generated/l10n.dart';
import '../../../common/constants.dart';
import '../../../common/routes.dart';
import '../../../common/widget/basic_button.dart';
import '../../../common/widget/responsive/responsive_container.dart';
import '../../../common/widget/text_field.dart';
import '../provider/login.controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final form = GlobalKey<FormState>();
  LoginController model = LoginController();
  bool isShowPass = false;
  void showPass() {
    setState(() {
      isShowPass = !isShowPass;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ResponsiveContainer(
      large: LoginScreen(
        model: model,
        width: width * 0.45,
        form: form,
        showPass: showPass,
        isShowPass: isShowPass,
      ),
      small: LoginScreen(
        model: model,
        width: width * 0.85,
        form: form,
        showPass: showPass,
        isShowPass: isShowPass,
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
    required this.model,
    required this.width,
    required this.form,
    required this.showPass,
    required this.isShowPass,
  });
  final LoginController model;
  final double width;
  final GlobalKey<FormState> form;
  final bool isShowPass;
  final Function showPass;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: form,
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: kDefaultPadding * 5,
              ),
              const Text(
                "Let's Play Quiz",
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
              ),
              const Text(
                " Enter your information below",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: kDefaultPadding * 10,
              ),
              BasicTextField(
                controller: model.userName,
                hintext: S.of(context).labelLogin,
                label: S.of(context).labelLogin,
                icon: const Icon(
                  Icons.account_circle,
                  color: Color(0xff3564ce),
                  size: 20,
                ),
                width: width,
              ),
              const SizedBox(
                height: kDefaultPadding * 2,
              ),
              Stack(
                alignment: AlignmentDirectional.centerEnd,
                children: [
                  BasicTextField(
                    controller: model.password,
                    hintext: S.of(context).labelPassword,
                    isObscure: !isShowPass,
                    label: S.of(context).labelPassword,
                    icon: const Icon(
                      Icons.lock,
                      color: Color(0xff3564ce),
                      size: 20,
                    ),
                    width: width,
                  ),
                  TextButton(
                    onPressed: () {
                      showPass.call();
                    },
                    child: isShowPass == true
                        ? Text(
                            S.of(context).hidePassword,
                            style: const TextStyle(fontSize: 10),
                          )
                        : Text(S.of(context).showPassword,
                            style: const TextStyle(fontSize: 10)),
                  )
                ],
              ),
              const SizedBox(
                height: kDefaultPadding * 2,
              ),
              BacsicButton(
                onPressed: () async {
                  if (form.currentState!.validate()) {
                    await model.login();
                    if (model.isLogin == true) {
                      homePage(context);
                    } else {
                      Flushbar(
                        message: S.of(context).errorLogin,
                        icon: const Icon(
                          Icons.info_outline,
                          size: 28.0,
                          color: Colors.black,
                        ),
                        backgroundColor: Colors.amber,
                        duration: const Duration(seconds: 2),
                        flushbarPosition: FlushbarPosition.TOP,
                      ).show(context);
                    }
                  }
                },
                label: S.of(context).buttonLogin,
                width: width,
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          resetPage(context);
                        },
                        child: Text(S.of(context).forgotPassword)),
                    TextButton(
                        onPressed: () {
                          registerPage(context);
                        },
                        child: Text(S.of(context).noAccount)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  void homePage(BuildContext context) {
    Navigator.of(context).pushNamed(kMain);
  }

  void registerPage(BuildContext context) {
    Navigator.of(context).pushNamed(kRegister);
  }

  void resetPage(BuildContext context) {
    Navigator.of(context).pushNamed(kResetPassword);
  }
}
