// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'package:pharma/core/helper/navigateable.dart';
import 'package:pharma/core/routes/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/components/common_button.dart';
import '../../../../core/components/placeholders.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../nav_bar/navigation_bar.dart';

class MyOrdersScreen extends StatefulWidget implements Navigateable {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();

  @override
  String getName() {
    return Routes.my_orders_screen;
  }
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  bool isCurrent = true;
  bool isCompleted = false;
  bool isCanceled = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: AppNavigationBar(current: 4),
      backgroundColor: AppColors.k_white_color,
      appBar: appBar(context, AppLocalizations.of(context)!.myOrders),
      body: Container(
        height: height * 100,
        margin: EdgeInsets.only(
          right: width * 3.72,
          left: width * 3.72,
        ),
        child: Column(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CommonButton(
                    onPressed: () {
                      setState(() {
                        isCurrent = true;
                        isCompleted = false;
                        isCanceled = false;
                      });
                    },
                    contentPaddingVertical: 1.07,
                    contentPaddingHorizontal: 2.79,
                    backgroundColor: AppColors.k_white_color,
                    hasIconMiniButton: true,
                    radius: 5,
                    margin: EdgeInsets.only(
                      top: 10,
                      left: width * 1,
                      right: width * 1,
                      bottom: height * 2.57,
                    ),
                    fontWeight: FontWeight.w500,
                    foregroundColor: AppColors.k_black_color,
                    shadow: true,
                    disabled: isCurrent,
                    child: Text(
                      AppLocalizations.of(context)!.currentOrders,
                    ),
                  ),
                  CommonButton(
                    onPressed: () {
                      setState(() {
                        isCurrent = false;
                        isCompleted = true;
                        isCanceled = false;
                      });
                    },
                    contentPaddingVertical: 1.07,
                    contentPaddingHorizontal: 2.79,
                    backgroundColor: AppColors.k_white_color,
                    hasIconMiniButton: true,
                    radius: 5,
                    margin: EdgeInsets.only(
                      top: 10,
                      left: width * 1,
                      right: width * 1,
                      bottom: height * 2.57,
                    ),
                    fontWeight: FontWeight.w500,
                    foregroundColor: AppColors.k_black_color,
                    shadow: true,
                    disabled: isCompleted,
                    child: Text(
                      AppLocalizations.of(context)!.completedOrders,
                    ),
                  ),
                  CommonButton(
                    onPressed: () {
                      setState(() {
                        isCurrent = false;
                        isCompleted = false;
                        isCanceled = true;
                      });
                    },
                    contentPaddingVertical: 1.07,
                    contentPaddingHorizontal: 2.79,
                    backgroundColor: AppColors.k_white_color,
                    hasIconMiniButton: true,
                    radius: 5,
                    margin: EdgeInsets.only(
                      top: 10,
                      left: width * 1,
                      right: width * 1,
                      bottom: height * 2.57,
                    ),
                    fontWeight: FontWeight.w500,
                    foregroundColor: AppColors.k_black_color,
                    shadow: true,
                    disabled: isCanceled,
                    child: Text(
                      AppLocalizations.of(context)!.cancelledOrders,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: [
                  isCurrent
                      ? Column(
                          children: [
                            orderInfo(),
                            divider,
                            orderInfo(),
                            divider,
                            orderInfo(),
                          ],
                        )
                      : SizedBox.shrink(),
                  isCompleted
                      ? Column(
                          children: [
                            orderInfo(),
                            divider,
                            orderInfo(),
                            divider,
                            orderInfo(),
                          ],
                        )
                      : SizedBox.shrink(),
                  isCanceled
                      ? Column(
                          children: [
                            orderInfo(),
                            divider,
                            orderInfo(),
                            divider,
                            orderInfo(),
                          ],
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget orderInfo() {
    var height = MediaQuery.of(context).size.height / 100;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SizedBox(height: height * 2.57),
        Text(
          '${AppLocalizations.of(context)!.order} № 123',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 15),
        Text.rich(
          TextSpan(
            style: TextStyle(
              color: AppColors.k_grey300_color,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            children: [
              TextSpan(text: AppLocalizations.of(context)!.orderStatus),
              TextSpan(
                text: ' Осуществляется доставка',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.k_black_color,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        Text.rich(
          TextSpan(
            style: TextStyle(
              color: AppColors.k_grey300_color,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            children: [
              TextSpan(text: AppLocalizations.of(context)!.date),
              TextSpan(
                text: ' 25.05. 2022',
                style: TextStyle(
                  color: AppColors.k_black_color,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        Text.rich(
          TextSpan(
            style: TextStyle(
              color: AppColors.k_grey300_color,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            children: [
              TextSpan(text: AppLocalizations.of(context)!.amountToPay),
              TextSpan(
                text: ' 35 000 ₸ / Оплачено',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.k_black_color,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        Text.rich(
          TextSpan(
            style: TextStyle(
              color: AppColors.k_grey300_color,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            children: [
              TextSpan(text: '${AppLocalizations.of(context)!.delivery}: '),
              TextSpan(
                text: 'доставка курьером 1000 ₸',
                style: TextStyle(
                  color: AppColors.k_black_color,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 30),
        Text(
          AppLocalizations.of(context)!.itemsInOrder,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.k_grey300_color,
          ),
        ),
        SizedBox(height: 15),
        Text(
          '1) Natural Factors, витамин C',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.k_black_color,
          ),
        ),
        SizedBox(height: 13),
        Text(
          '2) Natural Factors, витамин C',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.k_black_color,
          ),
        ),
        SizedBox(height: 13),
        Text(
          '3) Natural Factors, витамин C',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.k_black_color,
          ),
        ),
        CommonButton(
          onPressed: () {
            setState(() {});
          },
          backgroundColor: AppColors.k_secondary_color,
          radius: 8,
          margin: EdgeInsets.only(top: height * 3.65, bottom: height * 5.15),
          child: Text(AppLocalizations.of(context)!.continueShopping),
        ),
      ],
    );
  }
}
