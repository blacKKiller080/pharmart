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

class AddCardScreen extends StatefulWidget implements Navigateable {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();

  @override
  String getName() {
    return Routes.add_card_screen;
  }
}

class _AddCardScreenState extends State<AddCardScreen> {
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
      appBar: appBar(context, AppLocalizations.of(context)!.addCard),
      body: Container(
        height: height * 100,
        margin: EdgeInsets.only(
          right: width * 3.72,
          left: width * 3.72,
          top: height * 10.72,
        ),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(bottom: height * 2.57),
          shrinkWrap: true,
          children: [
            Form(
              child: Column(
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
                          // margin: EdgeInsets.only(right: width * 2.8),
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
                  // Container(
                  //   margin:
                  //       EdgeInsets.only(top: height * 1.87, right: width * 20),
                  //   child: Row(
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //       Flexible(
                  //         flex: 3,
                  //         child: Text(
                  //           AppLocalizations.of(context)!.securityCode,
                  //           style: TextStyle(
                  //             color: AppColors.k_grey3_color,
                  //             fontWeight: FontWeight.w400,
                  //             fontSize: 14,
                  //           ),
                  //         ),
                  //       ),
                  //       SizedBox(width: width * 2.8),
                  //       Flexible(
                  //         flex: 2,
                  //         child: CommonInput(
                  //           AppLocalizations.of(context)!.svv,
                  //           margin: EdgeInsets.only(right: width * 2.8),
                  //           type: InputType.NUMBER,
                  //           customColor: AppColors.k_grey300_color,
                  //           borderColor: AppColors.k_border_grey_color,
                  //           textColor: AppColors.k_text_primary_color,
                  //           controller: svvController,
                  //           contentPaddingVertical: 1.72,
                  //           formatters: [
                  //             LengthLimitingTextInputFormatter(3),
                  //             FilteringTextInputFormatter.digitsOnly
                  //           ],
                  //         ),
                  //       ),
                  //       Tooltip(
                  //         waitDuration: Duration(seconds: 1),
                  //         showDuration: Duration(seconds: 2),
                  //         margin: EdgeInsets.only(
                  //           right: width * 20,
                  //           left: width * 20,
                  //         ),
                  //         padding: EdgeInsets.only(
                  //           right: width * 2,
                  //           left: width * 2,
                  //           top: height * 1.72,
                  //           bottom: height * 1.72,
                  //         ),
                  //         height: 35,
                  //         triggerMode: TooltipTriggerMode.longPress,
                  //         textStyle: TextStyle(
                  //           fontSize: 15,
                  //           color: Colors.white,
                  //           fontWeight: FontWeight.normal,
                  //         ),
                  //         decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(10),
                  //             color: AppColors.k_grey3_color),
                  //         message: AppLocalizations.of(context)!.svvInfo,
                  //         child: IconButton(
                  //           padding: EdgeInsets.zero,
                  //           constraints: BoxConstraints(),
                  //           icon: Icon(
                  //             Icons.info,
                  //             color: AppColors.k_grey3_color,
                  //           ),
                  //           onPressed: () {
                  //             /* your code */
                  //           },
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  CommonButton(
                    onPressed: () {},
                    // backgroundColor: AppColors.neutral3,
                    borderColor: true,
                    foregroundColor: AppColors.k_main_color,
                    backgroundColor: AppColors.k_white_color,

                    radius: 8,
                    margin: EdgeInsets.only(
                        bottom: height * 1.72, top: height * 3.87),
                    child: Text(
                      AppLocalizations.of(context)!.save,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
