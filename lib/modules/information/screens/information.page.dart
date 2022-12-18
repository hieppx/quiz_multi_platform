import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:quiz_multi_platform/common/widget/basic_button.dart';
import 'package:quiz_multi_platform/generated/l10n.dart';
import 'package:quiz_multi_platform/modules/information/provider/information.controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/widget/responsive/responsive_container.dart';
import '../../../common/widget/text_field.dart';
import '../../../common/widget/avatar.dart';

class InformationPage extends StatefulWidget {
  const InformationPage({super.key});

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  final UserModel _model = UserModel();
  File? picker;
  Uint8List? webImage;
  FilePickerResult? result;
  String? imageData;
  bool isChange = false;
  String? avatar;
  bool isShowPass = false;
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    final prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString('userlogin');
    setState(() {
      avatar = "$value.jpg";
    });
    _model.getUser();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ResponsiveContainer(
      small: InformationScreen(
        model: _model,
        width: width * 0.8,
        isSmall: true,
        isMedium: false,
        isShowPass: isShowPass,
        showPass: showPass,
        isChange: isChange,
        selectImage: selectImage,
        webImage: webImage,
        picker: picker,
        avatar: avatar,
      ),
      large: InformationScreen(
        model: _model,
        width: width * 0.28,
        isSmall: false,
        isMedium: false,
        isShowPass: isShowPass,
        showPass: showPass,
        isChange: isChange,
        selectImage: selectImage,
        webImage: webImage,
        picker: picker,
        avatar: avatar,
      ),
      medium: InformationScreen(
        model: _model,
        width: width * 0.3,
        isSmall: false,
        isMedium: true,
        isShowPass: isShowPass,
        showPass: showPass,
        isChange: isChange,
        selectImage: selectImage,
        webImage: webImage,
        picker: picker,
        avatar: avatar,
      ),
    );
  }

  void showPass() {
    setState(() {
      isShowPass = !isShowPass;
    });
  }

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
    _model.setAvatar(imageData!);
  }
}

