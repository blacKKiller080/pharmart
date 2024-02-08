// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pharma/core/routes/routes.dart';
import '../constants/app_colors.dart';

class ProductCard extends StatefulWidget {
  final String? text;
  final String? imagePath;
  final String? pharmacy;
  final bool isTop;
  final bool isVip;
  final bool isHot;
  final bool isCatalog;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final double? price;
  final double? height;
  final double? width;

  ProductCard({
    this.text = 'Аскорбиновая кислота в порошке без сахара',
    this.imagePath,
    this.price,
    this.pharmacy,
    this.isTop = false,
    this.isVip = false,
    this.isHot = false,
    this.isCatalog = false,
    this.margin,
    this.padding,
    this.height,
    this.width,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int itemCount = 0;
  bool isSelected = false;
  bool isAddedToBasket = false;
  Timer? _timer;
  bool _longPressCanceled = false;

  void _increaseCounter() {
    setState(() {
      itemCount++;
    });
  }

  void _decreaseCounter() {
    setState(() {
      itemCount--;
    });
  }

  Color _getCounterColor() {
    if (itemCount > 0)
      return AppColors.k_main_color;
    else if (itemCount < 0)
      return AppColors.k_secondary_color;
    else
      return AppColors.k_secondary_color;
  }

  void _cancelIncrease() {
    if (_timer != null) {
      _timer!.cancel();
    }
    _longPressCanceled = true;
  }

  @override
  Widget build(BuildContext context) {
    final divider = Container(
      height: MediaQuery.of(context).size.height / 100 * 2.789,
      decoration: const BoxDecoration(
        border: Border(
            right: BorderSide(color: AppColors.k_grey300_color, width: .45)),
      ),
    );
    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.product_screen);
      },
      child: Container(
        height: widget.height,
        width: widget.width,
        margin: widget.margin ??
            EdgeInsets.only(
              right: width * 1.32, //7
              left: width * 1, //3
              top: height * 0.5, //4
              bottom: height * 0.43, //4
            ),
        padding: widget.padding ??
            EdgeInsets.only(
              top: height * 1.07,
              bottom: height * 2.68,
              left: width * 2.33,
              right: width * 2.33,
            ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 3, horizontal: 9),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.k_main_color,
                  ),
                  child: Text(
                    'Выгодно',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: AppColors.k_white_color,
                    ),
                  ),
                ),
                GestureDetector(
                  child: Icon(
                    isSelected ? Icons.favorite : Icons.favorite_border,
                    color: AppColors.k_main_color,
                  ),
                  //  SvgPicture.asset(
                  //   'assets/images/svg/navbar/favourites.svg',
                  //   width: width * 4,
                  //   height: height * 2,
                  //   color: AppColors.k_main_color,
                  // ),
                  onTap: () {
                    setState(() {
                      isSelected = !isSelected;
                    });
                  },
                ),
              ],
            ),
            Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/png/main_page/drug.png',
                    width: width * 15.81,
                    height: height * 7.73,
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: SvgPicture.asset(
                    'assets/images/svg/compare.svg',
                    width: width * 3.5,
                    height: height * 1.5,
                    // color: AppColors.k_main_color,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '500 ₸',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.k_main_color,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 20,
                    ),
                    Text(
                      '5.0',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.k_grey300_color,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              widget.text!,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.k_grey400_color,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/images/png/main_page/pharmacy1.png'),
                widget.isVip
                    ? SvgPicture.asset('assets/images/svg/vip.svg')
                    : widget.isHot
                        ? SvgPicture.asset('assets/images/svg/chilli.svg')
                        : widget.isTop
                            ? SvgPicture.asset('assets/images/svg/top.svg')
                            : SizedBox.shrink(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: height * 3.3,
                  width: !widget.isCatalog ? width * 33.72 : width * 28.13,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(
                      width: .45,
                      color: AppColors.k_grey300_color,
                    ),
                    color: AppColors.k_white_color,
                  ),
                  child:
                      // Stack(
                      //   children: [
                      //     Container(
                      //       height: height * 3.3,
                      //       width: width * 11,
                      //     ),
                      //     Positioned(
                      //       left: 50,
                      //       child: Container(
                      //         height: height * 3.3,
                      //         width: width * 11.4,
                      //       ),
                      //     ),
                      Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //Minus
                      SizedBox(
                        width: !widget.isCatalog ? width * 10 : width * 8.3,
                        child: GestureDetector(
                          // behavior: HitTestBehavior.translucent,
                          onTap: () {
                            if (itemCount == 0) {
                              isAddedToBasket = false;
                              return;
                            }
                            _decreaseCounter();
                          },
                          onLongPressEnd:
                              (LongPressEndDetails longPressEndDetails) {
                            _cancelIncrease();
                          },
                          onLongPress: () {
                            _longPressCanceled = false;
                            Future.delayed(Duration(milliseconds: 100), () {
                              if (!_longPressCanceled) {
                                _timer = Timer.periodic(
                                    Duration(milliseconds: 50), (timer) {
                                  if (itemCount == 0) {
                                    return;
                                  }
                                  _decreaseCounter();
                                });
                              }
                            });
                          },
                          onLongPressUp: () {
                            _cancelIncrease();
                          },
                          child: Text(
                            '-',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.k_text_primary_color,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      divider,
                      SizedBox(
                        width: !widget.isCatalog ? width * 13 : width * 11,
                        child: GestureDetector(
                          onTap: () {},
                          child: Text(
                            '$itemCount шт',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColors.k_text_primary_color,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      divider,
                      //Plus
                      SizedBox(
                        width: !widget.isCatalog ? width * 10 : width * 8.3,
                        child: GestureDetector(
                          onTap: () {
                            _increaseCounter();
                          },
                          onLongPressEnd:
                              (LongPressEndDetails longPressEndDetails) {
                            _cancelIncrease();
                          },
                          onLongPress: () {
                            _longPressCanceled = false;
                            Future.delayed(Duration(milliseconds: 100), () {
                              if (!_longPressCanceled) {
                                _timer = Timer.periodic(
                                    Duration(milliseconds: 50), (timer) {
                                  _increaseCounter();
                                });
                              }
                            });
                          },
                          onLongPressUp: () {
                            _cancelIncrease();
                          },
                          child: Text(
                            '+',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.k_text_primary_color,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // ],
                  // ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    setState(() {
                      if (itemCount > 0) {
                        isAddedToBasket = !isAddedToBasket;
                      } else {
                        isAddedToBasket = false;
                      }
                    });
                  },
                  child: Container(
                    height: height * 3.3,
                    width: width * 10.23,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: isAddedToBasket
                          ? _getCounterColor()
                          : AppColors.k_secondary_color,
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 3, vertical: height * .7),
                    child: SvgPicture.asset(
                      'assets/images/svg/basket_add.svg',
                      // height: height * 1.5,
                      // width: width * 3.25,
                      color: AppColors.k_white_color,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



// Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.selectedBottomIconColor,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//               ),
//               onPressed: () {},
//               child: const Text('Выгодно'),
//             ),
//             SvgPicture.asset(AppAssets.svg.bottomFavoritesIcon),
//           ],
//         ),
//         Image.asset(
//           AppAssets.images.example,
//           fit: BoxFit.cover,
//         ),
//         Row(
//           children: [
//             const Expanded(
//               child: Text(
//                 '500 ₸ ',
//                 style: TextStyle(
//                   color: AppColors.selectedBottomIconColor,
//                   fontSize: 20,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//             Text(
//               '5.0',
//               style: TextStyle(
//                 color: Colors.grey.shade400,
//                 fontSize: 18,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 5),
//           child: Text(
//             'Аскорбиновая кислота в порошке без сахара',
//             style: TextStyle(
//               color: Colors.grey.shade700,
//               fontSize: 13,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//         Image.asset(AppAssets.images.example2),
//         Row(
//           children: [
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.orange),
//                   onPressed: () {},
//                   child: SvgPicture.asset(
//                     AppAssets.svg.basketIcon,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
