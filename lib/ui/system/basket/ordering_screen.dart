// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pharma/core/helper/input_helper.dart';
import 'package:pharma/core/helper/navigateable.dart';
import 'package:pharma/core/routes/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/components/common_button.dart';
import '../../../core/components/common_input.dart';
import '../../../core/components/placeholders.dart';
import '../../../core/constants/app_colors.dart';
import '../../nav_bar/navigation_bar.dart';

class OrderingScreen extends StatefulWidget implements Navigateable {
  const OrderingScreen({super.key});

  @override
  State<OrderingScreen> createState() => _OrderingScreenState();

  @override
  String getName() {
    return Routes.ordering_screen;
  }
}

class _OrderingScreenState extends State<OrderingScreen> {
  var codeController = TextEditingController();
  var streetController = TextEditingController();
  var houseController = TextEditingController();
  var floorController = TextEditingController();
  var apartmentController = TextEditingController();
  var intercomController = TextEditingController();
  var entranceController = TextEditingController();
  var commentController = TextEditingController();
  var nameController = TextEditingController();
  var surnameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();

  MaskTextInputFormatter formatter = InputHelper.maskTextInputFormatter();

  bool isAddress = false;
  bool isDelivery = false;
  bool isCustomer = false;
  bool isPayment = false;
  bool isAgreeWithTerms = false;
  bool filledFields = false;

  bool isBonus = false;

