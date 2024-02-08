// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pharma/core/helper/navigateable.dart';
import 'package:pharma/core/routes/routes.dart';
import '../../../../core/components/placeholders.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../nav_bar/navigation_bar.dart';

class CompanyMessageScreen extends StatefulWidget implements Navigateable {
  const CompanyMessageScreen({super.key});

  @override
  State<CompanyMessageScreen> createState() => _CompanyMessageScreenState();

  @override
  String getName() {
    return Routes.company_message_screen;
  }
}

class _CompanyMessageScreenState extends State<CompanyMessageScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: AppNavigationBar(current: 2),
      backgroundColor: AppColors.k_white_color,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.myMessages,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
        elevation: 0.0,
        toolbarHeight: height * 7,
        backgroundColor: AppColors.k_white_color,
      ),
      body: Container(
        height: height * 100,
        margin: EdgeInsets.only(
          right: width * 3.72,
          left: width * 3.72,
        ),
        child: Column(
          children: [
            Padding(
              padding:
                  EdgeInsets.only(bottom: height * 2.57, top: height * 2.57),
              child: GestureDetector(
                onTap: () {
                  setState(() {});
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/svg/message.svg',
                          // width: width * 5.58,
                          // height: height * 2.57,
                        ),
                        SizedBox(width: width * 2.32),
                        Text('Служба поддержки',
                            style: Theme.of(context).textTheme.titleSmall),
                      ],
                    ),
                    Text(
                      '25.12.2022',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.k_grey3_color),
                    ),
                  ],
                ),
              ),
            ),
            divider,
            Padding(
              padding:
                  EdgeInsets.only(bottom: height * 2.15, top: height * 2.25),
              child: GestureDetector(
                onTap: () {
                  setState(() {});
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/svg/message.svg',
                          // width: width * 5.58,
                          // height: height * 2.57,
                        ),
                        SizedBox(width: width * 2.32),
                        Text('Служба поддержки',
                            style: Theme.of(context).textTheme.titleSmall),
                      ],
                    ),
                    Text(
                      '25.12.2022',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.k_grey3_color),
                    ),
                  ],
                ),
              ),
            ),
            divider,
            Padding(
              padding:
                  EdgeInsets.only(bottom: height * 2.15, top: height * 2.25),
              child: GestureDetector(
                onTap: () {
                  setState(() {});
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/svg/message.svg',
                          // width: width * 5.58,
                          // height: height * 2.57,
                        ),
                        SizedBox(width: width * 2.32),
                        Text('Служба поддержки',
                            style: Theme.of(context).textTheme.titleSmall),
                      ],
                    ),
                    Text(
                      '25.12.2022',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.k_grey3_color),
                    ),
                  ],
                ),
              ),
            ),
            divider,
            Padding(
              padding:
                  EdgeInsets.only(bottom: height * 2.15, top: height * 2.25),
              child: GestureDetector(
                onTap: () {
                  setState(() {});
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/svg/message.svg',
                          // width: width * 5.58,
                          // height: height * 2.57,
                        ),
                        SizedBox(width: width * 2.32),
                        Text('Служба поддержки',
                            style: Theme.of(context).textTheme.titleSmall),
                      ],
                    ),
                    Text(
                      '25.12.2022',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.k_grey3_color),
                    ),
                  ],
                ),
              ),
            ),
            divider,
            Padding(
              padding:
                  EdgeInsets.only(bottom: height * 2.15, top: height * 2.25),
              child: GestureDetector(
                onTap: () {
                  setState(() {});
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/svg/message.svg',
                          // width: width * 5.58,
                          // height: height * 2.57,
                        ),
                        SizedBox(width: width * 2.32),
                        Text('Служба поддержки',
                            style: Theme.of(context).textTheme.titleSmall),
                      ],
                    ),
                    Text(
                      '25.12.2022',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.k_grey3_color),
                    ),
                  ],
                ),
              ),
            ),
            divider,
          ],
        ),
      ),
    );
  }
}
