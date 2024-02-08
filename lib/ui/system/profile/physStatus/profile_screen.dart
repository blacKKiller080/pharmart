// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pharma/core/business/bloc/user/user_bloc.dart';
import 'package:pharma/core/helper/navigateable.dart';
import 'package:pharma/ui/system/favorites/favorites_screen.dart';
import 'package:provider/provider.dart';
import '../../../../core/business/models/user.dart';
import '../../../../core/components/common_button.dart';
import '../../../../core/components/placeholders.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/provider/locale_provider.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/storage/local_storage.dart';
import '../../../../l10n/l10n.dart';
import '../../../nav_bar/navigation_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'edit_screen.dart';

class ProfileScreen extends StatefulWidget implements Navigateable {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();

  @override
  String getName() {
    return Routes.profile_screen;
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  int messageCount = 0;
  int favCount = 5;

  User? user;

  void resetToken() async {
    await LocalStorage().resetStorage();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    final locale = provider.locale ?? Locale('ru');
    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;
    // final user = ModalRoute.of(context)!.settings.arguments as User;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: AppNavigationBar(current: 4),
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
          child: BlocProvider(
            create: (_) => UserBloc()..add(GetUserData()),
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                user = state.user;
                return BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                  user = state.user;
                  return !state.isLoading
                      ? Column(
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
                                        color:
                                            Color.fromARGB(255, 209, 241, 246),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
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
                                              child: !state.isLoading
                                                  ? Text(
                                                      '${user?.fname}',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleMedium,
                                                    )
                                                  : Text(
                                                      'Unauthorized',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleMedium,
                                                    ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: ButtonTheme(
                                                alignedDropdown: true,
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child: DropdownButton(
                                                    isDense: true,
                                                    value: locale,
                                                    icon: const Icon(Icons
                                                        .keyboard_arrow_down_rounded),
                                                    items: L10n.locales.map(
                                                      (locale) {
                                                        final flag =
                                                            L10n.getFlag(locale
                                                                .languageCode);

                                                        return DropdownMenuItem(
                                                          value: locale,
                                                          onTap: () {
                                                            final provider =
                                                                Provider.of<
                                                                        LocaleProvider>(
                                                                    context,
                                                                    listen:
                                                                        false);

                                                            provider.setLocale(
                                                                locale);
                                                          },
                                                          child:
                                                              SvgPicture.asset(
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
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                !state.isLoading
                                                    ? Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (_) =>
                                                              EditScreen(
                                                            user: user,
                                                          ),
                                                        ),
                                                      )
                                                    : () {};
                                              },
                                              child: Stack(
                                                clipBehavior: Clip.none,
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor:
                                                        AppColors.k_white_color,
                                                    radius: height * 2.7,
                                                    child: Center(
                                                      child: SvgPicture.asset(
                                                        'assets/images/svg/add_photo.svg',
                                                        width: width * 5.5,
                                                        height: height * 3.2,
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    left: 33,
                                                    top: -1,
                                                    child: Container(
                                                      height: 16,
                                                      width: 16,
                                                      decoration: BoxDecoration(
                                                        color: AppColors
                                                            .k_secondary_color,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Center(
                                                          child: Icon(
                                                        Icons.edit,
                                                        size: 8,
                                                        color: AppColors
                                                            .k_white_color,
                                                      )),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {},
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Stack(
                                                    clipBehavior: Clip.none,
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/images/svg/email.svg',
                                                        width: 22,
                                                        height: 19,
                                                        color: AppColors
                                                            .k_white_color,
                                                      ),
                                                      messageCount == 1
                                                          ? Container()
                                                          : Positioned(
                                                              left: 14,
                                                              top: -3,
                                                              child: Container(
                                                                height: 16,
                                                                width: 16,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: AppColors
                                                                      .k_secondary_color,
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
                                                                child: Center(
                                                                  child: Text(
                                                                    messageCount
                                                                        .toString(),
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          11.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .messages,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: AppColors
                                                          .k_white_color,
                                                    ),
                                                  ), // <-- Text
                                                ],
                                              ),
                                            ),
                                            // InkWell(
                                            //   onTap: () {},
                                            //   child: Column(
                                            //     mainAxisAlignment: MainAxisAlignment.center,
                                            //     children: <Widget>[
                                            //       SvgPicture.asset(
                                            //         'assets/images/svg/email.svg',
                                            //         width: width * 5.58,
                                            //         height: height * 2,
                                            //         color: AppColors.k_white_color,
                                            //       ),
                                            //       SizedBox(height: 5),
                                            //       Text(
                                            //         AppLocalizations.of(context)!.messages,
                                            //         style: TextStyle(
                                            //           fontSize: 12,
                                            //           fontWeight: FontWeight.w400,
                                            //           color: AppColors.k_white_color,
                                            //         ),
                                            //       ), // <-- Text
                                            //     ],
                                            //   ),
                                            // ),
                                            GestureDetector(
                                              onTap: () {},
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Stack(
                                                    clipBehavior: Clip.none,
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/images/svg/navbar/favourites.svg',
                                                        // width: 22,
                                                        // height: 19,
                                                        color: AppColors
                                                            .k_white_color,
                                                      ),
                                                      messageCount == 1
                                                          ? Container()
                                                          : Positioned(
                                                              left: 18,
                                                              top: -3,
                                                              child: Container(
                                                                height: 16,
                                                                width: 16,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: AppColors
                                                                      .k_secondary_color,
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
                                                                child: Center(
                                                                  child: Text(
                                                                    favCount
                                                                        .toString(),
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          11.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .favorites,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: AppColors
                                                          .k_white_color,
                                                    ),
                                                  ), // <-- Text
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // else if (state
                                //     is BadHabitsError) {
                                //   return Container();
                                // }

                                //Message
                                textWithArrowIcon(
                                  context,
                                  AppLocalizations.of(context)!.myMessages,
                                  () {
                                    Navigator.pushNamed(
                                        context, Routes.message_screen);
                                  },
                                  topPadding: 4.4,
                                ),
                                divider,
                                //Orders
                                textWithArrowIcon(
                                  context,
                                  AppLocalizations.of(context)!.myOrders,
                                  () {
                                    Navigator.pushNamed(
                                        context, Routes.my_orders_screen);
                                  },
                                ),
                                divider,
                                //Bonus
                                textWithArrowIcon(
                                  context,
                                  AppLocalizations.of(context)!.myBonuses,
                                  () {
                                    Navigator.pushNamed(
                                        context, Routes.bonus_screen);
                                  },
                                ),
                                divider,
                                //Favorites
                                textWithArrowIcon(
                                  context,
                                  AppLocalizations.of(context)!.myFavorites,
                                  () {
                                    Navigator.of(context).pushAndRemoveUntil(
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            FavoritesScreen(),
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          return child;
                                        },
                                      ),
                                      (route) => false,
                                    );
                                  },
                                ),
                                divider,
                                //Feedback
                                textWithArrowIcon(
                                  context,
                                  AppLocalizations.of(context)!.myFeedbacks,
                                  () {
                                    Navigator.pushNamed(
                                        context, Routes.feedback_screen);
                                  },
                                ),
                                divider,
                                //Subscriptions
                                textWithArrowIcon(
                                  context,
                                  AppLocalizations.of(context)!.mySubscriptions,
                                  () {
                                    Navigator.pushNamed(
                                        context, Routes.subscription_screen);
                                  },
                                ),
                                divider,
                              ],
                            ),
                            CommonButton(
                              onPressed: () {
                                Navigator.pushNamed(context, Routes.login);
                                resetToken();
                              },
                              backgroundColor: AppColors.k_secondary_color,
                              radius: 8,
                              margin: EdgeInsets.only(bottom: 16, top: 16),
                              child: Text(AppLocalizations.of(context)!.exit),
                            ),
                          ],
                        )
                      : buildLoading();
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