  static const List<String> list = <String>[
    'Алматы, Алматинская область',
    'Астана, Алматинская область',
    'Тараз, Джамбульская область',
  ];
  String? cityValue;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: AppNavigationBar(
          current: RadioTypes.legalStatus == roleStatus ? 3 : 2),
      backgroundColor: AppColors.k_white_color,
      appBar: appBar(context, AppLocalizations.of(context)!.ordering),
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
                      //Address
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: height * 2.57, top: height * 2.57),
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            setState(() {
                              isAddress = !isAddress;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.address,
                                    style: isAddress
                                        ? Theme.of(context).textTheme.titleSmall
                                        : Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                  ),
                                  apartmentController.text != '' &&
                                          houseController.text != '' &&
                                          streetController.text != '' &&
                                          entranceController.text != '' &&
                                          floorController.text != '' &&
                                          intercomController.text != '' &&
                                          cityValue != null &&
                                          !isAddress
                                      ? Column(
                                          children: [
                                            SizedBox(
                                              width: width * 80,
                                              child: Text(
                                                '$cityValue, ${streetController.text} ${houseController.text}, кв. ${apartmentController.text}',
                                                style: TextStyle(
                                                  color: AppColors
                                                      .k_text_primary_color,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                maxLines: 5,
                                              ),
                                            ),
                                          ],
                                        )
                                      : SizedBox.shrink(),
                                ],
                              ),
                              RotatedBox(
                                quarterTurns: isAddress ? 3 : 2,
                                child: SvgPicture.asset(
                                  'assets/images/svg/arrow_left.svg',
                                  color: isAddress
                                      ? AppColors.k_main_color
                                      : AppColors.k_grey3_color,
                                  // width: width * 35.6,
                                  // height: height * 3.1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      isAddress
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.settelment,
                                  style: TextStyle(
                                    color: AppColors.k_text_primary_color,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Container(
                                  // height: height * 4.29,
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  margin: EdgeInsets.fromLTRB(
                                      0, height * 1.07, 0, height * 1.72),
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: AppColors.k_white_color,
                                        border: Border.all(
                                          color: AppColors.neutral3,
                                        )),
                                    child: ButtonTheme(
                                      alignedDropdown: true,
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          value: cityValue,
                                          menuMaxHeight: 400,
                                          hint: Text(
                                            AppLocalizations.of(context)!
                                                .selectCity,
                                            style: TextStyle(
                                              color: AppColors.k_black_color,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          icon: const Icon(Icons
                                              .keyboard_arrow_down_rounded),
                                          style: const TextStyle(
                                            color:
                                                AppColors.k_text_primary_color,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          onChanged: (String? value) {
                                            setState(() {
                                              cityValue = value ?? '';
                                            });
                                          },
                                          items: list
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          isExpanded: true,
                                          dropdownColor:
                                              AppColors.k_white_color,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                CommonInput(
                                  AppLocalizations.of(context)!.street,
                                  margin:
                                      EdgeInsets.only(bottom: height * 1.72),
                                  type: InputType.TEXT,
                                  customColor: AppColors.k_grey300_color,
                                  borderColor: AppColors.k_border_grey_color,
                                  controller: streetController,
                                  textColor: AppColors.k_text_primary_color,
                                  textInputAction: TextInputAction.next,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CommonInput(
                                        AppLocalizations.of(context)!.house,
                                        margin: EdgeInsets.only(
                                            bottom: height * 1.72),
                                        type: InputType.TEXT,
                                        customColor: AppColors.k_grey300_color,
                                        borderColor:
                                            AppColors.k_border_grey_color,
                                        textColor:
                                            AppColors.k_text_primary_color,
                                        controller: houseController,
                                        textInputAction: TextInputAction.next,
                                      ),
                                    ),
                                    SizedBox(width: width * 3.5),
                                    Expanded(
                                      child: CommonInput(
                                        AppLocalizations.of(context)!
                                            .apartmentOffice,
                                        margin: EdgeInsets.only(
                                            bottom: height * 1.72),
                                        type: InputType.TEXT,
                                        customColor: AppColors.k_grey300_color,
                                        borderColor:
                                            AppColors.k_border_grey_color,
                                        textColor:
                                            AppColors.k_text_primary_color,
                                        controller: apartmentController,
                                        textInputAction: TextInputAction.next,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CommonInput(
                                        AppLocalizations.of(context)!
                                            .sectionOfBuilding,
                                        margin: EdgeInsets.only(
                                            bottom: height * 1.72),
                                        type: InputType.TEXT,
                                        customColor: AppColors.k_grey300_color,
                                        borderColor:
                                            AppColors.k_border_grey_color,
                                        textColor:
                                            AppColors.k_text_primary_color,
                                        controller: entranceController,
                                        textInputAction: TextInputAction.next,
                                      ),
                                    ),
                                    SizedBox(width: width * 3.5),
                                    Expanded(
                                      child: CommonInput(
                                        AppLocalizations.of(context)!.floor,
                                        margin: EdgeInsets.only(
                                            bottom: height * 1.72),
                                        type: InputType.NUMBER,
                                        customColor: AppColors.k_grey300_color,
                                        borderColor:
                                            AppColors.k_border_grey_color,
                                        textColor:
                                            AppColors.k_text_primary_color,
                                        controller: floorController,
                                        textInputAction: TextInputAction.next,
                                        formatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                CommonInput(
                                  AppLocalizations.of(context)!.intercom,
                                  margin:
                                      EdgeInsets.only(bottom: height * 1.72),
                                  type: InputType.TEXT,
                                  customColor: AppColors.k_grey300_color,
                                  borderColor: AppColors.k_border_grey_color,
                                  textColor: AppColors.k_text_primary_color,
                                  controller: intercomController,
                                  textInputAction: TextInputAction.done,
                                ),
                                CommonButton(
                                  onPressed: () {
                                    setState(() {
                                      filledFields = true;
                                      isAddress = false;
                                    });
                                  },
                                  backgroundColor: AppColors.neutral3,
                                  radius: 8,
                                  margin:
                                      EdgeInsets.only(bottom: height * 2.57),
                                  child: Text(AppLocalizations.of(context)!
                                      .changeAddress),
                                ),
                                divider,
                              ],
                            )
                          : divider,
                      //Delivery
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: height * 2.57, top: height * 2.57),
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            setState(() {
                              isDelivery = !isDelivery;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!
                                        .deliveryMethod,
                                    style: isDelivery
                                        ? Theme.of(context).textTheme.titleSmall
                                        : Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                  ),
                                  // Text(
                                  //   'Населенный пункт',
                                  //   style: TextStyle(
                                  //     color: AppColors.k_text_primary_color,
                                  //     fontSize: 14,
                                  //     fontWeight: FontWeight.w400,
                                  //   ),
                                  // ),
                                  // Text(
                                  //   'Населенный пункт',
                                  //   style: TextStyle(
                                  //     color: AppColors.k_text_primary_color,
                                  //     fontSize: 14,
                                  //     fontWeight: FontWeight.w400,
                                  //   ),
                                  // ),
                                ],
                              ),
                              RotatedBox(
                                quarterTurns: isDelivery ? 3 : 2,
                                child: SvgPicture.asset(
                                  'assets/images/svg/arrow_left.svg',
                                  color: isDelivery
                                      ? AppColors.k_main_color
                                      : AppColors.k_grey3_color,
                                  // width: width * 35.6,
                                  // height: height * 3.1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      isDelivery
                          ? Column(
                              children: [
                                basketItem(context),
                                basketItem(context),
                                CommonInput(
                                  AppLocalizations.of(context)!.comment,
                                  margin: EdgeInsets.only(
                                      bottom: height * 2.57,
                                      top: height * 2.57),
                                  type: InputType.TEXT,
                                  controller: commentController,
                                  customColor: AppColors.k_grey3_color,
                                  borderColor: AppColors.k_grey_divider_color,
                                  maxLines: 4,
                                ),
                                divider,
                              ],
                            )
                          : divider,
                      //Customer
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: height * 2.57, top: height * 2.57),
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            setState(() {
                              isCustomer = !isCustomer;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.reciever,
                                    style: isCustomer
                                        ? Theme.of(context).textTheme.titleSmall
                                        : Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                  ),
                                  nameController.text != '' &&
                                          surnameController.text != '' &&
                                          phoneController.text != '' &&
                                          emailController.text != '' &&
                                          !isCustomer
                                      ? Container(
                                          width: width * 80,
                                          padding: EdgeInsets.only(top: 5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${nameController.text} ${surnameController.text}',
                                                style: TextStyle(
                                                  color: AppColors
                                                      .k_text_primary_color,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                maxLines: 3,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    '${AppLocalizations.of(context)!.phone}: ',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: AppColors
                                                          .k_grey3_color,
                                                    ),
                                                  ),
                                                  Text(
                                                    '${phoneController.text}',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: AppColors
                                                          .k_text_primary_color,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Wrap(
                                                children: [
                                                  Text(
                                                    '${AppLocalizations.of(context)!.email}: ',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: AppColors
                                                          .k_grey3_color,
                                                    ),
                                                  ),
                                                  Text(
                                                    '${emailController.text}',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: AppColors
                                                          .k_text_primary_color,
                                                    ),
                                                    maxLines: 2,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      : SizedBox.shrink(),
                                ],
                              ),
                              RotatedBox(
                                quarterTurns: isCustomer ? 3 : 2,
                                child: SvgPicture.asset(
                                  'assets/images/svg/arrow_left.svg',
                                  color: isCustomer
                                      ? AppColors.k_main_color
                                      : AppColors.k_grey3_color,
                                  // width: width * 35.6,
                                  // height: height * 3.1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      isCustomer
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonInput(
                                  AppLocalizations.of(context)!.fName,
                                  margin:
                                      EdgeInsets.only(bottom: height * 1.72),
                                  type: InputType.TEXT,
                                  controller: nameController,
                                  customColor: AppColors.k_grey3_color,
                                  borderColor: AppColors.k_grey_divider_color,
                                  textColor: AppColors.k_text_primary_color,
                                ),
                                CommonInput(
                                  AppLocalizations.of(context)!.lName,
                                  margin:
                                      EdgeInsets.only(bottom: height * 1.72),
                                  type: InputType.TEXT,
                                  controller: surnameController,
                                  customColor: AppColors.k_grey3_color,
                                  borderColor: AppColors.k_grey_divider_color,
                                  textColor: AppColors.k_text_primary_color,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.contact,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                CommonInput(
                                  AppLocalizations.of(context)!.phone,
                                  margin: EdgeInsets.only(
                                      bottom: height * 1.72,
                                      top: height * 1.72),
                                  type: InputType.PHONE,
                                  controller: phoneController,
                                  customColor: AppColors.k_grey3_color,
                                  borderColor: AppColors.k_grey_divider_color,
                                  textColor: AppColors.k_text_primary_color,
                                  formatters: [formatter],
                                ),
                                CommonInput(
                                  AppLocalizations.of(context)!.email,
                                  margin:
                                      EdgeInsets.only(bottom: height * 2.79),
                                  type: InputType.EMAIL,
                                  controller: emailController,
                                  customColor: AppColors.k_grey3_color,
                                  borderColor: AppColors.k_grey_divider_color,
                                  textColor: AppColors.k_text_primary_color,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(bottom: height * 3.44),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      IconButton(
                                        padding: EdgeInsets.zero,
                                        constraints: BoxConstraints(),
                                        isSelected: isAgreeWithTerms,
                                        onPressed: () {
                                          setState(
                                            () {
                                              isAgreeWithTerms =
                                                  !isAgreeWithTerms;
                                            },
                                          );
                                        },
                                        icon: !isAgreeWithTerms
                                            ? Icon(
                                                Icons.check_box_outline_blank,
                                                color: AppColors.neutral3,
                                              )
                                            : Icon(
                                                Icons.check_box_outlined,
                                                color: AppColors.neutral3,
                                              ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: Text.rich(
                                          TextSpan(
                                            style: TextStyle(
                                              color: AppColors
                                                  .k_text_primary_color,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                            ),
                                            children: [
                                              TextSpan(
                                                  text: AppLocalizations.of(
                                                          context)!
                                                      .iAgreeWithTerms1),
                                              TextSpan(
                                                text:
                                                    ' ${AppLocalizations.of(context)!.iAgreeWithTerms2}',
                                                style: TextStyle(
                                                  color: AppColors.neutral3,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                divider,
                              ],
                            )
                          : divider,
                      //Payment
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: height * 2.57, top: height * 2.57),
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            setState(() {
                              isPayment = !isPayment;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.payment,
                                style: isPayment
                                    ? Theme.of(context).textTheme.titleSmall
                                    : Theme.of(context).textTheme.titleMedium,
                              ),
                              RotatedBox(
                                quarterTurns: isPayment ? 3 : 2,
                                child: SvgPicture.asset(
                                  'assets/images/svg/arrow_left.svg',
                                  color: isPayment
                                      ? AppColors.k_main_color
                                      : AppColors.k_grey3_color,
                                  // width: width * 35.6,
                                  // height: height * 3.1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      isPayment
                          ? Column(
                              children: [
                                Row(
                                  children: [
                                    Radio<RadioTypes>(
                                      value: RadioTypes.onlinePayment,
                                      groupValue: paymentStatus,
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      visualDensity: const VisualDensity(
                                        horizontal:
                                            VisualDensity.minimumDensity,
                                        vertical: VisualDensity.minimumDensity,
                                      ),
                                      onChanged: (RadioTypes? value) {
                                        setState(() {
                                          paymentStatus = value;
                                        });
                                      },
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      AppLocalizations.of(context)!
                                          .onlinePayment,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.k_text_primary_color,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Radio<RadioTypes>(
                                      value: RadioTypes.offlinePayment,
                                      groupValue: paymentStatus,
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      visualDensity: const VisualDensity(
                                        horizontal:
                                            VisualDensity.minimumDensity,
                                        vertical: VisualDensity.minimumDensity,
                                      ),
                                      onChanged: (RadioTypes? value) {
                                        setState(() {
                                          paymentStatus = value;
                                        });
                                      },
                                    ),
                                    // Text('${RadioTypes.hello}'),
                                    SizedBox(width: 10),
                                    Text(
                                      AppLocalizations.of(context)!
                                          .offlinePayment,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.k_text_primary_color,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: height * 2.57),
                                divider,
                              ],
                            )
                          : divider,
                      SizedBox(height: height * 1.72),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '${AppLocalizations.of(context)!.yourOrderwithCount} 3 ${AppLocalizations.of(context)!.pieces}.',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size(0, 0),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.change,
                              style: TextStyle(
                                color: AppColors.k_main_color,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: width * 17,
                            height: height * 9.44,
                            child: Image.asset(
                              'assets/images/png/product_test.png',
                            ),
                          ),
                          SizedBox(
                            width: width * 17,
                            height: height * 9.44,
                            child: Image.asset(
                              'assets/images/png/product_test.png',
                            ),
                          ),
                          SizedBox(
                            width: width * 17,
                            height: height * 9.44,
                            child: Image.asset(
                              'assets/images/png/product_test.png',
                            ),
                          ),
                        ],
                      ),
                      filledFields
                          ? Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: CommonInput(
                                    AppLocalizations.of(context)!
                                        .enterPromocode,
                                    // margin: EdgeInsets.only(bottom: height * 2.79),
                                    type: InputType.TEXT,
                                    // margin: EdgeInsets.only(top: height * 2.57),
                                    customColor:
                                        Color.fromRGBO(119, 117, 127, 1),
                                    borderColor: AppColors.k_border_grey_color,
                                    controller: codeController,
                                    contentPaddingVertical: 1.6,
                                    rightScreenButton: true,
                                    fontWeight: FontWeight.w400,
                                    textColor: AppColors.k_text_primary_color,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: CommonButton(
                                    onPressed: () {},
                                    backgroundColor: AppColors.k_main_color,
                                    contentPaddingVertical: 1.6,
                                    leftScreenButton: true,
                                    // margin: EdgeInsets.only(top: height * 2.57),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    child: Text(
                                        AppLocalizations.of(context)!.apply),
                                  ),
                                ),
                              ],
                            )
                          : SizedBox.shrink(),
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
                      Row(
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
                                style:
                                    TextStyle(color: AppColors.k_grey400_color),
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
                      Padding(
                        padding: EdgeInsets.only(bottom: 20, top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!
                                      .deductFromBonuses,
                                  style: TextStyle(
                                    color: AppColors.k_main_color,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  // AppLocalizations.of(context)!
                                  //     .amountOfBonus(3000),
                                  '',
                                  style: TextStyle(
                                    color: AppColors.k_main_color,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            CupertinoSwitch(
                              activeColor: AppColors.k_main_color,
                              thumbColor: AppColors.k_white_color,
                              trackColor: Colors.black12,
                              value: isBonus,
                              onChanged: ((value) {
                                setState(() {
                                  isBonus = value;
                                });
                              }),
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
                setState(() {});
              },
              backgroundColor: AppColors.k_secondary_color,
              radius: 8,
              margin: EdgeInsets.only(bottom: height * 1.72),
              child: Text(AppLocalizations.of(context)!.pay),
            ),
          ],
        ),
      ),
    );
  }

  Widget basketItem(BuildContext context) {
    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;
    return StatefulBuilder(builder: (thisLowerContext, innerSetState) {
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
                        '${AppLocalizations.of(context)!.order} 1',
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
                    SizedBox(height: height * 1.72),
                    Row(
                      children: [
                        Radio<RadioTypes>(
                          value: RadioTypes.delivery,
                          groupValue: delivetyStatus,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          visualDensity: const VisualDensity(
                            horizontal: VisualDensity.minimumDensity,
                            vertical: VisualDensity.minimumDensity,
                          ),
                          onChanged: (RadioTypes? value) {
                            innerSetState(() {
                              delivetyStatus = value;
                            });
                          },
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          width: width * 50.3,
                          child: Wrap(
                            children: [
                              Text(
                                'Доставка курьером ',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.k_grey3_color,
                                ),
                                maxLines: 2,
                              ),
                              Text(
                                '15 декабря,',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.k_text_primary_color,
                                ),
                              ),
                              Text(
                                'бесплатно',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.k_text_primary_color,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    //SizedBox(height: height * 1),
                    Row(
                      children: [
                        Radio<RadioTypes>(
                          value: RadioTypes.pickUpByYourself,
                          groupValue: delivetyStatus,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          visualDensity: const VisualDensity(
                            horizontal: VisualDensity.minimumDensity,
                            vertical: VisualDensity.minimumDensity,
                          ),
                          onChanged: (RadioTypes? value) {
                            innerSetState(() {
                              delivetyStatus = value;
                            });
                          },
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          width: width * 50.3,
                          child: Wrap(
                            children: [
                              Text(
                                'Самовывоз ',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.k_grey3_color,
                                ),
                                maxLines: 2,
                              ),
                              Text(
                                'бесплатно',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.k_text_primary_color,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
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
    });
  }
}
