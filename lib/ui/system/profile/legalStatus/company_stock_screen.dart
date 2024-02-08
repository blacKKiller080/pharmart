// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:pharma/core/routes/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/components/common_input.dart';
import '../../../../core/components/placeholders.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/helper/navigateable.dart';
import '../../../nav_bar/navigation_bar.dart';

class CompanyStockScreen extends StatefulWidget implements Navigateable {
  const CompanyStockScreen({super.key});

  @override
  State<CompanyStockScreen> createState() => _CompanyStockScreenState();

  @override
  String getName() {
    return Routes.company_stock_screen;
  }
}

class _CompanyStockScreenState extends State<CompanyStockScreen> {
  var searchController = TextEditingController();

  static const List<String> list = <String>[
    'купи 2 вещи 3 в подарок',
    'Цена по убыванию',
    'Популярные',
    'Новинки',
    'Высокий рейтинг',
    'По размеру скидки',
  ];
  List<String> listTest = <String>[
    'купи 2 вещи 3 в подарок',
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
      bottomNavigationBar: const AppNavigationBar(current: 4),
      backgroundColor: AppColors.k_white_color,
      appBar: appBar(context, AppLocalizations.of(context)!.stockManagement),
      body: Container(
        height: height * 100,
        margin: EdgeInsets.only(
          right: width * 3.72,
          left: width * 3.72,
        ),
        child: Column(
          children: [
            SizedBox(height: height * 1.57),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text(
                    'Выберите название акции:',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.k_grey400_color,
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: SizedBox(
                    //width: width * 53,
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
                            items: list
                                .map<DropdownMenuItem<String>>((String value) {
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
                ),
              ],
            ),
            CommonInput(
              "Поиск по артикулу или названию",
              margin:
                  EdgeInsets.only(top: height * 2.57, bottom: height * 2.57),
              type: InputType.TEXT,
              customColor: AppColors.k_grey300_color,
              borderColor: AppColors.k_border_grey_color,
              controller: searchController,
              contentPaddingVertical: 1.4,
              isSearchSuffix: true,
            ),
            SizedBox(
              height: height * 62.9,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,

                itemCount: listTest.length,
                // itemExtent: width * 54,
                itemBuilder: (context, index) {
                  return stockInfo(listTest[index], index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget stockInfo(String text, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            style: TextStyle(
              color: AppColors.k_grey300_color,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
            children: [
              TextSpan(text: text),
              TextSpan(
                text: ' 123456',
                style: TextStyle(
                  color: AppColors.k_text_primary_color,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Витаминный комплекс A-Zn Витамир 30 таблеток (Витамин С, Витамин Д, Магний, Цинк, Селен)',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.k_text_primary_color,
          ),
          //textAlign: TextAlign.center,
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Text.rich(
              TextSpan(
                style: TextStyle(
                  color: AppColors.k_grey300_color,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
                children: [
                  TextSpan(text: 'Текущая цена: '),
                  TextSpan(
                    text: '3500 ₸',
                    style: TextStyle(
                      color: AppColors.k_text_primary_color,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 24),
            Text.rich(
              TextSpan(
                style: TextStyle(
                  color: AppColors.k_grey300_color,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
                children: [
                  TextSpan(text: 'Акция: '),
                  TextSpan(
                    text: '10 %',
                    style: TextStyle(
                      color: AppColors.k_text_primary_color,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text.rich(
              TextSpan(
                style: TextStyle(
                  color: AppColors.k_grey300_color,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
                children: [
                  TextSpan(text: 'Стоимость услуги: '),
                  TextSpan(
                    text: '50 ₸',
                    style: TextStyle(
                      color: AppColors.k_text_primary_color,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size(0, 0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () {
                setState(() {
                  listTest.removeAt(index);
                });
              },
              child: const Text(
                // '${height}, ${width}',
                'Удалить',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.k_main_color,
                  decoration: TextDecoration.underline,
                ),
              ),
            )
          ],
        ),
        const Divider(
          color: AppColors.k_grey400_color,
          height: 48,
        ),
      ],
    );
  }
}
