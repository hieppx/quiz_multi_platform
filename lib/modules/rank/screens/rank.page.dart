import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_multi_platform/generated/l10n.dart';
import 'package:quiz_multi_platform/modules/rank/provider/rank.provider.dart';
import 'package:quiz_multi_platform/modules/rank/widget/item.choice.dart';
import 'package:quiz_multi_platform/modules/rank/widget/item.user.dart';
import 'package:quiz_multi_platform/modules/rank/widget/rank.container.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../common/widget/responsive/responsive_container.dart';

class RankPage extends StatefulWidget {
  const RankPage({super.key});

  @override
  State<RankPage> createState() => _RankPageState();
}

class _RankPageState extends State<RankPage> {
  final RankModel _model = RankModel();
  List<String> listTitle = [];
  String title = '';
  int selected = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      listTitle = prefs.getStringList('listTitle')!;
      title = listTitle[0];
    });
    _model.getRank(title);
  }

  void setSelected(int i) {
    setState(() {
      selected = i;
      title = listTitle[i];
    });
    _model.getRank(title);
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(
      small: RankScreen(
        listTitle: listTitle,
        title: title,
        selected: selected,
        setSelected: setSelected,
        model: _model,
        isLarge: false,
        isSmall: true,
      ),
      large: RankScreen(
        listTitle: listTitle,
        title: title,
        selected: selected,
        setSelected: setSelected,
        model: _model,
        isSmall: false,
        isLarge: true,
      ),
      medium: RankScreen(
        listTitle: listTitle,
        title: title,
        selected: selected,
        setSelected: setSelected,
        model: _model,
        isSmall: false,
        isLarge: false,
      ),
    );
  }
}

class RankScreen extends StatelessWidget {
  const RankScreen(
      {super.key,
      required this.listTitle,
      required this.title,
      required this.selected,
      required this.setSelected,
      required this.model,
      required this.isLarge,
      required this.isSmall});
  final List<String> listTitle;
  final String title;
  final int selected;
  final Function setSelected;
  final RankModel model;
  final bool isSmall;
  final bool isLarge;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isSmall == true
                ? Container()
                : isLarge == true
                    ? Text(
                        S.of(context).rank,
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      )
                    : Container(),
            const SizedBox(
              height: 20,
            ),
            _buildChips(listTitle, selected, setSelected, isSmall, isLarge),
            Expanded(
              child: SingleChildScrollView(
                  child: ChangeNotifierProvider(
                create: (_) => model,
                builder: (context, widgets) {
                  return Consumer<RankModel>(builder: (context, value, child) {
                    return value.rank.isNotEmpty
                        ? RankWidget(
                            model: value,
                            isSmall: isSmall,
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          );
                  });
                },
              )),
            )
          ],
        ));
  }

  Widget _buildChips(List<String> title, int selectedIndex,
      Function setSelected, bool isSmall, bool isLarge) {
    List<Widget> chips = [];
    for (int i = 0; i < title.length; i++) {
      ChoiceChip choiceChip = ChoiceChip(
        selected: selectedIndex == i,
        backgroundColor: const Color(0xff3564ce),
        selectedColor: const Color(0xff7743DB),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        label: ItemChoice(title: title[i]),
        onSelected: (bool selected) {
          if (selected) {
            setSelected(i);
          }
        },
      );
      chips.add(choiceChip);
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isLarge == true
                ? 7
                : isSmall == true
                    ? 2
                    : 5,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 3 / 1),
        itemCount: chips.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, index) {
          return chips[index];
        },
      ),
    );
  }
}

class RankWidget extends StatelessWidget {
  const RankWidget({super.key, required this.model, required this.isSmall});
  final RankModel model;
  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              children: [
                model.rank.length >= 3
                    ? ItemUser(
                        imageUrl: '${model.rank[2].userName}.jpg',
                        name: model.rank[2].fullName,
                        score: 'Score: ${model.rank[2].score}/25',
                        size: isSmall == true ? 60 : 100,
                      )
                    : Container(),
                const SizedBox(
                  height: 10,
                ),
                RankContainer(
                  rank: 3,
                  isSmall: isSmall,
                )
              ],
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              children: [
                ItemUser(
                  imageUrl: '${model.rank[0].userName}.jpg',
                  name: model.rank[0].fullName,
                  score: 'Score: ${model.rank[0].score}/25',
                  size: isSmall == true ? 60 : 100,
                ),
                const SizedBox(
                  height: 10,
                ),
                RankContainer(
                  rank: 1,
                  isSmall: isSmall,
                )
              ],
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              children: [
                model.rank.length >= 2
                    ? ItemUser(
                        imageUrl: '${model.rank[1].userName}.jpg',
                        name: model.rank[1].fullName,
                        score: 'Score: ${model.rank[1].score}/25',
                        size: isSmall == true ? 60 : 100)
                    : Container(),
                const SizedBox(
                  height: 10,
                ),
                RankContainer(
                  rank: 2,
                  isSmall: isSmall,
                )
              ],
            )
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        model.rank.length >= 4 ? _buildRank(context) : Container()
      ],
    );
  }

  Widget _buildRank(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: ListView.builder(
          itemCount: model.rank.length - 3,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 30),
              child: ItemUser(
                  imageUrl: '${model.rank[index + 3].userName}.jpg',
                  name: model.rank[index + 3].fullName,
                  score: 'Score: ${model.rank[index + 3].score}/25',
                  size: isSmall == true ? 60 : 80),
            );
          }),
    );
  }
}
