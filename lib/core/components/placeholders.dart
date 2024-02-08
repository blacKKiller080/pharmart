// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pharma/core/constants/app_colors.dart';
import '../routes/routes.dart';
import 'common_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

AppBar appBar(BuildContext context, String title) {
  return AppBar(
    title: Text(
      title,
      style: Theme.of(context).textTheme.titleMedium,
    ),
    centerTitle: true,
    elevation: 0.0,
    backgroundColor: AppColors.k_white_color,
    leading: IconButton(
      icon: SvgPicture.asset(
        'assets/images/svg/arrow_left.svg',
        // width: width * 5.58,
        // height: height * 2.57,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
  );
}

class AlertController {
  static void showMessage({
    required BuildContext context,
    required String title,
    required String content,
    bool barrierDismissable = true,
    TextStyle? titleStyle,
    TextStyle? contentStyle,
  }) async {
    if (Platform.isIOS || Platform.isMacOS) {
      await showCupertinoDialog(
        context: context,
        barrierDismissible: barrierDismissable,
        builder: (_) => CupertinoAlertDialog(
          title: Text(
            title,
            style: titleStyle ?? Theme.of(context).textTheme.titleMedium,
          ),
          content: Text(
            content,
            style: contentStyle ?? Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      );
    }
    await showDialog(
      context: context,
      barrierDismissible: barrierDismissable,
      builder: (_) => AlertDialog(
        title: Text(
          title,
          style: titleStyle ?? Theme.of(context).textTheme.titleMedium,
        ),
        content: Text(
          content,
          style: contentStyle ?? Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}

Widget textWithArrowIcon(BuildContext context, String title, Function onPressed,
    {double topPadding = 2.57, bool expression = false}) {
  var height = MediaQuery.of(context).size.height / 100;
  return Padding(
    padding: EdgeInsets.only(bottom: height * 2.57, top: height * topPadding),
    child: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onPressed.call();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: expression
                ? Theme.of(context).textTheme.titleSmall
                : Theme.of(context).textTheme.titleMedium,
          ),
          RotatedBox(
            quarterTurns: expression ? 3 : 2,
            child: SvgPicture.asset(
              'assets/images/svg/arrow_left.svg',
              color:
                  expression ? AppColors.k_main_color : AppColors.k_grey3_color,
              // width: width * 35.6,
              // height: height * 3.1,
            ),
          ),
        ],
      ),
    ),
  );
}



Widget buildLoading() => Center(
        child: CircularProgressIndicator(
      // backgroundColor: AppColors.k_border_grey_color,
      color: AppColors.k_main_color,
      strokeWidth: 2,
    ));

Widget categoryField(String? image, String? data, BuildContext context) {
  var height = MediaQuery.of(context).size.height / 100;
  var width = MediaQuery.of(context).size.width / 100;
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, Routes.category_screen, arguments: data);
    },
    child: Container(
      height: height * 11.5,
      width: width * 28.5,
      // padding: EdgeInsets.all(14),
      margin: EdgeInsets.only(
        bottom: 5,
        top: 5,
        left: 5,
        right: 5,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.k_white_color,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: height * 5.37,
            child: Image.network(
              image!,
              fit: BoxFit.fitWidth,

              // color: AppColors.k_black_color,
            ),
          ),
          SizedBox(height: 5),
          Text(
            data!,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF585858),
            ),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ],
      ),
    ),
  );
}

Widget companyCard(BuildContext context) {
  var height = MediaQuery.of(context).size.height / 100;
  var width = MediaQuery.of(context).size.width / 100;
  return Container(
    padding: EdgeInsets.only(
      left: width * 3.72,
      right: width * 1.62,
      top: height * 1.72,
      bottom: height * 1.72,
    ),
    margin: EdgeInsets.only(top: height * 1.72),
    decoration: BoxDecoration(
        border: Border.all(
          color: Color.fromRGBO(227, 229, 230, 1),
        ),
        borderRadius: BorderRadius.circular(4)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Europharma',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.k_text_primary_color,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 20,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 20,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 20,
                    ),
                    Icon(
                      Icons.star,
                      color: Color.fromARGB(255, 228, 228, 228),
                      size: 20,
                    ),
                    Icon(
                      Icons.star,
                      color: Color.fromARGB(255, 228, 228, 228),
                      size: 20,
                    ),
                  ],
                ),
              ],
            ),
            CommonButton(
              onPressed: () {},
              backgroundColor: AppColors.k_main_color,
              radius: 8,
              contentPaddingVertical: 0.9,
              containerWidth: 109,
              child: Text(AppLocalizations.of(context)!.choose),
            ),
          ],
        ),
        SizedBox(height: height * 1.72),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '500 000 ₸',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.k_text_primary_color,
              ),
            ),
            Text(
              'Доставка 25 декабря, бесплатно',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.k_text_primary_color,
              ),
            ),
          ],
        )
      ],
    ),
  );
}

Widget filterContainer(String title) => CommonButton(
      onPressed: () {},
      contentPaddingVertical: 1.07,
      contentPaddingHorizontal: 2.32,
      backgroundColor: AppColors.k_white_color,
      hasIconMiniButton: true,
      radius: 5,
      margin: EdgeInsets.only(
        // bottom: height * 0.75,
        // right: width * 1.63,
        bottom: 10,
        right: 7,
      ),
      shadow: true,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.k_black_color,
        ),
      ),
    );

