// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pharma/core/helper/navigateable.dart';
import 'package:pharma/core/repo/repo_settings.dart';
import 'package:pharma/ui/system/profile/legalStatus/company_message_screen.dart';
import 'package:pharma/ui/system/profile/legalStatus/company_orders_screen.dart';
import 'package:provider/provider.dart';
import '../../../../core/components/common_button.dart';
import '../../../../core/components/placeholders.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/provider/locale_provider.dart';
import '../../../../core/routes/routes.dart';
import '../../../../l10n/l10n.dart';
import '../../../nav_bar/navigation_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CompanyProfileScreen extends StatefulWidget implements Navigateable {
  const CompanyProfileScreen({super.key});

  @override
  State<CompanyProfileScreen> createState() => _CompanyProfileScreenState();

  @override
  String getName() {
    return Routes.company_profile_screen;
  }
}

class _CompanyProfileScreenState extends State<CompanyProfileScreen> {
  RepoSettings repoSettings = RepoSettings();

  
//   Future initLocale() async{
//     locale = await readLocale();
//   }

//   void setLocale(String locale) async {
//     await _setLang(locale);
//   }

//  Future _setLang(String locale) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString('lang', locale);
//   }
//   Future<String?> readLocale() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString('lang') ?? 'ru';
//   }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    final locale = provider.locale ?? Locale('ru');
    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: const AppNavigationBar(current: 4),
      backgroundColor: AppColors.k_white_color,
      body: Container(
        height: height * 100,
        margin: EdgeInsets.only(
          right: width * 3.72,
          left: width * 3.72,
        ),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.zero,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    //  height: height * 22.55,
                    margin: EdgeInsets.only(
                      top: AppBar().preferredSize.height + 5,
                    ),
                    padding: EdgeInsets.only(
                      bottom: 17,
                      top: 16,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 170, 240, 246),
                          Color.fromARGB(255, 60, 190, 212),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 209, 241, 246),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 33),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Europharma',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: ButtonTheme(
                                  alignedDropdown: true,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      value: locale,
                                      isDense: true,
                                      icon: const Icon(
                                          Icons.keyboard_arrow_down_rounded),
                                      items: L10n.locales.map(
                                        (locale) {
                                          final flag =
                                              L10n.getFlag(locale.languageCode);

                                          return DropdownMenuItem(
                                            value: locale,
                                            onTap: () {
                                              final provider =
                                                  Provider.of<LocaleProvider>(
                                                      context,
                                                      listen: false);

                                              provider.setLocale(locale);
                                            },
                                            child: SvgPicture.asset(
                                              flag,
                                            ),
                                          );
                                        },
                                      ).toList(),
                                      onChanged: (_) {},
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routes.company_edit_screen);
                                },
                                child: Image.asset(
                                    "assets/images/png/main_page/pharmacy1.png"),
                              ),
                              InkWell(
                                onTap: () {},
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      'assets/images/svg/email.svg',
                                      // width: width * 5.58,
                                      // height: height * 2,
                                      color: AppColors.k_white_color,
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      AppLocalizations.of(context)!.messages,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.k_white_color,
                                      ),
                                    ), // <-- Text
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: AppColors.k_secondary_color,
                                        size: 20,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        '5.0',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.k_white_color,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "90 отзывов",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.k_white_color,
                                    ),
                                  ), // <-- Text
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  //Message
                  textWithArrowIcon(
                    context,
                    AppLocalizations.of(context)!.messages,
                    () {
                      Navigator.of(context).pushAndRemoveUntil(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  CompanyMessageScreen(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return child;
                          },
                        ),
                        (route) => false,
                      );
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => CompanyMessageScreen(),
                      //   ),
                      // );
                    },
                    topPadding: 4.4,
                  ),
                  divider,
                  //Orders
                  textWithArrowIcon(
                    context,
                    AppLocalizations.of(context)!.orders,
                    () {
                      Navigator.of(context).pushAndRemoveUntil(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  CompanyOrdersScreen(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return child;
                          },
                        ),
                        (route) => false,
                      );
                    },
                  ),
                  divider,
                  //Bonus
                  textWithArrowIcon(
                    context,
                    AppLocalizations.of(context)!.analytics,
                    () {
                      Navigator.pushNamed(
                          context, Routes.company_analytic_screen);
                    },
                  ),
                  divider,
                  //Favorites
                  textWithArrowIcon(
                    context,
                    AppLocalizations.of(context)!.stockManagement,
                    () {
                      Navigator.pushNamed(context, Routes.company_stock_screen);
                    },
                  ),
                  divider,
                  //Feedback
                  textWithArrowIcon(
                    context,
                    AppLocalizations.of(context)!.productsPromotion,
                    () {
                      Navigator.pushNamed(
                          context, Routes.company_promotion_screen);
                    },
                  ),
                  divider,
                  //Subscriptions
                  textWithArrowIcon(
                    context,
                    AppLocalizations.of(context)!.rating,
                    () {
                      Navigator.pushNamed(
                          context, Routes.company_rating_screen);
                    },
                  ),
                  divider,
                  textWithArrowIcon(
                    context,
                    AppLocalizations.of(context)!.feedbacks,
                    () {
                      Navigator.pushNamed(
                          context, Routes.company_feedback_screen);
                    },
                  ),
                  divider,
                ],
              ),
              CommonButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.login);
                },
                backgroundColor: AppColors.k_secondary_color,
                radius: 8,
                margin:
                    EdgeInsets.only(bottom: height * 1.72, top: height * 2.57),
                child: Text(AppLocalizations.of(context)!.exit),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
