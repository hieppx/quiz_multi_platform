// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quiz_multi_platform/common/routes.dart';
import 'package:quiz_multi_platform/generated/l10n.dart';
import '../../../common/constants.dart';
import '../../../common/widget/basic_button.dart';
import '../../../common/widget/responsive/responsive_container.dart';
import '../../../common/widget/text_field.dart';
import '../provider/register.controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterController model = RegisterController();
  final formKey = GlobalKey<FormState>();

  void showPass() {
    setState(() {
      isShowPass = !isShowPass;
    });
  }

  void selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2024),
      helpText: 'Chọn ngày sinh',
      cancelText: 'Thoát',
      confirmText: 'Chọn',
      fieldLabelText: 'Ngày sinh',
      fieldHintText: 'Month/Date/Year',
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        model.setBOD(selectedDate.toString().substring(0, 10));
      });
    }
  }

  var selectedDate = DateTime.now();
  String gender = 'Nam';
  bool isGender = true;
  bool isShowPass = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ResponsiveContainer(
        large: RegisterScreen(
          width: width * 0.45,
          model: model,
          selectedDate: selectedDate,
          isGender: isGender,
          gender: gender,
          isShowPass: isShowPass,
          showPass: showPass,
          selectDate: selectDate,
          formKey: formKey,
        ),
        small: RegisterScreen(
          width: width * 0.85,
          model: model,
          selectedDate: selectedDate,
          gender: gender,
          isGender: isGender,
          isShowPass: isShowPass,
          showPass: showPass,
          selectDate: selectDate,
          formKey: formKey,
        ),
      ),
    );
  }
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({
    Key? key,
    required this.width,
    required this.model,
    required this.selectedDate,
    required this.isGender,
    required this.gender,
    required this.isShowPass,
    required this.showPass,
    required this.selectDate,
    required this.formKey,
  }) : super(key: key);
  final double width;
  final RegisterController model;
  final DateTime selectedDate;
  final String gender;
  final bool isGender;
  final bool isShowPass;
  final Function showPass;

  final Function selectDate;
  final GlobalKey<FormState> formKey;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  File? picker;
  Uint8List? webImage;
  FilePickerResult? result;
  String? imageData;

  void selectImage() async {
    if (kIsWeb) {
      final ImagePicker pickerWeb = ImagePicker();
      XFile? image = await pickerWeb.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();
        setState(() {
          webImage = Uint8List(8);
          webImage = f;
          imageData = base64Encode(f);
        });
      }
    } else {
      result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['jpg', 'png'],
          allowMultiple: false);
      if (result != null) {
        setState(() {
          picker = File(result!.paths.first!);
          imageData = base64Encode(picker!.readAsBytesSync());
        });
      } else {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: widget.formKey,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: kDefaultPadding * 3,
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
                  height: kDefaultPadding * 2.5,
                ),
                BasicTextField(
                  controller: widget.model.userName,
                  hintext: S.of(context).labelLogin,
                  label: S.of(context).labelLogin,
                  width: widget.width,
                  icon: const Icon(
                    Icons.account_circle,
                    color: Color(0xff3564ce),
                    size: 20,
                  ),
                ),
                const SizedBox(
                  height: kDefaultPadding,
                ),
                Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: [
                    BasicTextField(
                      controller: widget.model.password,
                      hintext: S.of(context).labelPassword,
                      isObscure: !widget.isShowPass,
                      label: S.of(context).labelPassword,
                      width: widget.width,
                      icon: const Icon(
                        Icons.lock,
                        color: Color(0xff3564ce),
                        size: 20,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        widget.showPass.call();
                      },
                      child: widget.isShowPass == true
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
                  height: kDefaultPadding,
                ),
                BasicTextField(
                  controller: widget.model.fullName,
                  hintext: S.of(context).fullName,
                  label: S.of(context).fullName,
                  width: widget.width,
                  icon: const Icon(
                    Icons.account_box,
                    color: Color(0xff3564ce),
                    size: 20,
                  ),
                ),
                const SizedBox(
                  height: kDefaultPadding,
                ),
                BasicTextField(
                  controller: widget.model.phone,
                  hintext: S.of(context).phoneNumber,
                  keyboardType: TextInputType.number,
                  label: S.of(context).phoneNumber,
                  width: widget.width,
                  icon: const Icon(
                    Icons.phone,
                    color: Color(0xff3564ce),
                    size: 20,
                  ),
                ),
                const SizedBox(
                  height: kDefaultPadding,
                ),
                BasicTextField(
                  controller: widget.model.questionSecurity,
                  hintext: S.of(context).securityQuestion,
                  label: S.of(context).securityQuestion,
                  width: widget.width,
                  icon: const Icon(
                    Icons.security,
                    color: Color(0xff3564ce),
                    size: 20,
                  ),
                ),
                const SizedBox(
                  height: kDefaultPadding,
                ),
                Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    SizedBox(height: 80, width: 80, child: image(context)),
                    IconButton(
                        onPressed: selectImage,
                        icon: const Icon(
                          Icons.image,
                          color: Colors.amberAccent,
                        )),
                  ],
                ),
                SizedBox(
                  width: widget.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).birthday,
                        style: const TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        height: 30,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            widget.selectDate.call();
                          },
                          label: Text(
                              widget.selectedDate.toString().substring(0, 10)),
                          icon: const Icon(Icons.arrow_drop_down),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff3B9AE1)),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Column(
                      children: [
                        BacsicButton(
                          onPressed: () async {
                            if (webImage == null && picker == null) {
                              Flushbar(
                                message: S.of(context).noImage,
                                icon: const Icon(
                                  Icons.info_outline,
                                  size: 28.0,
                                  color: Colors.black,
                                ),
                                backgroundColor: Colors.amber,
                                duration: const Duration(seconds: 2),
                                flushbarPosition: FlushbarPosition.TOP,
                              ).show(context);
                            } else {
                              if (widget.formKey.currentState!.validate()) {
                                await widget.model.register(imageData!);
                                if (widget.model.isRegister == true) {
                                  Flushbar(
                                    message: S.of(context).successRegister,
                                    icon: const Icon(
                                      Icons.done,
                                      size: 28.0,
                                      color: Colors.black,
                                    ),
                                    backgroundColor: Colors.green,
                                    duration: const Duration(seconds: 2),
                                    flushbarPosition: FlushbarPosition.TOP,
                                  ).show(context);
                                  onBack(context);
                                } else {
                                  Flushbar(
                                    message: S.of(context).errorRegiter,
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
                            }
                          },
                          label: S.of(context).labelRegister,
                          width: widget.width,
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                      ],
                    ),
                    TextButton(
                        onPressed: () {
                          onBack(context);
                        },
                        child: Text(S.of(context).haveAccount)),
                  ],
                ),
                const SizedBox(
                  height: kDefaultPadding,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget image(BuildContext context) {
    if (kIsWeb) {
      return webImage != null
          ? CircleAvatar(
              radius: 12,
              backgroundColor: Colors.grey.shade200,
              backgroundImage: MemoryImage(webImage!))
          : CircleAvatar(
              radius: 12,
              backgroundColor: Colors.grey.shade200,
              backgroundImage: const AssetImage('assets/avatar.jpg'));
    } else {
      return picker != null
          ? CircleAvatar(
              radius: 12,
              backgroundColor: Colors.grey.shade200,
              backgroundImage: Image.file(
                File(picker!.path.toString()),
              ).image,
            )
          : CircleAvatar(
              radius: 12,
              backgroundColor: Colors.grey.shade200,
              backgroundImage: const AssetImage('assets/avatar.jpg'));
    }
  }

  void onBack(BuildContext context) {
    Navigator.of(context).pushNamed(kLogin);
  }
}
