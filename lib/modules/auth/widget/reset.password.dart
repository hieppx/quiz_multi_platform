// ignore_for_file: use_build_context_synchronously

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import '../../../common/constants.dart';
import '../../../common/routes.dart';
import '../../../common/widget/basic_button.dart';
import '../../../common/widget/responsive/responsive_container.dart';
import '../../../common/widget/text_field.dart';
import '../../../generated/l10n.dart';
import '../provider/reset.password.controller.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final form = GlobalKey<FormState>();
  ResetPasswordModel model = ResetPasswordModel();
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
      large: ResetPassword(
        model: model,
        width: width * 0.45,
        form: form,
        showPass: showPass,
        isShowPass: isShowPass,
      ),
      small: ResetPassword(
        model: model,
        width: width * 0.85,
        form: form,
        showPass: showPass,
        isShowPass: isShowPass,
      ),
    );
  }
}

class ResetPassword extends StatelessWidget {
  const ResetPassword({
    super.key,
    required this.model,
    required this.width,
    required this.form,
    required this.showPass,
    required this.isShowPass,
  });
  final ResetPasswordModel model;
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
                width: width,
                icon: const Icon(
                  Icons.account_circle,
                  color: Color(0xff3564ce),
                  size: 20,
                ),
              ),
              const SizedBox(
                height: kDefaultPadding * 2,
              ),
              BasicTextField(
                controller: model.questionSecurity,
                hintext: S.of(context).securityQuestion,
                label: S.of(context).securityQuestion,
                width: width,
                icon: const Icon(
                  Icons.security,
                  color: Color(0xff3564ce),
                  size: 20,
                ),
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
                    width: width,
                    icon: const Icon(
                      Icons.lock,
                      color: Color(0xff3564ce),
                      size: 20,
                    ),
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
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Column(
                    children: [
                      BacsicButton(
                        onPressed: () async {
                          if (form.currentState!.validate()) {
                            await model.resetPassword();
                            if (model.isReset == true) {
                              Flushbar(
                                message: S.of(context).resetSuccess,
                                icon: const Icon(
                                  Icons.done,
                                  size: 28.0,
                                  color: Colors.black,
                                ),
                                backgroundColor: Colors.green,
                                duration: const Duration(seconds: 2),
                                flushbarPosition: FlushbarPosition.TOP,
                              ).show(context);
                            } else {
                              Flushbar(
                                message: S.of(context).resetError,
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
                        label: S.of(context).confirm,
                        width: width,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                  TextButton(
                      onPressed: () {
                        loginPage(context);
                      },
                      child: Text(S.of(context).continueLogin)),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    ));
  }

  void loginPage(BuildContext context) {
    Navigator.of(context).pushNamed(kLogin);
  }
}
