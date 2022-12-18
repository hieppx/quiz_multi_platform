import 'package:flutter/material.dart';
import 'package:quiz_multi_platform/common/toSvg.dart';
import 'package:quiz_multi_platform/common/widget/drop.down.dart';
import 'package:quiz_multi_platform/common/widget/menu/menu_helper.dart';
import 'package:quiz_multi_platform/common/widget/switch.dart';

import '../../routes.dart';
import '../../titles.dart';

class VerticalTabBar extends StatefulWidget {
  const VerticalTabBar(
      {Key? key, required this.selectedRoute, required this.onChanged})
      : super(key: key);
  final String selectedRoute;
  final Function(String) onChanged;

  @override
  State<VerticalTabBar> createState() => _VerticalTabBarState();
}

class _VerticalTabBarState extends State<VerticalTabBar> {
  late String _selectedRoute = widget.selectedRoute;

  @override
  Widget build(BuildContext context) {
    final items = menuRoutes;
    final selectedIndex = items.indexWhere((e) => e == _selectedRoute);
    return Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                SizedBox(
                  width: 120,
                  child: NavigationRail(
                    groupAlignment: 0,
                    selectedIndex: selectedIndex == -1 ? 0 : selectedIndex,
                    onDestinationSelected: (int index) {
                      setState(() {
                        _selectedRoute = items[index];
                      });
                      widget.onChanged(items[index]);
                    },
                    labelType: NavigationRailLabelType.all,
                    destinations: [
                      ...items
                          .map((e) => NavigationRailDestination(
                              icon: getMenuIconByRoute(e).toSvg(
                                  width: 30,
                                  height: 30,
                                  color: _selectedRoute == e
                                      ? const Color(0xFF6192F5)
                                      : const Color(0xFFC5C5C5)),
                              label: Text(getTitleByRoute(e, context))))
                          .toList(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Image.asset(
                    'assets/logo.png',
                    width: 100,
                    height: 100,
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 150),
              child: SwitchButton(),
            ),
            const Padding(
                padding: EdgeInsets.symmetric(vertical: 100),
                child: Language()),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: IconButton(
                onPressed: _logout,
                icon: const Icon(Icons.logout_sharp),
              ),
            ),
          ],
        ),
        const VerticalDivider(thickness: 1, width: 1),
      ],
    );
  }

  void _logout() {
    Navigator.of(context).pushReplacementNamed(kLogin);
  }
}
