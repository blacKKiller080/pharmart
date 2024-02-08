// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:pharma/core/helper/navigateable.dart';
import 'package:pharma/core/routes/routes.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/components/common_button.dart';
import '../../../../core/components/placeholders.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../nav_bar/navigation_bar.dart';

class CompanyRatingScreen extends StatefulWidget implements Navigateable {
  const CompanyRatingScreen({super.key});

  @override
  State<CompanyRatingScreen> createState() => _CompanyRatingScreenState();

  @override
  String getName() {
    return Routes.company_rating_screen;
  }
}

class _CompanyRatingScreenState extends State<CompanyRatingScreen> {
  static const List<String> list = <String>[
    'Все категории',
    'Цена по убыванию',
    'Популярные',
    'Новинки',
    'Высокий рейтинг',
    'По размеру скидки',
  ];

  String dropdownValue = list.first;

  Map<String, double> dataMap = {
    "Positive": 88,
    "Negative": 11,
  };

  bool today = false;
  bool tomorrow = false;
  bool week = false;
  bool month = true;
  bool year = false;

  List<_FeedBackData> purpleData = [
    _FeedBackData('Янв.', 2),
    _FeedBackData('Фев.', 2),
    _FeedBackData('Мар.', 4),
    _FeedBackData('Апр.', 1),
    _FeedBackData('Май', 3.5),
    _FeedBackData('Июн.', 2.5),
    _FeedBackData('Июл.', 3),
    _FeedBackData('Авг.', 2.5),
    _FeedBackData('Сен.', 4.5),
    _FeedBackData('Окт.', 2),
    _FeedBackData('Ноя.', 4),
    _FeedBackData('Дек.', 2.3)
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: const AppNavigationBar(current: 4),
      backgroundColor: AppColors.k_white_color,
      appBar: appBar(context, AppLocalizations.of(context)!.rating),
      body: Container(
        height: height * 100,
        margin: EdgeInsets.only(
          right: width * 3.72,
          left: width * 3.72,
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          physics: BouncingScrollPhysics(),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 1),
                Text(
                  'Количество оценок ваших товаров',
                  style: TextStyle(
                    color: AppColors.k_text_primary_color,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: height * 1.72),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Выберите категорию:  ',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.k_grey400_color,
                      ),
                    ),
                    SizedBox(
                      width: width * 40,
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
                              icon:
                                  const Icon(Icons.keyboard_arrow_down_rounded),
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
                              items: list.map<DropdownMenuItem<String>>(
                                  (String value) {
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
                  ],
                ),
                SizedBox(height: height * 2.57),
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: PieChart(
                        dataMap: dataMap,
                        animationDuration: Duration(milliseconds: 800),
                        chartLegendSpacing: 32,
                        chartRadius: width * 11.62 * 2,
                        colorList: [
                          Color(0xFF4FD996),
                          Color(0xFFEB9494),
                        ],
                        initialAngleInDegree: 0,
                        chartType: ChartType.ring,
                        ringStrokeWidth: 25,
                        legendOptions: LegendOptions(showLegends: false),
                        chartValuesOptions:
                            ChartValuesOptions(showChartValues: false),
                      ),
                    ),
                    SizedBox(width: width * 3.5),
                    Expanded(
                      flex: 8,
                      child: Column(
                        children: [
                          Text(
                            '99 товаров с оценками',
                            style: TextStyle(
                              color: AppColors.k_black_color,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: height * 1.07),
                          Row(
                            children: [
                              Text(
                                '11',
                                style: TextStyle(
                                  color: Color(0xFFEB9494),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              Expanded(
                                child: Text('_' * 100,
                                    style: TextStyle(
                                      color: Color(0xFFEB9494),
                                    ),
                                    maxLines: 1),
                              ),
                              Text(
                                'негативные (1-3 звезды)',
                                style: TextStyle(
                                  color: Color(0xFFEB9494),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: height * 1.07),
                          Row(
                            children: [
                              Text(
                                '88',
                                style: TextStyle(
                                  color: Color(0xFF4FD996),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              Expanded(
                                child: Text('_' * 100,
                                    style: TextStyle(
                                      color: Color(0xFF4FD996),
                                    ),
                                    maxLines: 1),
                              ),
                              Text(
                                'позитивные (4-5 звезды)',
                                style: TextStyle(
                                  color: Color(0xFF4FD996),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: height * 2.57),
                  child: Text(
                    'Мы рассчитываем средние оценки ваших товаров. Если у вас больше товаров с отрицательными оценками - обратите внимание на качество товара, упаковки и сервиса. Вы можете ознакомиться с отзывами покупателей в разделе Отзывы в админпанели.',
                    style: TextStyle(
                      color: AppColors.k_black_color,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ),
                Text(
                  'Средняя оценка за товары',
                  style: TextStyle(
                    color: AppColors.k_black_color,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: height * 1.72),
                Container(
                  padding:
                      EdgeInsets.only(top: 9, right: 8, left: 5, bottom: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors.k_grey_divider_color,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonButton(
                            onPressed: () {
                              setState(() {
                                today = true;
                                tomorrow = false;
                                week = false;
                                month = false;
                                year = false;
                              });
                            },
                            contentPaddingVertical: 1,
                            containerWidth: width * 16.3,
                            backgroundColor: AppColors.k_white_color,
                            radius: 3,
                            borderColor: true,
                            fontWeight: FontWeight.w500,
                            foregroundColor: AppColors.k_grey_divider_color,
                            disabled: today,
                            child: Text(
                              'Сегодня',
                              style: TextStyle(
                                color: !today
                                    ? AppColors.k_text_primary_color
                                    : AppColors.k_white_color,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          CommonButton(
                            onPressed: () {
                              setState(() {
                                today = false;
                                tomorrow = true;
                                week = false;
                                month = false;
                                year = false;
                              });
                            },
                            contentPaddingVertical: 1,
                            containerWidth: width * 16.3,
                            backgroundColor: AppColors.k_white_color,
                            radius: 3,
                            borderColor: true,
                            fontWeight: FontWeight.w500,
                            foregroundColor: AppColors.k_grey_divider_color,
                            disabled: tomorrow,
                            child: Text(
                              'Вчера',
                              style: TextStyle(
                                color: !tomorrow
                                    ? AppColors.k_text_primary_color
                                    : AppColors.k_white_color,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          CommonButton(
                            onPressed: () {
                              setState(() {
                                today = false;
                                tomorrow = false;
                                week = true;
                                month = false;
                                year = false;
                              });
                            },
                            contentPaddingVertical: 1,
                            containerWidth: width * 16.3,
                            backgroundColor: AppColors.k_white_color,
                            radius: 3,
                            borderColor: true,
                            fontWeight: FontWeight.w500,
                            foregroundColor: AppColors.k_grey_divider_color,
                            disabled: week,
                            child: Text(
                              'Неделя',
                              style: TextStyle(
                                color: !week
                                    ? AppColors.k_text_primary_color
                                    : AppColors.k_white_color,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          CommonButton(
                            onPressed: () {
                              setState(() {
                                today = false;
                                tomorrow = false;
                                week = false;
                                month = true;
                                year = false;
                              });
                            },
                            contentPaddingVertical: 1,
                            containerWidth: width * 16.3,
                            backgroundColor: AppColors.k_white_color,
                            radius: 3,
                            borderColor: true,
                            fontWeight: FontWeight.w500,
                            foregroundColor: AppColors.k_grey_divider_color,
                            disabled: month,
                            child: Text(
                              'Месяц',
                              style: TextStyle(
                                color: !month
                                    ? AppColors.k_text_primary_color
                                    : AppColors.k_white_color,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          CommonButton(
                            onPressed: () {
                              setState(() {
                                today = false;
                                tomorrow = false;
                                week = false;
                                month = false;
                                year = true;
                              });
                            },
                            contentPaddingVertical: 1,
                            containerWidth: width * 16.3,
                            backgroundColor: AppColors.k_white_color,
                            radius: 3,
                            borderColor: true,
                            fontWeight: FontWeight.w500,
                            foregroundColor: AppColors.k_grey_divider_color,
                            disabled: year,
                            child: Text(
                              'Год',
                              style: TextStyle(
                                color: !year
                                    ? AppColors.k_text_primary_color
                                    : AppColors.k_white_color,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 1.5),
                      Wrap(
                        runSpacing: height * 0.5,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(
                                  backgroundColor: Color(0xFF4FD996),
                                  radius: 4),
                              SizedBox(width: 3),
                              Text(
                                'Позитивная оценка',
                                style: TextStyle(
                                  color: AppColors.k_text_primary_color,
                                  fontSize: 7.45,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: width * 3.5),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(
                                  backgroundColor: Color(0xFFEB9494),
                                  radius: 4),
                              SizedBox(width: 3),
                              Text(
                                'Негативная оценка',
                                style: TextStyle(
                                  color: AppColors.k_text_primary_color,
                                  fontSize: 7.45,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: height * 1.72),
                      SizedBox(
                        height: 200,
                        child: SfCartesianChart(
                          primaryXAxis: CategoryAxis(
                            rangePadding: ChartRangePadding.none,
                            labelPlacement: LabelPlacement.onTicks,
                            edgeLabelPlacement: EdgeLabelPlacement.shift,
                            labelStyle: TextStyle(
                              fontSize: 6,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          primaryYAxis: NumericAxis(
                            labelStyle: TextStyle(
                              fontSize: 6,
                              fontWeight: FontWeight.w400,
                            ),
                            maximum: 5,
                          ),
                          margin: EdgeInsets.zero,
                          enableAxisAnimation: true,
                          tooltipBehavior: TooltipBehavior(enable: true),
                          // onMarkerRender: (args) {
                          //   // Check your specific condition
                          //   if (args.viewportPointIndex! > 2.5) {
                          //     args.color = Colors.green;
                          //     // args.markerHeight = 20;
                          //     // args.markerWidth = 20;
                          //     // args.shape = DataMarkerType.diamond;
                          //     // args.borderColor = Colors.green;
                          //     // args.borderWidth = 2;
                          //   }
                          // },
                          series: <ChartSeries<_FeedBackData, String>>[
                            LineSeries<_FeedBackData, String>(
                              dataSource: purpleData,
                              color: AppColors.neutral3,
                              onCreateShader: (ShaderDetails details) {
                                return ui.Gradient.linear(
                                  details.rect.topCenter,
                                  details.rect.bottomCenter,
                                  <Color>[
                                    Color(0xFF4FD996),
                                    Color(0xFF4FD996),
                                    Color(0xFFEB9494),
                                    Color(0xFFEB9494),
                                  ],
                                  <double>[
                                    0,
                                    0.4,
                                    0.4,
                                    1,
                                  ],
                                );
                              },
                              //  markerSettings: MarkerSettings(isVisible: true),
                              xValueMapper: (_FeedBackData sales, _) =>
                                  sales.year,
                              yValueMapper: (_FeedBackData sales, _) =>
                                  sales.sales,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 1.72),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FeedBackData {
  _FeedBackData(this.year, this.sales);
  final String year;
  final double sales;
}
