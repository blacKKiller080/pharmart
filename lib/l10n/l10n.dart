import 'package:flutter/material.dart';

class L10n {
  static final locales = [
    const Locale('en'),
    const Locale('ru'),
    const Locale('kk'),
  ];

  static String getFlag(String code) {
    switch (code) {
      case 'en':
        return 'assets/images/svg/usa.svg';
      case 'kk':
        return 'assets/images/svg/kaz.svg';
      case 'ru':
      default:
        return 'assets/images/svg/rus.svg';
    }
  }
}