class InformationScreen extends StatelessWidget {
  const InformationScreen(
      {super.key,
      required this.model,
      required this.width,
      required this.isSmall,
      required this.isMedium,
      required this.isShowPass,
      required this.showPass,
      required this.isChange,
      required this.selectImage,
      required this.webImage,
      required this.picker,
      required this.avatar});
  final double width;
  final UserModel model;
  final bool isSmall;
  final bool isMedium;
  final bool isShowPass;
  final Function showPass;
  final bool? isChange;
  final Function? selectImage;
  final Uint8List? webImage;
  final File? picker;
  final String? avatar;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          !isSmall && !isMedium
              ? Text(
                  S.of(context).personalInformation,
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                )
              : Container(),
          const SizedBox(
            height: 20,
          ),
          isSmall
              ? Center(
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      SizedBox(
                        height: 120,
                        width: 120,
                        child: image(context),
                      ),
                      IconButton(
                          onPressed: () {
                            selectImage!.call();
                          },
                          icon: const Icon(
                            Icons.image,
                            color: Colors.amberAccent,
                          ))
                    ],
                  ),
                )
              : Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    SizedBox(
                      height: 120,
                      width: 120,
                      child: image(context),
                    ),
                    IconButton(
                        onPressed: () {
                          selectImage!.call();
                        },
                        icon: const Icon(
                          Icons.image,
                          color: Colors.amberAccent,
                        ))
                  ],
                ),
          Expanded(
            child: SingleChildScrollView(
              child: ChangeNotifierProvider(
                  create: (_) => model,
                  builder: (context, widgets) =>
                      Consumer<UserModel>(builder: (context, value, child) {
                        return value.user.isNotEmpty
                            ? isSmall
                                ? _buildSmall(
                                    context, width, value, isShowPass, showPass)
                                : _buildLarge(
                                    context, width, value, isShowPass, showPass)
                            : const Center(
                                child: CircularProgressIndicator(),
                              );
                      })),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmall(
    BuildContext context,
    double width,
    UserModel value,
    bool isShowPass,
    Function showPass,
  ) {
    TextEditingController controller = TextEditingController();
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            S.of(context).labelLogin,
            style: const TextStyle(fontSize: 15, color: Colors.blue),
          ),
          const SizedBox(
            height: 10,
          ),
          BasicTextField(
            width: width,
            label: value.user[0].userName ?? '',
            controller: controller,
            enabled: false,
            icon: const Icon(
              Icons.account_circle,
              color: Color(0xff3564ce),
              size: 20,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            S.of(context).labelPassword,
            style: const TextStyle(fontSize: 15, color: Colors.blue),
          ),
          const SizedBox(
            height: 10,
          ),
          Stack(
            alignment: AlignmentDirectional.centerEnd,
            children: [
              BasicTextField(
                width: width,
                controller: value.password!,
                isObscure: !isShowPass,
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
            height: 20,
          ),
          Text(
            S.of(context).fullName,
            style: const TextStyle(fontSize: 15, color: Colors.blue),
          ),
          const SizedBox(
            height: 10,
          ),
          BasicTextField(
            width: width,
            label: value.user[0].fullName ?? '',
            controller: controller,
            enabled: false,
            icon: const Icon(
              Icons.account_box,
              color: Color(0xff3564ce),
              size: 20,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            S.of(context).phoneNumber,
            style: const TextStyle(fontSize: 15, color: Colors.blue),
          ),
          const SizedBox(
            height: 10,
          ),
          BasicTextField(
            width: width,
            controller: value.phone!,
            icon: const Icon(
              Icons.phone,
              color: Color(0xff3564ce),
              size: 20,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            S.of(context).birthday,
            style: const TextStyle(fontSize: 15, color: Colors.blue),
          ),
          const SizedBox(
            height: 10,
          ),
          BasicTextField(
            width: width,
            controller: value.bod!,
            icon: const Icon(
              Icons.event_available,
              color: Color(0xff3564ce),
              size: 20,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            S.of(context).securityQuestion,
            style: const TextStyle(fontSize: 15, color: Colors.blue),
          ),
          const SizedBox(
            height: 10,
          ),
          BasicTextField(
            width: width,
            label: value.user[0].questionSecurity ?? '',
            controller: controller,
            enabled: false,
            icon: const Icon(
              Icons.security,
              color: Color(0xff3564ce),
              size: 20,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(left: width * 0.3),
            child: BacsicButton(
              label: S.of(context).labelUpdate,
              onPressed: value.updateUser,
              width: width * 0.4,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLarge(BuildContext context, double width, UserModel value,
      bool isShowPass, Function showPass) {
    TextEditingController controller = TextEditingController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).labelLogin,
                  style: const TextStyle(fontSize: 15, color: Colors.blue),
                ),
                const SizedBox(
                  height: 10,
                ),
                BasicTextField(
                  width: width,
                  label: value.user[0].userName ?? '',
                  controller: controller,
                  enabled: false,
                  icon: const Icon(
                    Icons.account_circle,
                    color: Color(0xff3564ce),
                    size: 20,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).labelPassword,
                  style: const TextStyle(fontSize: 15, color: Colors.blue),
                ),
                const SizedBox(
                  height: 10,
                ),
                Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: [
                    BasicTextField(
                      width: width,
                      controller: value.password!,
                      isObscure: !isShowPass,
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
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).fullName,
                  style: const TextStyle(fontSize: 15, color: Colors.blue),
                ),
                const SizedBox(
                  height: 10,
                ),
                BasicTextField(
                  width: width,
                  label: value.user[0].fullName ?? '',
                  controller: controller,
                  enabled: false,
                  icon: const Icon(
                    Icons.account_box,
                    color: Color(0xff3564ce),
                    size: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).phoneNumber,
                  style: const TextStyle(fontSize: 15, color: Colors.blue),
                ),
                const SizedBox(
                  height: 10,
                ),
                BasicTextField(
                  width: width,
                  controller: value.phone!,
                  icon: const Icon(
                    Icons.phone,
                    color: Color(0xff3564ce),
                    size: 20,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).birthday,
                  style: const TextStyle(fontSize: 15, color: Colors.blue),
                ),
                const SizedBox(
                  height: 10,
                ),
                BasicTextField(
                  width: width,
                  controller: value.bod!,
                  icon: const Icon(
                    Icons.event_available,
                    color: Color(0xff3564ce),
                    size: 20,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).securityQuestion,
                  style: const TextStyle(fontSize: 15, color: Colors.blue),
                ),
                const SizedBox(
                  height: 10,
                ),
                BasicTextField(
                  width: width,
                  label: value.user[0].questionSecurity ?? '',
                  controller: controller,
                  enabled: false,
                  icon: const Icon(
                    Icons.security,
                    color: Color(0xff3564ce),
                    size: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: BacsicButton(
            label: S.of(context).labelUpdate,
            onPressed: value.updateUser,
            width: width * 0.4,
          ),
        )
      ],
    );
  }

  Widget image(BuildContext context) {
    if (kIsWeb) {
      return webImage != null
          ? CircleAvatar(
              radius: 12,
              backgroundColor: Colors.grey.shade200,
              backgroundImage: MemoryImage(webImage!))
          : avatar != null
              ? Avatar(
                  imageUrl: avatar!,
                  size: 100,
                )
              : const CircularProgressIndicator();
    } else {
      return picker != null
          ? CircleAvatar(
              radius: 12,
              backgroundColor: Colors.grey.shade200,
              backgroundImage: Image.file(
                File(picker!.path.toString()),
              ).image,
            )
          : avatar != null
              ? Avatar(
                  imageUrl: avatar!,
                  size: 100,
                )
              : const CircularProgressIndicator();
    }
  }
}
