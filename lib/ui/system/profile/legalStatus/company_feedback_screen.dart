// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:pharma/core/helper/navigateable.dart';
import 'package:pharma/core/routes/routes.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/components/common_button.dart';
import '../../../../core/components/placeholders.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../nav_bar/navigation_bar.dart';

class CompanyFeedbackScreen extends StatefulWidget implements Navigateable {
  const CompanyFeedbackScreen({super.key});

  @override
  State<CompanyFeedbackScreen> createState() => _CompanyFeedbackScreenState();

  @override
  String getName() {
    return Routes.company_feedback_screen;
  }
}

class _CompanyFeedbackScreenState extends State<CompanyFeedbackScreen> {
  bool today = false;
  bool tomorrow = false;
  bool week = false;
  bool month = true;
  bool year = false;

  List<RatingData> purpleData = [
    RatingData('Янв.', 2),
    RatingData('Фев.', 2),
    RatingData('Мар.', 4),
    RatingData('Апр.', 1),
    RatingData('Май', 3.5),
    RatingData('Июн.', 2.5),
    RatingData('Июл.', 3),
    RatingData('Авг.', 2.5),
    RatingData('Сен.', 4.5),
    RatingData('Окт.', 2),
    RatingData('Ноя.', 4),
    RatingData('Дек.', 2.3)
  ];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: const AppNavigationBar(current: 4),
      backgroundColor: AppColors.k_white_color,
      appBar: appBar(context, AppLocalizations.of(context)!.feedbacks),
      body: SizedBox(
        height: height * 100,
        // margin: EdgeInsets.only(
        //   right: width * 3.72,
        //   left: width * 3.72,
        // ),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: height * 1.55,
                ),
                margin: EdgeInsets.only(
                  right: width * 3.72,
                  left: width * 3.72,
                  top: height * 1,
                  bottom: height * 2.57,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: AppColors.k_white_color,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2.5,
                      blurRadius: 3,
                      offset: Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'Оценка аптеки 4,6 / 250 отзывов',
                    style: TextStyle(
                      color: AppColors.k_main_color,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: width * 3.72,
                  left: width * 3.72,
                  bottom: height * 1.57,
                ),
                child: Text(
                  'Иногда покупатели могут быть недовольны качеством товаров. Вы можете посмотреть комментарии и оценки в разделе Отзывы в админпанели.',
                  style: TextStyle(
                    color: AppColors.k_black_color,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                ),
              ),
              //Procent containers
              SizedBox(
                height: height * 14,
                child: ListView(
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: [
                    Row(
                      children: [
                        Container(
                          // width: width * 35,
                          // height: height * 11,
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
                            left: width * 3.72,
                            top: height * 1,
                            bottom: height * 1,
                          ),
                          padding: EdgeInsets.symmetric(
                            // vertical: height * 1.6,
                            horizontal: width * 5.34,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '4,6% ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.k_main_color,
                                ),
                              ),
                              Text(
                                'Процент заказов\nвыполненных\nвовремя',
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
                            //vertical: height * 1.6,
                            horizontal: width * 5.34,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '4,6%',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.k_main_color,
                                ),
                              ),
                              Text(
                                'Процент\nотмененных\nзаказов',
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
                            //vertical: height * 1.6,
                            horizontal: width * 5.34,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '4,6% ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.k_main_color,
                                ),
                              ),
                              Text(
                                'Процент\nпросроченных\nдоставок',
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
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 3.72,
                  vertical: height * 1.72,
                ),
                child: Text(
                  'Средняя оценка за товары',
                  style: TextStyle(
                    color: AppColors.k_black_color,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 9, right: 8, left: 5, bottom: 14),
                margin: EdgeInsets.symmetric(horizontal: width * 3.72),
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
                                backgroundColor: Color(0xFF4FD996), radius: 4),
                            SizedBox(width: 3),
                            Text(
                              'Высокий показатель',
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
                                backgroundColor: Color(0xFFD96FF8), radius: 4),
                            SizedBox(width: 3),
                            Text(
                              'Тревожный уровень оценок',
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
                                backgroundColor: Color(0xFFEB9494), radius: 4),
                            SizedBox(width: 3),
                            Text(
                              'Нижний показатель',
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
                                backgroundColor: Color(0xFF89B1FF), radius: 4),
                            SizedBox(width: 3),
                            Text(
                              'Порог',
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
                        onMarkerRender: (args) {
                          // Check your specific condition
                          if (purpleData[args.pointIndex!].points > 3.9) {
                            args.color = Color(0xFF4FD996);
                            args.borderWidth = 0;
                          } else if (purpleData[args.pointIndex!].points >
                              2.9) {
                            args.color = Color(0xFFD96FF8);
                            args.borderWidth = 0;
                          } else if (purpleData[args.pointIndex!].points >
                              1.9) {
                            args.color = Color(0xFFEB9494);
                            args.borderWidth = 0;
                          } else {
                            args.color = Color(0xFF89B1FF);
                            args.borderWidth = 0;
                          }
                        },
                        series: <ChartSeries<RatingData, String>>[
                          LineSeries<RatingData, String>(
                            dataSource: purpleData,
                            color: AppColors.neutral3,
                            markerSettings: MarkerSettings(isVisible: true),
                            xValueMapper: (RatingData sales, _) => sales.year,
                            yValueMapper: (RatingData sales, _) => sales.points,
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
        ),
      ),
    );
  }
}

class RatingData {
  RatingData(this.year, this.points);
  final String year;
  final double points;
}
