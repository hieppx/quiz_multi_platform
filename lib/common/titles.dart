import 'package:flutter/widgets.dart';
import 'package:quiz_multi_platform/common/routes.dart';
import 'package:quiz_multi_platform/generated/l10n.dart';

String getTitleByRoute(String route, BuildContext context) {
  switch (route) {
    case kHome:
      return S.of(context).labelHome;
    case kInformation:
      return S.of(context).information;
    case kRank:
      return S.of(context).rank;
    default:
      return 'Infomation';
  }
}
