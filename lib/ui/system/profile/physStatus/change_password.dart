import 'package:flutter/material.dart';
import 'package:pharma/core/helper/navigateable.dart';
import 'package:pharma/core/routes/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/components/common_button.dart';
import '../../../../core/components/common_input.dart';
import '../../../../core/components/placeholders.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../nav_bar/navigation_bar.dart';

class ChangePasswordScreen extends StatefulWidget implements Navigateable {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();

  @override
  String getName() {
    return Routes.change_pass_screen;
  }
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  var oldPasswordController = TextEditingController();
  var newRepeatPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: const AppNavigationBar(current: 4),
      backgroundColor: AppColors.k_white_color,
      appBar: appBar(context, AppLocalizations.of(context)!.changePassword),
      body: Container(
        height: height * 100,
        margin: EdgeInsets.only(
          right: width * 3.72,
          left: width * 3.72,
        ),
        child: Column(
          children: [
            CommonInput(
              AppLocalizations.of(context)!.oldPassword,
              margin:
                  EdgeInsets.only(bottom: height * 1.72, top: height * 2.57),
              type: InputType.PASSWORD,
              customColor: AppColors.k_grey300_color,
              borderColor: AppColors.k_border_grey_color,
              textColor: AppColors.k_text_primary_color,
              controller: oldPasswordController,
              contentPaddingVertical: 1.72,
              textInputAction: TextInputAction.next,
            ),
            CommonInput(
              AppLocalizations.of(context)!.newPassword,
              margin: EdgeInsets.only(bottom: height * 1.72),
              type: InputType.PASSWORD,
              customColor: AppColors.k_grey300_color,
              borderColor: AppColors.k_border_grey_color,
              textColor: AppColors.k_text_primary_color,
              controller: newPasswordController,
              contentPaddingVertical: 1.72,
              textInputAction: TextInputAction.next,
            ),
            CommonInput(
              AppLocalizations.of(context)!.repeatNewPass,
              margin: EdgeInsets.only(bottom: height * 2.72),
              type: InputType.PASSWORD,
              customColor: AppColors.k_grey300_color,
              borderColor: AppColors.k_border_grey_color,
              textColor: AppColors.k_text_primary_color,
              controller: newRepeatPasswordController,
              contentPaddingVertical: 1.72,
            ),
            CommonButton(
              onPressed: () {},
              borderColor: true,
              foregroundColor: AppColors.k_main_color,
              backgroundColor: AppColors.k_white_color,
              radius: 8,
              margin: EdgeInsets.only(bottom: height * 1.72),
              child: Text(
                AppLocalizations.of(context)!.saveNewPass,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
