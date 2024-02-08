// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:pharma/core/routes/routes.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/components/common_button.dart';
import '../../../../core/components/placeholders.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/helper/navigateable.dart';
import '../../../nav_bar/navigation_bar.dart';

class CompanyAnalyticScreen extends StatefulWidget implements Navigateable {
  const CompanyAnalyticScreen({super.key});

  @override
  State<CompanyAnalyticScreen> createState() => _CompanyAnalyticScreenState();

  @override
  String getName() {
    return Routes.company_analytic_screen;
  }
}

class _CompanyAnalyticScreenState extends State<CompanyAnalyticScreen> {
  bool byOrder = true;
  bool byStock = false;
  bool isReports = false;

  bool today = false;
  bool tomorrow = false;
  bool week = false;
  bool month = true;
  bool year = false;

  List<_SalesData> redData = [
    _SalesData('Янв.', 2000),
    _SalesData('Фев.', 21000),
    _SalesData('Мар.', 31000),
    _SalesData('Апр.', 13000),
    _SalesData('Май', 27000),
    _SalesData('Июн.', 2600),
    _SalesData('Июл.', 5000),
    _SalesData('Авг.', 34000),
    _SalesData('Сен.', 21000),
    _SalesData('Окт.', 29000),
    _SalesData('Ноя.', 33000),
    _SalesData('Дек.', 39000)
  ];