void showBottomFilterSheet(BuildContext context, String title, Widget child,
    {bool? isPrice = false}) {
  var height = MediaQuery.of(context).size.height / 100;
  var width = MediaQuery.of(context).size.width / 100;
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(40),
        topRight: Radius.circular(40),
      ),
    ),
    backgroundColor: Colors.white,
    builder: (BuildContext context) {
      return Container(
        width: width * 100,
        padding: EdgeInsets.only(
          right: width * 3.72,
          left: width * 3.72,
          bottom: height * 2.15,
          top: height * 1.6,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.grey.shade400,
                ),
                height: 4,
                width: 44,
                margin: EdgeInsets.only(
                  bottom: height * 2.5,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: height * 3.64),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Фильтры',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: AppColors.k_black_color,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Отменить',
                        style: TextStyle(
                          color: AppColors.k_main_color,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: height * 2.58),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.k_black_color,
                    ),
                  ),
                  !isPrice!
                      ? TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Все',
                            style: TextStyle(
                              color: AppColors.k_main_color,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ),
            child,
            CommonButton(
              onPressed: () {
                Navigator.pop(context);
              },
              backgroundColor: AppColors.k_secondary_color,
              radius: 8,
              margin: EdgeInsets.only(
                top: height * 4.3,
              ),
              child: Text(
                'Закрыть',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.k_white_color,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

void showPromotionDialog(BuildContext context) {
  var width = MediaQuery.of(context).size.width / 100;
  var height = MediaQuery.of(context).size.height / 100;
  showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(23),
      ),
      insetPadding: EdgeInsets.only(
        top: height * 0,
        left: width * 0,
        right: width * 0,
        bottom: height * 0,
      ),
      child: SizedBox(
        height: height * 60,
        width: width * 93,
        child: Padding(
          padding: EdgeInsets.only(
            top: height * 2.15,
            left: width * 4.65,
            right: width * 4.65,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: SvgPicture.asset(
                      'assets/images/svg/close.svg',
                      // width: width * 5.58,
                      // height: height * 2.57,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 1.5),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/svg/crown.svg',
                    height: 23,
                    width: 18,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Пакет 3 в одном',
                    style: TextStyle(
                      color: AppColors.k_text_primary_color,
                      fontWeight: FontWeight.w600,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 1.07),
              Text.rich(
                TextSpan(
                  style: TextStyle(
                    color: AppColors.k_grey300_color,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                  children: [
                    TextSpan(
                      text: 'В 10 раз больше просмотров ',
                      style: TextStyle(
                        color: AppColors.k_text_primary_color,
                      ),
                    ),
                    TextSpan(text: '(в течение 30 дней)'),
                  ],
                ),
              ),
              SizedBox(height: height * 3.65),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/svg/vip.svg',
                    height: height * 2.15,
                    width: width * 4.19,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Стать VIP',
                        style: TextStyle(
                          color: AppColors.k_text_primary_color,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Первые в списке',
                        style: TextStyle(
                          color: AppColors.k_text_primary_color,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Divider(
                color: AppColors.k_grey400_color,
                height: height * 4.29,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/svg/chilli.svg',
                    height: height * 2.15,
                    width: width * 4.19,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Отправить в горящие',
                        style: TextStyle(
                          color: AppColors.k_text_primary_color,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'На главной странице Pharmart.kz ',
                        style: TextStyle(
                          color: AppColors.k_text_primary_color,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Divider(
                color: AppColors.k_grey400_color,
                height: height * 4.29,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/svg/top.svg',
                    height: height * 2.15,
                    width: width * 4.19,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Отправить в ТОП',
                        style: TextStyle(
                          color: AppColors.k_text_primary_color,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Выше аптек без статуса',
                        style: TextStyle(
                          color: AppColors.k_text_primary_color,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Divider(
                color: AppColors.k_grey400_color,
                height: height * 4.29,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text.rich(
                    TextSpan(
                      style: TextStyle(
                        color: AppColors.k_grey300_color,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                      children: [
                        TextSpan(text: 'К оплате '),
                        TextSpan(
                          text: '4 500 ₸',
                          style: TextStyle(
                            color: AppColors.k_text_primary_color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              CommonButton(
                onPressed: () {},
                backgroundColor: AppColors.k_main_color,
                radius: 4,
                contentPaddingVertical: 1.29,
                margin: EdgeInsets.only(
                  top: height * 2.36,
                  bottom: height * 1.72,
                ),
                child: Text('Подключить'),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

const divider = Divider(
  color: AppColors.k_grey400_color,
  height: 0,
);

enum RadioTypes {
  delivery,
  pickUpByYourself,
  onlinePayment,
  offlinePayment,
  physStatus,
  legalStatus;
  //static String get hello => "asdf";
}

RadioTypes? roleStatus = RadioTypes.physStatus;
RadioTypes? paymentStatus = RadioTypes.offlinePayment;
RadioTypes? delivetyStatus = RadioTypes.delivery;
