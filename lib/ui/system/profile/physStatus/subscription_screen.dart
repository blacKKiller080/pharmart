// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pharma/core/helper/navigateable.dart';
import 'package:pharma/core/routes/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/components/common_button.dart';
import '../../../../core/components/placeholders.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../nav_bar/navigation_bar.dart';

class SubscriptionScreen extends StatefulWidget implements Navigateable {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();

  @override
  String getName() {
    return Routes.subscription_screen;
  }
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: const AppNavigationBar(current: 4),
      backgroundColor: AppColors.k_white_color,
      appBar: appBar(context, AppLocalizations.of(context)!.mySubscriptions),
      body: Container(
        height: height * 100,
        margin: EdgeInsets.only(
          right: width * 3.72,
          left: width * 3.72,
          top: 10,
        ),
        child: Column(
          children: [
            Container(
              width: width * 100,
              padding: EdgeInsets.only(
                right: width * 3.72,
                left: width * 3.72,
                top: height * 2.57,
                bottom: height * 2.14,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 177, 245, 238),
                    Color.fromARGB(255, 75, 221, 218),
                  ],
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                ),
              ),
              child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/images/svg/new_subscription.svg',
                  ),
                  SizedBox(height: 17),
                  Text(
                    'Новые поступления',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.k_text_tertiary_color,
                    ),
                  ),
                  CommonButton(
                    backgroundColor: AppColors.k_secondary_color,
                    radius: 8,
                    containerWidth: width * 39,
                    contentPaddingVertical: 1.82,
                    margin: EdgeInsets.only(top: 10),
                    child: Text('Подписаться'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            Container(
              width: width * 100,
              padding: EdgeInsets.only(
                right: width * 3.72,
                left: width * 3.72,
                top: height * 2.57,
                bottom: height * 2.14,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 177, 245, 238),
                    Color.fromARGB(255, 75, 221, 218),
                  ],
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                ),
              ),
              child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/images/svg/sale_subscription.svg',
                  ),
                  SizedBox(height: 9),
                  Text(
                    'Распродажи и акции',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.k_text_tertiary_color,
                    ),
                  ),
                  CommonButton(
                    backgroundColor: AppColors.k_secondary_color,
                    radius: 8,
                    containerWidth: width * 39,
                    contentPaddingVertical: 1.82,
                    margin: EdgeInsets.only(top: 10),
                    child: Text('Подписаться'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
