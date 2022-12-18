// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Account`
  String get labelLogin {
    return Intl.message(
      'Account',
      name: 'labelLogin',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get labelPassword {
    return Intl.message(
      'Password',
      name: 'labelPassword',
      desc: '',
      args: [],
    );
  }

  /// `Show`
  String get showPassword {
    return Intl.message(
      'Show',
      name: 'showPassword',
      desc: '',
      args: [],
    );
  }

  /// `Hide`
  String get hidePassword {
    return Intl.message(
      'Hide',
      name: 'hidePassword',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get buttonLogin {
    return Intl.message(
      'Login',
      name: 'buttonLogin',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Do not have an account?`
  String get noAccount {
    return Intl.message(
      'Do not have an account?',
      name: 'noAccount',
      desc: '',
      args: [],
    );
  }

  /// `Security question`
  String get securityQuestion {
    return Intl.message(
      'Security question',
      name: 'securityQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Continue to login`
  String get continueLogin {
    return Intl.message(
      'Continue to login',
      name: 'continueLogin',
      desc: '',
      args: [],
    );
  }

  /// `Full name`
  String get fullName {
    return Intl.message(
      'Full name',
      name: 'fullName',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phoneNumber {
    return Intl.message(
      'Phone',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Birthday`
  String get birthday {
    return Intl.message(
      'Birthday',
      name: 'birthday',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get labelRegister {
    return Intl.message(
      'Register',
      name: 'labelRegister',
      desc: '',
      args: [],
    );
  }

  /// `Do you already have an account?`
  String get haveAccount {
    return Intl.message(
      'Do you already have an account?',
      name: 'haveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get labelHome {
    return Intl.message(
      'Home',
      name: 'labelHome',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get information {
    return Intl.message(
      'Account',
      name: 'information',
      desc: '',
      args: [],
    );
  }

  /// `Rank`
  String get rank {
    return Intl.message(
      'Rank',
      name: 'rank',
      desc: '',
      args: [],
    );
  }

  /// `Search course`
  String get searchCourse {
    return Intl.message(
      'Search course',
      name: 'searchCourse',
      desc: '',
      args: [],
    );
  }

  /// `Personal Information`
  String get personalInformation {
    return Intl.message(
      'Personal Information',
      name: 'personalInformation',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get labelUpdate {
    return Intl.message(
      'Update',
      name: 'labelUpdate',
      desc: '',
      args: [],
    );
  }

  /// `Input`
  String get input {
    return Intl.message(
      'Input',
      name: 'input',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Appearance`
  String get appearance {
    return Intl.message(
      'Appearance',
      name: 'appearance',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Question`
  String get question {
    return Intl.message(
      'Question',
      name: 'question',
      desc: '',
      args: [],
    );
  }

  /// `User account or password incorrect!`
  String get errorLogin {
    return Intl.message(
      'User account or password incorrect!',
      name: 'errorLogin',
      desc: '',
      args: [],
    );
  }

  /// `Password reset successful!`
  String get resetSuccess {
    return Intl.message(
      'Password reset successful!',
      name: 'resetSuccess',
      desc: '',
      args: [],
    );
  }

  /// `User account or security question incorrect!`
  String get resetError {
    return Intl.message(
      'User account or security question incorrect!',
      name: 'resetError',
      desc: '',
      args: [],
    );
  }

  /// `Successful account register!`
  String get successRegister {
    return Intl.message(
      'Successful account register!',
      name: 'successRegister',
      desc: '',
      args: [],
    );
  }

  /// `You have not selected a profile picture!`
  String get noImage {
    return Intl.message(
      'You have not selected a profile picture!',
      name: 'noImage',
      desc: '',
      args: [],
    );
  }

  /// `This account is already in use!`
  String get errorRegiter {
    return Intl.message(
      'This account is already in use!',
      name: 'errorRegiter',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
