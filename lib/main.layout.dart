import 'package:flutter/material.dart';
import 'package:quiz_multi_platform/common/routes.dart';
import 'package:quiz_multi_platform/common/titles.dart';
import 'package:quiz_multi_platform/modules/rank/screens/rank.page.dart';
import 'package:quiz_multi_platform/modules/home/screen/home.screen.dart';

import 'common/widget/menu/left_menu.dart';
import 'common/widget/responsive/responsive_container.dart';
import 'common/widget/menu/vertical_tabbar.dart';
import 'modules/information/screens/information.page.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  String _currentRoute = kHome;
  void _onChangedTabBar(String route) {
    setState(() {
      _currentRoute = route;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(
      large: Scaffold(
        body: Row(
          children: [
            VerticalTabBar(
                selectedRoute: _currentRoute, onChanged: _onChangedTabBar),
            Expanded(child: _buildContent(context))
          ],
        ),
      ),
      small: Scaffold(
          appBar: _enableMainAppBar()
              ? AppBar(
                  title: Text(
                    getTitleByRoute(_currentRoute, context),
                  ),
                  centerTitle: true,
                )
              : null,
          drawer: LeftMenu(onChanged: _onChangedTabBar),
          body: _buildContent(context)),
    );
  }

  Widget _buildContent(BuildContext context) {
    switch (_currentRoute) {
      case kHome:
        return const HomePage();
      case kInformation:
        return const InformationPage();
      case kRank:
        return const RankPage();
      default:
        return Center(
          child: Text('No content for $_currentRoute'),
        );
    }
  }

  bool _enableMainAppBar() {
    switch (_currentRoute) {
      case kHome:
      case kInformation:
      case kRank:
        return true;
      default:
        return false;
    }
  }
}