  List<_SalesData> blueData = [
    _SalesData('Янв.', 39000),
    _SalesData('Фев.', 3000),
    _SalesData('Мар.', 29000),
    _SalesData('Апр.', 21000),
    _SalesData('Май', 34000),
    _SalesData('Июн.', 5000),
    _SalesData('Июл.', 26000),
    _SalesData('Авг.', 27000),
    _SalesData('Сен.', 13000),
    _SalesData('Окт.', 31000),
    _SalesData('Ноя.', 21000),
    _SalesData('Дек.', 2000)
  ];
  List<_SalesData> purpleData = [
    _SalesData('Янв.', 21000),
    _SalesData('Фев.', 21000),
    _SalesData('Мар.', 32000),
    _SalesData('Апр.', 22000),
    _SalesData('Май', 27000),
    _SalesData('Июн.', 26000),
    _SalesData('Июл.', 41000),
    _SalesData('Авг.', 23000),
    _SalesData('Сен.', 25000),
    _SalesData('Окт.', 34000),
    _SalesData('Ноя.', 32000),
    _SalesData('Дек.', 24000)
  ];
  List<_SalesData> greenData = [
    _SalesData('Янв.', 20000),
    _SalesData('Фев.', 21000),
    _SalesData('Мар.', 3000),
    _SalesData('Апр.', 1300),
    _SalesData('Май', 27000),
    _SalesData('Июн.', 3900),
    _SalesData('Июл.', 50000),
    _SalesData('Авг.', 30000),
    _SalesData('Сен.', 2100),
    _SalesData('Окт.', 20000),
    _SalesData('Ноя.', 250),
    _SalesData('Дек.', 3900)
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // _SalesData employeeWithMinSalary = greenData
    //     .reduce((item1, item2) => item1.sales > item2.sales ? item1 : item2);

    final LinearGradient gradientColors = LinearGradient(
      colors: <Color>[
        Color.fromRGBO(42, 193, 206, 0.6),
        Color.fromRGBO(42, 193, 206, 0)
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: AppNavigationBar(current: 4),
      backgroundColor: AppColors.k_white_color,
      appBar: appBar(context, AppLocalizations.of(context)!.analytics),
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
                        byStock = false;
                        byOrder = true;
                        isReports = false;
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
                    disabled: byOrder,
                    child: Text(
                      'Аналитика по заказам',
                    ),
                  ),
                  CommonButton(
                    onPressed: () {
                      setState(() {
                        byOrder = false;
                        byStock = true;
                        isReports = false;
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
                    disabled: byStock,
                    child: Text(
                      'Аналитика по акциям',
                    ),
                  ),
                  CommonButton(
                    onPressed: () {
                      setState(() {
                        byOrder = false;
                        byStock = false;
                        isReports = true;
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
                    disabled: isReports,
                    child: Text(
                      'Отчеты',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 70,
              child: ListView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                children: [
                  !isReports
                      ? Container(
                          padding: EdgeInsets.only(
                              top: 9, right: 8, left: 5, bottom: 14),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    foregroundColor:
                                        AppColors.k_grey_divider_color,
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
                                    foregroundColor:
                                        AppColors.k_grey_divider_color,
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
                                    foregroundColor:
                                        AppColors.k_grey_divider_color,
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
                                    foregroundColor:
                                        AppColors.k_grey_divider_color,
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
                                    foregroundColor:
                                        AppColors.k_grey_divider_color,
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
                                          backgroundColor:
                                              AppColors.k_main_color,
                                          radius: 4),
                                      SizedBox(width: 3),
                                      Text(
                                        'Доходы',
                                        style: TextStyle(
                                          color: AppColors.k_text_primary_color,
                                          fontSize: 7.45,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: width * 3.5),
                                ],
                              ),
                              SizedBox(height: height * 1.72),
                              SizedBox(
                                height: 200,
                                child: SfCartesianChart(
                                  primaryXAxis: CategoryAxis(
                                    rangePadding: ChartRangePadding.none,
                                    labelPlacement: LabelPlacement.onTicks,
                                    edgeLabelPlacement:
                                        EdgeLabelPlacement.shift,
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
                                  ),
                                  margin: EdgeInsets.zero,
                                  enableAxisAnimation: true,
                                  tooltipBehavior:
                                      TooltipBehavior(enable: true),
                                  series: <ChartSeries<_SalesData, String>>[
                                    AreaSeries<_SalesData, String>(
                                      dataSource: purpleData,
                                      color: AppColors.k_main_color,
                                      borderColor: AppColors.k_main_color,
                                      borderWidth: 1,
                                      xValueMapper: (_SalesData sales, _) =>
                                          sales.year,
                                      yValueMapper: (_SalesData sales, _) =>
                                          sales.sales,
                                      gradient: gradientColors,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : SizedBox.shrink(),
                  isReports
                      ? Container(
                          padding: EdgeInsets.only(
                              top: 9, right: 8, left: 5, bottom: 14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppColors.k_border_grey_color,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    foregroundColor:
                                        AppColors.k_border_grey_color,
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
                                    foregroundColor:
                                        AppColors.k_border_grey_color,
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
                                    foregroundColor:
                                        AppColors.k_border_grey_color,
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
                                    foregroundColor:
                                        AppColors.k_border_grey_color,
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
                                    foregroundColor:
                                        AppColors.k_border_grey_color,
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
                                        'Срочные заказы',
                                        style: TextStyle(
                                          color: AppColors.k_text_primary_color,
                                          fontSize: 7,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: width * 3.5),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CircleAvatar(
                                          backgroundColor: Color(0xFFD96FF8),
                                          radius: 4),
                                      SizedBox(width: 3),
                                      Text(
                                        'Во время выполненные заказы',
                                        style: TextStyle(
                                          color: AppColors.k_text_primary_color,
                                          fontSize: 7,
                                          fontWeight: FontWeight.w400,
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
                                        'Просроченные заказы',
                                        style: TextStyle(
                                          color: AppColors.k_text_primary_color,
                                          fontSize: 7,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: width * 3.5),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CircleAvatar(
                                          backgroundColor: Color(0xFF89B1FF),
                                          radius: 4),
                                      SizedBox(width: 3),
                                      Text(
                                        'Отмененные заказы',
                                        style: TextStyle(
                                          color: AppColors.k_text_primary_color,
                                          fontSize: 7,
                                          fontWeight: FontWeight.w400,
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
                                    edgeLabelPlacement:
                                        EdgeLabelPlacement.shift,
                                    labelStyle: TextStyle(
                                      fontSize: 6,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  primaryYAxis: NumericAxis(
                                    //maximum: employeeWithMinSalary.sales,
                                    labelStyle: TextStyle(
                                      fontSize: 6,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  margin: EdgeInsets.zero,
                                  enableAxisAnimation: true,
                                  tooltipBehavior:
                                      TooltipBehavior(enable: true),
                                  series: <ChartSeries<_SalesData, String>>[
                                    FastLineSeries<_SalesData, String>(
                                      dataSource: redData,
                                      color: Color(0xFFEB9494),
                                      xValueMapper: (_SalesData sales, _) =>
                                          sales.year,
                                      yValueMapper: (_SalesData sales, _) =>
                                          sales.sales,
                                    ),
                                    FastLineSeries<_SalesData, String>(
                                      dataSource: blueData,
                                      color: Color(0xFF89B1FF),
                                      xValueMapper: (_SalesData sales, _) =>
                                          sales.year,
                                      yValueMapper: (_SalesData sales, _) =>
                                          sales.sales,
                                    ),
                                    FastLineSeries<_SalesData, String>(
                                      dataSource: purpleData,
                                      color: Color(0xFFD96FF8),
                                      xValueMapper: (_SalesData sales, _) =>
                                          sales.year,
                                      yValueMapper: (_SalesData sales, _) =>
                                          sales.sales,
                                    ),
                                    FastLineSeries<_SalesData, String>(
                                      dataSource: greenData,
                                      color: Color(0xFF4FD996),
                                      xValueMapper: (_SalesData sales, _) =>
                                          sales.year,
                                      yValueMapper: (_SalesData sales, _) =>
                                          sales.sales,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
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

  @override
  void dispose() {
    super.dispose();
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
