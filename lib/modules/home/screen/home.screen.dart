import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_multi_platform/common/widget/text_field.dart';
import 'package:quiz_multi_platform/generated/l10n.dart';
import 'package:quiz_multi_platform/modules/home/provider/home.controller.dart';
import 'package:quiz_multi_platform/modules/home/screen/quiz.screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/widget/avatar.dart';
import '../../../common/widget/responsive/responsive_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CourseModel _model = CourseModel();
  String? avatar;
  int? userID;
  String? fullName;
  String? userName;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      fullName = prefs.getString('fullname');
      userName = prefs.getString('userlogin');
      avatar = "$userName.jpg";
      userID = prefs.getInt('userID');
    });
    _model.getCourse();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ResponsiveContainer(
      small: HomeScreen(
          model: _model,
          width: width * 0.4,
          count: 2,
          isSmall: true,
          avatar: avatar,
          fullname: fullName,
          userID: userID,
          userName: userName,
          height: height),
      large: HomeScreen(
          model: _model,
          width: width * 0.3,
          count: 4,
          isSmall: false,
          avatar: avatar,
          fullname: fullName,
          userID: userID,
          userName: userName,
          height: height),
      medium: HomeScreen(
          model: _model,
          width: width * 0.4,
          count: 3,
          isSmall: false,
          avatar: avatar,
          fullname: fullName,
          userID: userID,
          userName: userName,
          height: height),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen(
      {super.key,
      required this.model,
      required this.width,
      required this.count,
      required this.isSmall,
      required this.avatar,
      required this.fullname,
      required this.userID,
      required this.userName,
      required this.height});
  final CourseModel model;
  final double width;
  final int count;
  final bool isSmall;
  final String? avatar;
  final String? fullname;
  final int? userID;
  final String? userName;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BasicTextField(
                controller: model.searchCourse,
                width: width,
                onChange: model.onSearch,
                label: S.of(context).searchCourse,
                icon: const Icon(
                  Icons.search,
                  color: Color(0xff3564ce),
                ),
              ),
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  fullname != null
                      ? Text(
                          fullname!,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      : Container(),
                  userName != null
                      ? Text(
                          userName!,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      : Container(),
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              avatar != null
                  ? Avatar(
                      imageUrl: avatar!,
                      size: 60,
                    )
                  : Container(),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ChangeNotifierProvider(
                create: (_) => model,
                builder: (context, widgets) =>
                    Consumer<CourseModel>(builder: (context, value, child) {
                      return value.course.isNotEmpty
                          ? isSmall
                              ? _buildSmall(context, value)
                              : _buildLarge(context, value)
                          : value.course.isEmpty &&
                                  value.searchCourse.text.isNotEmpty
                              ? const Center(
                                  child: Text('Không có khóa học này!'))
                              : const Center(
                                  child: CircularProgressIndicator(),
                                );
                    })),
          )
        ],
      ),
    ));
  }

  Widget _buildLarge(BuildContext context, CourseModel value) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: count,
            crossAxisSpacing: 30,
            mainAxisSpacing: 10,
            childAspectRatio: 2 / 1),
        padding: const EdgeInsets.all(8),
        itemCount: value.course.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: InkWell(
              onTap: () {
                value.getParamCourse(value.course[index].title ?? '',
                    value.course[index].id ?? '');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => QuizScreen(
                              title: value.course[index].title ?? '',
                            )));
              },
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: const Color(0xff3564ce)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: height! * 0.08,
                        width: height! * 0.08,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.white)),
                        child: const Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Text(
                          '${value.course[index].title}',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ],
                  )),
            ),
          );
        });
  }

  Widget _buildSmall(BuildContext context, CourseModel value) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: value.course.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: InkWell(
              onTap: () {
                value.getParamCourse(value.course[index].title ?? '',
                    value.course[index].id ?? '');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => QuizScreen(
                              title: value.course[index].title ?? '',
                            )));
              },
              child: Container(
                  height: height! * 0.2,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: const Color(0xff3564ce)),
                  child: Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: height! * 0.1,
                          width: height! * 0.1,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.white)),
                          child: const Icon(
                            Icons.play_arrow_rounded,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const Spacer(),
                        Expanded(
                          child: Text(
                            '${value.course[index].title}',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                          ),
                        ),
                        // const Spacer(),
                      ],
                    ),
                  )),
            ),
          );
        });
  }
}
