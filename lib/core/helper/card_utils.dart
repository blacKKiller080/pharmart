import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardUtils {
  static CardType getCardTypeFrmNumber(String input) {
    CardType cardType;
    if (input.startsWith(RegExp(
        r'((5[1-5])|(222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720))'))) {
      cardType = CardType.Master;
    } else if (input.startsWith(RegExp(r'[4]'))) {
      cardType = CardType.Visa;
    } else if (input.length <= 8) {
      cardType = CardType.Others;
    } else {
      cardType = CardType.Invalid;
    }
    return cardType;
  }

  static String getCleanedNumber(String text) {
    RegExp regExp = RegExp(r"[^0-9]");
    return text.replaceAll(regExp, '');
  }

  static Widget? getCardIcon(CardType? cardType) {
    String img = "";
    Icon? icon;
    Widget? widget;
    switch (cardType) {
      case CardType.Master:
        img = 'mastercard.svg';
        break;
      case CardType.Visa:
        img = 'visa.svg';
        break;
      case CardType.Others:
        icon = const Icon(
          Icons.warning,
          size: 24.0,
          color: Color(0xFFB8B5C3),
        );
        break;
      default:
        // icon = const Icon(
        //   Icons.warning,
        //   size: 24.0,
        //   color: Color(0xFFB8B5C3),
        // );
        break;
    }
    if (img.isNotEmpty) {
      widget = SvgPicture.asset(
        'assets/images/svg/$img',
        width: 40.0,
        height: 24,
      );
    } else {
      widget = icon;
    }
    return widget;
  }
}

enum CardType { Master, Visa, Others, Invalid }
