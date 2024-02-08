import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pharma/core/helper/input_helper.dart';
import 'package:pharma/core/helper/navigateable.dart';
import 'package:pharma/core/routes/routes.dart';

import '../../../../core/components/common_button.dart';
import '../../../../core/components/common_input.dart';
import '../../../../core/components/placeholders.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/helper/card_utils.dart';
import '../../../nav_bar/navigation_bar.dart';

class CardInfoScreen extends StatefulWidget implements Navigateable {
  const CardInfoScreen({super.key});

  @override
  State<CardInfoScreen> createState() => _CardInfoScreenState();

  @override
  String getName() {
    return Routes.edit_card_screen;
  }
}

class _CardInfoScreenState extends State<CardInfoScreen> {
  bool mainCard = false;
  CardType? cardType;

  @override
  void initState() {
    cardController.addListener(
      () {
        getCardTypeFrmNumber();
      },
    );
    super.initState();
  }

  var cardController = TextEditingController();
  var nameController = TextEditingController();
  var yearMonthController = TextEditingController();
  var svvController = TextEditingController();

  MaskTextInputFormatter cardNumberFormatter =
      InputHelper.bankTextInputFormatter();
  MaskTextInputFormatter cardDateFormatter =
      InputHelper.creditCardDateInputFormatter();

  void getCardTypeFrmNumber() {
    if (cardController.text.length <= 6) {
      String input = CardUtils.getCleanedNumber(cardController.text);
      CardType type = CardUtils.getCardTypeFrmNumber(input);
      if (type != cardType) {
        setState(() {
          cardType = type;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: AppNavigationBar(current: 4),
      backgroundColor: AppColors.k_white_color,
      appBar: appBar(context, AppLocalizations.of(context)!.cardInfo),
      body: Container(
        height: height * 100,
        margin: EdgeInsets.only(
          right: width * 3.72,
          left: width * 3.72,
          top: height * 5,
        ),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(bottom: height * 2.57),
          shrinkWrap: true,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonInput(
                  AppLocalizations.of(context)!.cardNumber,
                  margin: EdgeInsets.only(bottom: height * 1.72),
                  type: InputType.NUMBER,
                  customColor: AppColors.k_grey300_color,
                  borderColor: AppColors.k_border_grey_color,
                  textColor: AppColors.k_text_primary_color,
                  controller: cardController,
                  contentPaddingVertical: 1.72,
                  isSearchPrefix: true,
                  isSuffixIcon: true,
                  suffixIcon: CardUtils.getCardIcon(cardType),
                  prefixIcon: Icons.credit_card_rounded,
                  formatters: [cardNumberFormatter],
                ),
                CommonInput(
                  AppLocalizations.of(context)!.cardNumber,
                  margin: EdgeInsets.only(bottom: height * 1.72),
                  type: InputType.TEXT,
                  customColor: AppColors.k_grey300_color,
                  borderColor: AppColors.k_border_grey_color,
                  textColor: AppColors.k_text_primary_color,
                  controller: nameController,
                  contentPaddingVertical: 1.72,
                  isSearchPrefix: true,
                  prefixIcon: Icons.person_outline_outlined,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CommonInput(
                        AppLocalizations.of(context)!.mmYY,
                        //margin: EdgeInsets.only(right: width * 3.72),
                        type: InputType.NUMBER,
                        customColor: AppColors.k_grey300_color,
                        borderColor: AppColors.k_border_grey_color,
                        textColor: AppColors.k_text_primary_color,
                        controller: yearMonthController,
                        contentPaddingVertical: 1.72,
                        textInputAction: TextInputAction.next,
                        isSearchPrefix: true,
                        prefixIcon: Icons.calendar_month_outlined,
                        formatters: [
                          LengthLimitingTextInputFormatter(5),
                          FilteringTextInputFormatter.digitsOnly,
                          CardMonthInputFormatter()
                        ],
                      ),
                    ),
                    SizedBox(width: 24),
                    Expanded(
                      child: CommonInput(
                        AppLocalizations.of(context)!.svv,
                        margin: EdgeInsets.only(bottom: height * 1.72),
                        type: InputType.NUMBER,
                        customColor: AppColors.k_grey300_color,
                        borderColor: AppColors.k_border_grey_color,
                        textColor: AppColors.k_text_primary_color,
                        controller: svvController,
                        contentPaddingVertical: 1.72,
                        isSearchPrefix: true,
                        prefixIcon: Icons.fiber_pin_rounded,
                        formatters: [
                          LengthLimitingTextInputFormatter(3),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        AppLocalizations.of(context)!.makeMainCard,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                    CupertinoSwitch(
                      activeColor: AppColors.k_main_color,
                      thumbColor: AppColors.k_white_color,
                      trackColor: Colors.black12,
                      value: mainCard,
                      onChanged: ((value) {
                        setState(() {
                          mainCard = value;
                        });
                      }),
                    ),
                  ],
                ),
                CommonButton(
                  onPressed: () {},
                  // backgroundColor: AppColors.neutral3,
                  borderColor: true,
                  foregroundColor: AppColors.k_main_color,
                  backgroundColor: AppColors.k_white_color,

                  radius: 8,
                  margin: EdgeInsets.only(
                      bottom: height * 1.72, top: height * 2.57),
                  child: Text(
                    AppLocalizations.of(context)!.seveChanges,
                  ),
                ),
                CommonButton(
                  onPressed: () {},
                  // backgroundColor: AppColors.neutral3,
                  foregroundColor: AppColors.k_main_color,
                  backgroundColor: AppColors.k_white_color,
                  radius: 8,
                  child: Text(
                    AppLocalizations.of(context)!.delete,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
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
