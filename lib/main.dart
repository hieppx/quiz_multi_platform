import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:quiz_multi_platform/common/routes.dart';
import 'package:quiz_multi_platform/common/theme.dart';
import 'package:quiz_multi_platform/generated/l10n.dart';
import 'package:quiz_multi_platform/modules/auth/screens/login.screen.dart';

import 'main.layout.dart';
import 'modules/auth/widget/reset.password.dart';
import 'modules/rank/screens/rank.page.dart';
import 'modules/auth/screens/register.screen.dart';
import 'modules/home/screen/home.screen.dart';
import 'modules/home/widget/score.dart';
import 'modules/information/screens/information.page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ThemeProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (ctx, themeObject, _) => MaterialApp(
          locale: themeObject.currentLocale,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ],
          supportedLocales: S.delegate.supportedLocales,
          debugShowCheckedModeBanner: false,
          title: 'Quiz App Multiplatform',
          themeMode: themeObject.mode,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: Colors.blue[600],
            brightness: Brightness.light,
            fontFamily: 'Karla',
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          darkTheme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: Colors.blue[300],
            brightness: Brightness.dark,
            backgroundColor: Colors.grey[900],
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          initialRoute: kLogin,
          routes: {
            kMain: (context) => const MainLayout(),
            kLogin: (context) => const LoginPage(),
            kRegister: (context) => const RegisterPage(),
            kResetPassword: (context) => const ResetPasswordPage(),
            kHome: (context) => const HomePage(),
            kInformation: (context) => const InformationPage(),
            kRank: (context) => const RankPage(),
            kScore: (context) => const ScoreScreen(),
          },
        ),
      ),
    );
  }
}
