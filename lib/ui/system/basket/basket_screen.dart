// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pharma/core/components/placeholders.dart';
import 'package:pharma/core/helper/navigateable.dart';
import '../../../core/components/common_button.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/routes/routes.dart';
import '../../nav_bar/navigation_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BasketScreen extends StatefulWidget implements Navigateable {
  const BasketScreen({super.key});

  @override
  State<BasketScreen> createState() => _BasketScreenState();

  @override
  String getName() {
    return Routes.basket_screen;
  }
}

class _BasketScreenState extends State<BasketScreen> {
  var codeController = TextEditingController();
  int counter = 0;
  bool isSelected = false;
  bool isAddedToBasket = false;
  Timer? _timer;
  bool _longPressCanceled = false;

  void _increaseCounter() {
    setState(() {
      counter++;
    });
  }

  void _decreaseCounter() {
    setState(() {
      counter--;
    });
  }

  void _cancelIncrease() {
    if (_timer != null) {
      _timer!.cancel();
    }
    _longPressCanceled = true;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      bottomNavigationBar: AppNavigationBar(
          current: RadioTypes.legalStatus == roleStatus ? 3 : 2),
      backgroundColor: AppColors.k_white_color,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.basket,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
        elevation: 0.0,
        toolbarHeight: height * 7,
        backgroundColor: AppColors.k_white_color,
        // leading: IconButton(
        //   icon: SvgPicture.asset(
        //     'assets/images/svg/arrow_left.svg',
        //     // width: width * 5.58,
        //     // height: height * 2.57,
        //   ),
        //   onPressed: () => Navigator.of(context).pop(),
        // ),
      ),
      body: Container(
        height: height * 100,
        margin: EdgeInsets.only(
          right: width * 3.72,
          left: width * 3.72,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      basketItem(context),
                      basketItem(context),
                      basketItem(context),
                      SizedBox(height: height * 2.575),
                      Text(
                        AppLocalizations.of(context)!.orderAmount,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      //  SizedBox(height: 10),
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       flex: 5,
                      //       child: CommonInput(
                      //         "Введите промокод ",
                      //         // margin: EdgeInsets.only(bottom: height * 2.79),
                      //         type: InputType.TEXT,
                      //         customColor: Color.fromRGBO(119, 117, 127, 1),
                      //         borderColor: AppColors.k_border_grey_color,
                      //         controller: codeController,
                      //         contentPaddingVertical: 1.6,
                      //         rightScreenButton: true,
                      //         fontWeight: FontWeight.w400,
                      //       ),
                      //     ),
                      //     Expanded(
                      //       flex: 2,
                      //       child: CommonButton(
                      //         onPressed: () {},
                      //         backgroundColor: AppColors.k_main_color,
                      //         contentPaddingVertical: 1.6,
                      //         leftScreenButton: true,
                      //         fontSize: 14,
                      //         fontWeight: FontWeight.w600,
                      //         child: Text('Применить'),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.orderAmount,
                              style: TextStyle(
                                color: AppColors.k_grey400_color,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Expanded(
                              child: Text('.' * 100,
                                  style: TextStyle(
                                      color: AppColors.k_grey400_color),
                                  maxLines: 1),
                            ),
                            Text(
                              '3 500 ₸',
                              style: TextStyle(
                                color: AppColors.k_text_primary_color,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.discount,
                              style: TextStyle(
                                color: AppColors.k_grey400_color,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Expanded(
                              child: Text('.' * 100,
                                  style: TextStyle(
                                      color: AppColors.k_grey400_color),
                                  maxLines: 1),
                            ),
                            Text(
                              '-600 ₸',
                              style: TextStyle(
                                color: AppColors.k_grey400_color,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.delivery,
                              style: TextStyle(
                                color: AppColors.k_grey400_color,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Expanded(
                              child: Text('.' * 100,
                                  style: TextStyle(
                                      color: AppColors.k_grey400_color),
                                  maxLines: 1),
                            ),
                            Text(
                              '1 000 ₸',
                              style: TextStyle(
                                color: AppColors.k_text_primary_color,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.total,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            '4 500 ₸',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            CommonButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.ordering_screen);
              },
              backgroundColor: AppColors.k_secondary_color,
              radius: 8,
              margin:
                  EdgeInsets.only(bottom: height * 1.72, top: height * 1.72),
              child: Text(AppLocalizations.of(context)!.complateOrder),
            ),
          ],
        ),
      ),
    );
  }

  Widget basketItem(BuildContext context) {
    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;
    return Container(
      margin: EdgeInsets.only(top: height * 2.15),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: width * 29.30,
                height: height * 13.52,
                child: Image.asset('assets/images/png/product_test.png'),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width * 56.3,
                    child: Text(
                      'Аскорбиновая кислота в порошке без сахара',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.k_text_primary_color,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        '${AppLocalizations.of(context)!.provider}: ',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.k_grey3_color,
                        ),
                      ),
                      Text(
                        'Europharma',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.k_text_primary_color,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        '${AppLocalizations.of(context)!.delivery}: ',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.k_grey3_color,
                        ),
                      ),
                      Text(
                        '15 декабря, бесплатно',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.k_text_primary_color,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        '500 ₸ ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.k_text_primary_color,
                        ),
                      ),
                      Text(
                        '600 ₸',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.k_grey3_color,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    backgroundColor: Colors.white,
                    builder: (BuildContext context) {
                      return StatefulBuilder(
                        builder: (thisLowerContext, innerSetState) {
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!
                                          .changeQuantity,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.k_grey400_color,
                                      ),
                                    ),
                                    Container(
                                      height: height * 3.3,
                                      width: width * 28.13,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        border: Border.all(
                                          width: .45,
                                          color: AppColors.k_grey300_color,
                                        ),
                                        color: AppColors.k_white_color,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              innerSetState(() {
                                                if (counter == 0) {
                                                  return;
                                                }
                                                _decreaseCounter();
                                              });
                                            },
                                            onLongPressEnd: (LongPressEndDetails
                                                longPressEndDetails) {
                                              innerSetState(() {
                                                _cancelIncrease();
                                              });
                                            },
                                            onLongPress: () {
                                              innerSetState(() {
                                                _longPressCanceled = false;
                                                Future.delayed(
                                                    Duration(milliseconds: 100),
                                                    () {
                                                  if (!_longPressCanceled) {
                                                    _timer = Timer.periodic(
                                                        Duration(
                                                            milliseconds: 50),
                                                        (timer) {
                                                      if (counter == 0) {
                                                        return;
                                                      }
                                                      _decreaseCounter();
                                                    });
                                                  }
                                                });
                                              });
                                            },
                                            onLongPressUp: () {
                                              innerSetState(() {
                                                _cancelIncrease();
                                              });
                                            },
                                            child: Text(
                                              '-',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors
                                                    .k_text_primary_color,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: height * 2.789,
                                            decoration: const BoxDecoration(
                                              border: Border(
                                                  right: BorderSide(
                                                      color: AppColors
                                                          .k_grey300_color,
                                                      width: .45)),
                                            ),
                                          ),
                                          Text(
                                            '$counter ${AppLocalizations.of(context)!.pieces}',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors
                                                  .k_text_primary_color,
                                            ),
                                          ),
                                          Container(
                                            height: height * 2.789,
                                            decoration: const BoxDecoration(
                                              border: Border(
                                                  right: BorderSide(
                                                      color: AppColors
                                                          .k_grey300_color,
                                                      width: .45)),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              innerSetState(() {
                                                _increaseCounter();
                                              });
                                            },
                                            onLongPressEnd: (LongPressEndDetails
                                                longPressEndDetails) {
                                              innerSetState(() {
                                                _cancelIncrease();
                                              });
                                            },
                                            onLongPress: () {
                                              innerSetState(() {
                                                _longPressCanceled = false;
                                                Future.delayed(
                                                    Duration(milliseconds: 100),
                                                    () {
                                                  if (!_longPressCanceled) {
                                                    _timer = Timer.periodic(
                                                        Duration(
                                                            milliseconds: 50),
                                                        (timer) {
                                                      _increaseCounter();
                                                    });
                                                  }
                                                });
                                              });
                                            },
                                            onLongPressUp: () {
                                              innerSetState(() {
                                                _cancelIncrease();
                                              });
                                            },
                                            child: Text(
                                              '+',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors
                                                    .k_text_primary_color,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: AppColors.k_grey400_color,
                                  height: height * 3.43,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/images/svg/navbar/favourites.svg',
                                            width: width * 3.8,
                                            height: height * 2.07,
                                            color: AppColors.k_main_color,
                                          ),
                                          SizedBox(width: 7),
                                          Text(
                                            AppLocalizations.of(context)!
                                                .addToFav,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.k_grey400_color,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      padding: EdgeInsets.zero,
                                      constraints: BoxConstraints(),
                                      onPressed: () {},
                                      icon: SvgPicture.asset(
                                        'assets/images/svg/trash_bin.svg',
                                        // width: width * 3.8,
                                        // height: height * 2.07,
                                        color: AppColors.k_grey400_color,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                },
                icon: Icon(Icons.more_vert),
              ),
            ],
          ),
          SizedBox(height: height * 2.15),
          Divider(
            color: AppColors.k_grey400_color,
            height: 0,
          ),
        ],
      ),
    );
  }
}
