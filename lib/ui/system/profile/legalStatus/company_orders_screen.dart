// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pharma/core/helper/navigateable.dart';
import 'package:pharma/core/routes/routes.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../nav_bar/navigation_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CompanyOrdersScreen extends StatefulWidget implements Navigateable {
  const CompanyOrdersScreen({super.key});

  @override
  State<CompanyOrdersScreen> createState() => _CompanyOrdersScreenState();

  @override
  String getName() {
    return Routes.company_orders_screen;
  }
}

class _CompanyOrdersScreenState extends State<CompanyOrdersScreen> {
  bool isFavGoods = true;
  bool isFavPharmacy = false;
  bool isSeenGoods = false;

  static const List<String> list = <String>[
    'Статус заказа',
    'Цена по убыванию',
    'Популярные',
    'Новинки',
    'Высокий рейтинг',
    'По размеру скидки',
  ];
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: const AppNavigationBar(current: 3),
      backgroundColor: AppColors.k_white_color,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.orders,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
        elevation: 0.0,
        toolbarHeight: height * 7,
        backgroundColor: AppColors.k_white_color,
      ),
      body: Container(
        height: height * 100,
        margin: EdgeInsets.only(
          right: width * 2.55,
          left: width * 2.55,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              height: height * 10.8,
              child: ListView(
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.k_white_color,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2.5,
                              blurRadius: 3,
                              offset:
                                  Offset(0, 0), // changes position of shadow
                            ),
                          ],
                        ),
                        margin: EdgeInsets.only(
                          right: width * 1.16,
                          left: width * 1.16,
                          top: height * 1,
                          bottom: height * 1,
                        ),
                        padding: EdgeInsets.symmetric(
                          //vertical: height * 1.07,
                          horizontal: width * 5.34,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '405',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.k_main_color,
                              ),
                            ),
                            Text(
                              'Ожидается\nоплата',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.k_main_color,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.k_white_color,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2.5,
                              blurRadius: 3,
                              offset:
                                  Offset(0, 0), // changes position of shadow
                            ),
                          ],
                        ),
                        margin: EdgeInsets.only(
                          right: width * 1.16,
                          left: width * 1.16,
                          top: height * 1,
                          bottom: height * 1,
                        ),
                        padding: EdgeInsets.symmetric(
                          //vertical: height * 1.07,
                          horizontal: width * 5.34,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '355',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.k_main_color,
                              ),
                            ),
                            Text(
                              'Ожидается\nотправка',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.k_main_color,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.k_white_color,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2.5,
                              blurRadius: 3,
                              offset:
                                  Offset(0, 0), // changes position of shadow
                            ),
                          ],
                        ),
                        margin: EdgeInsets.only(
                          right: width * 1.16,
                          left: width * 1.16,
                          top: height * 1,
                          bottom: height * 1,
                        ),
                        padding: EdgeInsets.symmetric(
                          //vertical: height * 1.07,
                          horizontal: width * 5.34,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '345',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.k_main_color,
                              ),
                            ),
                            Text(
                              'Ожидается\nполучение',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.k_main_color,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.k_white_color,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2.5,
                              blurRadius: 3,
                              offset:
                                  Offset(0, 0), // changes position of shadow
                            ),
                          ],
                        ),
                        margin: EdgeInsets.only(
                          right: width * 1.16,
                          left: width * 1.16,
                          top: height * 1,
                          bottom: height * 1,
                        ),
                        padding: EdgeInsets.symmetric(
                          // vertical: height * 1.07,
                          horizontal: width * 5.34,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '345',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.k_main_color,
                              ),
                            ),
                            Text(
                              'Ожидается\nполучение',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.k_main_color,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 1.57),
            SizedBox(
              width: 200, //width * 45.11,
              height: height * 4.4,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Color(0xFFE3E5E6),
                  ),
                  color: AppColors.k_white_color,
                ),
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      menuMaxHeight: 400,
                      borderRadius: BorderRadius.circular(5),
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.k_black_color,
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                      items: list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      isExpanded: true,
                      dropdownColor: Colors.grey.shade50,
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(
                    top: height * 2.57,
                    right: width * 1.16,
                    left: width * 1.16),
                shrinkWrap: true,
                children: [
                  orderInfo(),
                  orderInfo(),
                  orderInfo(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isExpanded = false;
  Widget orderInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '№ заказа 123456',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.k_black_color,
              ),
            ),
            Text(
              '22.05.2022',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.k_grey3_color),
            ),
          ],
        ),
        SizedBox(height: 16),
        Text(
          '1. Витаминный комплекс A-Zn Витамир 30 таблеток (Витамин С, Витамин Д, Магний, Цинк, Селен)',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.k_black_color,
          ),
          //textAlign: TextAlign.center,
        ),
        SizedBox(height: 16),
        Text(
          '698 040 ₸',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.k_black_color,
          ),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Ожидает оплату',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.k_secondary_color,
              ),
            ),
            !isExpanded
                ? TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: const Text(
                      // '${height}, ${width}',
                      'Подробнее о заказе',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.k_main_color,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          ],
        ),
        isExpanded
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Text(
                    'Получатель: ',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text.rich(
                    TextSpan(
                      style: TextStyle(
                        color: AppColors.k_grey3_color,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                      children: [
                        TextSpan(text: 'ФИО: '),
                        TextSpan(
                          text: 'Амиров Амир Амирович',
                          style: TextStyle(
                            color: AppColors.k_black_color,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  Text.rich(
                    TextSpan(
                      style: TextStyle(
                        color: AppColors.k_grey3_color,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                      children: [
                        TextSpan(text: 'Телефон: '),
                        TextSpan(
                          text: '+7 (777) 777 77 77',
                          style: TextStyle(
                            color: AppColors.k_black_color,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  Text.rich(
                    TextSpan(
                      style: TextStyle(
                        color: AppColors.k_grey3_color,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                      children: [
                        TextSpan(text: 'E-mail: '),
                        TextSpan(
                          text: 'куеуук@mail.ru',
                          style: TextStyle(
                            color: AppColors.k_black_color,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                        child: const Text(
                          // '${height}, ${width}',
                          'Свернуть',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.k_main_color,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : SizedBox.shrink(),
        const Divider(
          color: AppColors.k_grey400_color,
          height: 48,
        ),
      ],
    );
  }
}
