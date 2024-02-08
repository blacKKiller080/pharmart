import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pharma/core/helper/navigateable.dart';
import 'package:pharma/core/routes/routes.dart';
import '../../../../core/components/placeholders.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/components/common_button.dart';
import '../../../../core/components/common_input.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/helper/input_helper.dart';
import '../../../nav_bar/navigation_bar.dart';

class CompanyEditScreen extends StatefulWidget implements Navigateable {
  const CompanyEditScreen({super.key});

  @override
  State<CompanyEditScreen> createState() => _CompanyEditScreenState();

  @override
  String getName() {
    return Routes.company_edit_screen;
  }
}

class _CompanyEditScreenState extends State<CompanyEditScreen> {
  var companyNameController = TextEditingController();
  var BINController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var legalAddressController = TextEditingController();
  var actualAddressController = TextEditingController();

  var nameController = TextEditingController();
  var surnameController = TextEditingController();
  var patronymicController = TextEditingController();
  var positionController = TextEditingController();
  var phone2Controller = TextEditingController();
  var email2Controller = TextEditingController();

  MaskTextInputFormatter formatter = InputHelper.maskTextInputFormatter();

  static const List<String> list = <String>[
    'Алматы',
    'Астана',
    'Тараз',
  ];
  String cityValue = list.first;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: const AppNavigationBar(current: 4),
      backgroundColor: AppColors.k_white_color,
      appBar: appBar(context, AppLocalizations.of(context)!.personalInfo),
      body: Container(
        height: height * 100,
        margin: EdgeInsets.only(
          right: width * 3.72,
          left: width * 3.72,
        ),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonButton(
                      onPressed: () {},
                      borderColor: true,
                      foregroundColor: AppColors.k_main_color,
                      backgroundColor: AppColors.k_white_color,
                      radius: 8,
                      contentPaddingVertical: 2.09,
                      containerWidth: width * 51.9,
                      margin: EdgeInsets.only(right: width * 2.33),
                      child: Text(
                        AppLocalizations.of(context)!.uploadLogo,
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    SizedBox(
                      // height: height * 6.3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.status,
                            style: TextStyle(
                              color: AppColors.k_text_primary_color,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                          Row(
                            children: [
                              Radio<RadioTypes>(
                                value: RadioTypes.legalStatus,
                                groupValue: roleStatus,
                                activeColor: AppColors.k_main_color,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                visualDensity: const VisualDensity(
                                  horizontal: VisualDensity.minimumDensity,
                                  vertical: VisualDensity.minimumDensity,
                                ),
                                onChanged: (RadioTypes? value) {
                                  setState(() {
                                    roleStatus = value;
                                  });
                                },
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                width: width * 27,
                                child: Wrap(
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.legalStatus,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.k_text_primary_color,
                                      ),
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                CommonInput(
                  AppLocalizations.of(context)!.companyName,
                  margin: EdgeInsets.only(
                      bottom: height * 1.72, top: height * 2.57),
                  type: InputType.TEXT,
                  customColor: AppColors.k_grey300_color,
                  borderColor: AppColors.k_border_grey_color,
                  textColor: AppColors.k_text_primary_color,
                  controller: companyNameController,
                  contentPaddingVertical: 1.72,
                  textInputAction: TextInputAction.next,
                ),
                CommonInput(
                  AppLocalizations.of(context)!.bin,
                  margin: EdgeInsets.only(bottom: height * 1.72),
                  type: InputType.TEXT,
                  customColor: AppColors.k_grey300_color,
                  borderColor: AppColors.k_border_grey_color,
                  textColor: AppColors.k_text_primary_color,
                  controller: BINController,
                  contentPaddingVertical: 1.72,
                  textInputAction: TextInputAction.next,
                ),
                CommonInput(
                  AppLocalizations.of(context)!.phone,
                  margin: EdgeInsets.only(bottom: height * 1.72),
                  type: InputType.PHONE,
                  customColor: AppColors.k_grey300_color,
                  borderColor: AppColors.k_border_grey_color,
                  textColor: AppColors.k_text_primary_color,
                  controller: phoneController,
                  contentPaddingVertical: 1.72,
                  textInputAction: TextInputAction.next,
                  formatters: [formatter],
                ),
                CommonInput(
                  AppLocalizations.of(context)!.email,
                  margin: EdgeInsets.only(bottom: height * 1.72),
                  type: InputType.EMAIL,
                  customColor: AppColors.k_grey300_color,
                  borderColor: AppColors.k_border_grey_color,
                  textColor: AppColors.k_text_primary_color,
                  controller: emailController,
                  contentPaddingVertical: 1.72,
                  textInputAction: TextInputAction.next,
                ),
                CommonInput(
                  AppLocalizations.of(context)!.registeredAddress,
                  margin: EdgeInsets.only(bottom: height * 1.72),
                  type: InputType.TEXT,
                  customColor: AppColors.k_grey300_color,
                  borderColor: AppColors.k_border_grey_color,
                  textColor: AppColors.k_text_primary_color,
                  controller: legalAddressController,
                  contentPaddingVertical: 1.72,
                  textInputAction: TextInputAction.next,
                ),
                CommonInput(
                  AppLocalizations.of(context)!.actualAddress,
                  margin: EdgeInsets.only(bottom: height * 1.72),
                  type: InputType.TEXT,
                  customColor: AppColors.k_grey300_color,
                  borderColor: AppColors.k_border_grey_color,
                  textColor: AppColors.k_text_primary_color,
                  controller: actualAddressController,
                  contentPaddingVertical: 1.72,
                  textInputAction: TextInputAction.done,
                ),
                CommonButton(
                  onPressed: () {},
                  // backgroundColor: AppColors.neutral3,
                  borderColor: true,
                  foregroundColor: AppColors.k_main_color,
                  backgroundColor: AppColors.k_white_color,
                  radius: 8,
                  margin: EdgeInsets.only(bottom: height * 1.72),
                  child: Text(
                    AppLocalizations.of(context)!.edit,
                  ),
                ),
                CommonButton(
                  onPressed: () {},
                  // backgroundColor: AppColors.neutral3,
                  foregroundColor: AppColors.k_main_color,
                  backgroundColor: AppColors.k_white_color,
                  radius: 8,
                  margin: EdgeInsets.only(bottom: height * 2.79),
                  child: Text(
                    AppLocalizations.of(context)!.changePassword,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.file_open,
                      size: 14,
                    ),
                    SizedBox(width: 5),
                    Text(
                      AppLocalizations.of(context)!.partnershipCertificate,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 4),
                Text(
                  AppLocalizations.of(context)!.responsibleEmployee,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                CommonInput(
                  AppLocalizations.of(context)!.lName,
                  margin: EdgeInsets.only(
                      bottom: height * 1.72, top: height * 2.57),
                  type: InputType.TEXT,
                  customColor: AppColors.k_grey300_color,
                  borderColor: AppColors.k_border_grey_color,
                  textColor: AppColors.k_text_primary_color,
                  controller: surnameController,
                  contentPaddingVertical: 1.72,
                  textInputAction: TextInputAction.next,
                ),
                CommonInput(
                  AppLocalizations.of(context)!.fName,
                  margin: EdgeInsets.only(bottom: height * 1.72),
                  type: InputType.TEXT,
                  customColor: AppColors.k_grey300_color,
                  borderColor: AppColors.k_border_grey_color,
                  textColor: AppColors.k_text_primary_color,
                  controller: nameController,
                  contentPaddingVertical: 1.72,
                  textInputAction: TextInputAction.next,
                ),
                CommonInput(
                  AppLocalizations.of(context)!.patronymic,
                  margin: EdgeInsets.only(bottom: height * 1.72),
                  type: InputType.TEXT,
                  customColor: AppColors.k_grey300_color,
                  borderColor: AppColors.k_border_grey_color,
                  textColor: AppColors.k_text_primary_color,
                  controller: patronymicController,
                  contentPaddingVertical: 1.72,
                  textInputAction: TextInputAction.next,
                ),
                CommonInput(
                  AppLocalizations.of(context)!.position,
                  margin: EdgeInsets.only(bottom: height * 1.72),
                  type: InputType.TEXT,
                  customColor: AppColors.k_grey300_color,
                  borderColor: AppColors.k_border_grey_color,
                  textColor: AppColors.k_text_primary_color,
                  controller: positionController,
                  contentPaddingVertical: 1.72,
                  textInputAction: TextInputAction.next,
                ),
                CommonInput(
                  AppLocalizations.of(context)!.phone,
                  margin: EdgeInsets.only(bottom: height * 1.72),
                  type: InputType.PHONE,
                  customColor: AppColors.k_grey300_color,
                  borderColor: AppColors.k_border_grey_color,
                  textColor: AppColors.k_text_primary_color,
                  controller: phone2Controller,
                  contentPaddingVertical: 1.72,
                  textInputAction: TextInputAction.next,
                  formatters: [formatter],
                ),
                CommonInput(
                  AppLocalizations.of(context)!.email,
                  margin: EdgeInsets.only(bottom: height * 1.72),
                  type: InputType.EMAIL,
                  customColor: AppColors.k_grey300_color,
                  borderColor: AppColors.k_border_grey_color,
                  textColor: AppColors.k_text_primary_color,
                  controller: email2Controller,
                  contentPaddingVertical: 1.72,
                  textInputAction: TextInputAction.done,
                ),
                CommonButton(
                  onPressed: () {},
                  // backgroundColor: AppColors.neutral3,
                  borderColor: true,
                  foregroundColor: AppColors.k_main_color,
                  backgroundColor: AppColors.k_white_color,
                  radius: 8,
                  margin: EdgeInsets.only(bottom: height * 3.32),
                  child: Text(
                    AppLocalizations.of(context)!.edit,
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
