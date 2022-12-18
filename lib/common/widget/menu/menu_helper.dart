import 'package:quiz_multi_platform/common/routes.dart';

import '../../images.dart';

List<String> get menuRoutes {
  return [kHome, kInformation, kRank];
}

String getMenuIconByRoute(String route) {
  switch (route) {
    case kHome:
      return iconTabBarHome;
    case kInformation:
      return iconTabBarUsers;
    case kRank:
      return iconTabBarRank;
    default:
      return '';
  }
}
