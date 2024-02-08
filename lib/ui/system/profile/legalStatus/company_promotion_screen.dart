// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pharma/core/components/placeholders.dart';
import 'package:pharma/core/routes/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/helper/navigateable.dart';
import '../../../nav_bar/navigation_bar.dart';

class CompanyPromotionScreen extends StatefulWidget implements Navigateable {
  const CompanyPromotionScreen({super.key});

  @override
  State<CompanyPromotionScreen> createState() => _CompanyPromotionScreenState();

  @override
  String getName() {
    return Routes.company_promotion_screen;
  }
}

class _CompanyPromotionScreenState extends State<CompanyPromotionScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: const AppNavigationBar(current: 4),
      backgroundColor: AppColors.k_white_color,
      appBar: appBar(context, AppLocalizations.of(context)!.productsPromotion),
      body: Container(
        height: height * 100,
        margin: EdgeInsets.only(
          right: width * 3.72,
          left: width * 3.72,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 1.57),
            Text(
              'Единичный статус',
              style: TextStyle(
                color: AppColors.k_text_primary_color,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            SizedBox(height: height * 1.72),
            promotionContainer(
              'Стать VIP',
              'Первые в списке',
              'assets/images/svg/vip.svg',
              '1500 ₸',
              null,
              35,
              34,
            ),
            Divider(
              color: AppColors.k_grey400_color,
              height: 48,
            ),
            promotionContainer(
              'Отправить в горящие',
              'На главной странице Pharmart.kz',
              'assets/images/svg/chilli.svg',
              '1500 ₸',
              null,
              35,
              32,
            ),
            Divider(
              color: AppColors.k_grey400_color,
              height: 48,
            ),
            promotionContainer(
              'Отправить в ТОП',
              'Выше аптек без статуса',
              'assets/images/svg/top.svg',
              '1500 ₸',
              null,
              35,
              35,
            ),
            Divider(
              color: AppColors.k_grey400_color,
              height: 48,
            ),
            Text(
              'Пакеты',
              style: TextStyle(
                color: AppColors.k_text_primary_color,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            SizedBox(height: height * 1.72),
            promotionContainer(
              'Пакет 3 в одном',
              'В 10 раз больше просмотров',
              'assets/images/svg/crown.svg',
              '4500 ₸',
              (() {
                showPromotionDialog(context);
              }),
              32,
              25,
            ),
          ],
        ),
      ),
    );
  }

  Widget promotionContainer(
    String title,
    String subTitle,
    String path,
    String price,
    void Function()? onTap,
    double imageHeight,
    double imageWidth,
  ) {
    var width = MediaQuery.of(context).size.width / 100;
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                path,
                height: imageHeight,
                width: imageWidth,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: AppColors.k_text_primary_color,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    subTitle,
                    style: TextStyle(
                      color: AppColors.k_text_primary_color,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            width: width * 29,
            height: 28,
            //padding: EdgeInsets.symmetric(horizontal: 41, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.k_main_color,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Text(
                price,
                style: TextStyle(
                  color: AppColors.k_white_color,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
