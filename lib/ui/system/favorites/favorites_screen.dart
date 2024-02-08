import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pharma/core/helper/navigateable.dart';
import 'package:pharma/core/routes/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/components/common_button.dart';
import '../../../../core/components/product_card.dart';
import '../../../../core/constants/app_colors.dart';
import '../../nav_bar/navigation_bar.dart';

class FavoritesScreen extends StatefulWidget implements Navigateable {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();

  @override
  String getName() {
    return Routes.favourites_screen;
  }
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  bool isFavGoods = true;
  bool isFavPharmacy = false;
  bool isSeenGoods = false;

  static const List<String> list = <String>[
    'Сначала новые',
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
          AppLocalizations.of(context)!.myFavorites,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: AppColors.k_white_color,
        // leading: IconButton(
        //   icon: SvgPicture.asset(
        //     'assets/images/svg/arrow_left.svg',
        //     // width: width * 5.58,
        //     // height: height * 2.57,
        //   ),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
      ),
      body: Container(
        height: height * 100,
        margin: EdgeInsets.only(
          right: width * 2.72,
          left: width * 2.72,
          top: 0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
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
                        isFavGoods = true;
                        isFavPharmacy = false;
                        isSeenGoods = false;
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
                    disabled: isFavGoods,
                    child: Text(
                      AppLocalizations.of(context)!.favorites,
                    ),
                  ),
                  CommonButton(
                    onPressed: () {
                      setState(() {
                        isFavGoods = false;
                        isFavPharmacy = true;
                        isSeenGoods = false;
                      });
                    },
                    contentPaddingVertical: 1.07,
                    contentPaddingHorizontal: 2.79,
                    backgroundColor: AppColors.k_white_color,
                    hasIconMiniButton: true,
                    radius: 5,
                    margin: EdgeInsets.only(
                      left: width * 1,
                      top: 10,
                      right: width * 1,
                      bottom: height * 2.57,
                    ),
                    fontWeight: FontWeight.w500,
                    foregroundColor: AppColors.k_black_color,
                    shadow: true,
                    disabled: isFavPharmacy,
                    child: Text(
                      AppLocalizations.of(context)!.favPharmcies,
                    ),
                  ),
                  CommonButton(
                    onPressed: () {
                      setState(() {
                        isFavGoods = false;
                        isFavPharmacy = false;
                        isSeenGoods = true;
                      });
                    },
                    contentPaddingVertical: 1.07,
                    contentPaddingHorizontal: 2.79,
                    backgroundColor: AppColors.k_white_color,
                    hasIconMiniButton: true,
                    radius: 5,
                    margin: EdgeInsets.only(
                      left: width * 1,
                      top: 10,
                      right: width * 1,
                      bottom: height * 2.57,
                    ),
                    fontWeight: FontWeight.w500,
                    foregroundColor: AppColors.k_black_color,
                    shadow: true,
                    disabled: isSeenGoods,
                    child: Text(
                      AppLocalizations.of(context)!.reviewedItems,
                    ),
                  ),
                ],
              ),
            ),
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
            SizedBox(height: height * 1.14),
            isFavGoods
                ? Flexible(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      // itemExtent: width * 54,
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            ProductCard(
                              height: height * 31.55,
                              width: width * 45.11,
                              isCatalog: true,
                              margin: EdgeInsets.only(
                                left: width * 1,
                                right: width * 1.16,
                                bottom: height * 1.14,
                                top: height * 1,
                              ),
                            ),
                            ProductCard(
                              height: height * 31.55,
                              width: width * 45.11,
                              isCatalog: true,
                              margin: EdgeInsets.only(
                                bottom: height * 1.14,
                                top: height * 1,
                                left: width * 1.16,
                                right: width * 1,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  )
                : const SizedBox.shrink(),
            isFavPharmacy
                ? Flexible(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      // itemExtent: width * 54,
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        return pharmacyCard();
                      },
                    ),
                  )
                : const SizedBox.shrink(),
            isSeenGoods
                ? Flexible(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      // itemExtent: width * 54,
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            ProductCard(
                              height: height * 31.55,
                              width: width * 45.11,
                              isCatalog: true,
                              margin: EdgeInsets.only(
                                left: width * 1,
                                right: width * 1.16,
                                bottom: height * 1.14,
                                top: height * 1,
                              ),
                            ),
                            ProductCard(
                              height: height * 31.55,
                              width: width * 45.11,
                              isCatalog: true,
                              margin: EdgeInsets.only(
                                bottom: height * 1.14,
                                top: height * 1,
                                left: width * 1.16,
                                right: width * 1,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  Widget pharmacyCard() {
    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        bottom: height * 2.14,
        top: height * 2.14,
        left: width * 4.65,
        right: width * 3.5,
      ),
      margin: EdgeInsets.only(
        bottom: height * 1.14,
        top: height * 1,
        left: width * 1,
        right: width * 1,
      ),
      decoration: BoxDecoration(
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
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: height * 3.76,
                    backgroundColor: AppColors.k_white_color,
                    // backgroundImage:
                    //     AssetImage("assets/images/png/main_page/pharmacy1.png"),
                    child: Image.asset(
                        'assets/images/png/main_page/pharmacy1.png'),
                  ),
                  SizedBox(width: width * 5.58),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Europharma',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: AppColors.k_text_primary_color,
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
                            '3.9',
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
                ],
              ),
              SvgPicture.asset(
                'assets/images/svg/navbar/favourites.svg',
                height: height * 2.3,
                color: AppColors.k_main_color,
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              SvgPicture.asset(
                'assets/images/svg/box.svg',
                height: 18,
                width: 18,
                color: AppColors.k_main_color,
              ),
              SizedBox(width: width * 2.32),
              Text(
                'Доставка - завтра, 21 мая, от 1 000 ₸',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.k_text_primary_color,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              SvgPicture.asset(
                'assets/images/svg/time.svg',
                color: AppColors.k_main_color,
              ),
              SizedBox(width: width * 2.32),
              Text(
                'Режим работы - от 09:00 до 22:00',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.k_text_primary_color,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              SvgPicture.asset(
                'assets/images/svg/sale.svg',
                color: AppColors.k_main_color,
              ),
              SizedBox(width: width * 2.32),
              Text(
                'Акция “3+1” на все товары',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.k_text_primary_color,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
