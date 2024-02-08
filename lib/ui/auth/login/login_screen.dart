// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pharma/core/helper/navigateable.dart';
import 'package:pharma/core/routes/routes.dart';
import 'package:pharma/l10n/l10n.dart';
import 'package:provider/provider.dart';
import '../../../core/business/bloc/authorization/authorization_bloc.dart';
import '../../../core/business/bloc/user/user_bloc.dart';
import '../../../core/components/common_button.dart';
import '../../../core/components/common_input.dart';
import '../../../core/components/placeholders.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/helper/input_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/provider/locale_provider.dart';
import '../../../core/storage/local_storage.dart';

class LoginScreen extends StatefulWidget implements Navigateable {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();

  @override
  String getName() {
    return Routes.login;
  }
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthorizationBloc _bloc;

  var loginTextController = TextEditingController();
  var userPasswordController = TextEditingController();

  var binTextController = TextEditingController();
  var legalPasswordController = TextEditingController();

  MaskTextInputFormatter formatter = InputHelper.maskTextInputFormatter();

  bool isRemember = false;

  String language = '';
  var provider = LocaleProvider();
  String? token;
  Future<String?> getAccessToken() async {
    token = await LocalStorage().getToken();
    return token;
  }

  @override
  void initState() {
    super.initState();
    _bloc = context.read<AuthorizationBloc>();
    print(token);
    // initLang();
  }

  // Future<String> getlang() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString('lang') ?? 'ru';
  // }

  // Future initLang() async {
  //   if (getlang().toString() == 'ru') {
  //     provider.setLocale(L10n.locales.elementAt(1));
  //   } else if (getlang().toString() == 'kk') {
  //     provider.setLocale(L10n.locales.elementAt(1));
  //   } else {
  //     provider.setLocale(L10n.locales.elementAt(0));
  //   }
  // }

  // Future setlang(String lang) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setString('lang', lang);
  // }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;
    final provider = Provider.of<LocaleProvider>(context);
    return Listener(
      onPointerDown: (PointerDownEvent event) =>
          FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          margin: EdgeInsets.only(
            left: width * 3.72,
            right: width * 3.72,
            top: (height * 13.9) + MediaQuery.of(context).padding.top,
            bottom: height * 4.2,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: height * 4.5),
                    child: Image.asset(
                      'assets/images/png/logo_blue_big.png',
                    ),
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Radio<RadioTypes>(
                            value: RadioTypes.physStatus,
                            activeColor: AppColors.k_main_color,
                            groupValue: roleStatus,
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
                          SizedBox(width: 10),
                          Text(
                            AppLocalizations.of(context)!.physStatus,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.k_grey300_color,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 24),
                      Row(
                        children: [
                          Radio<RadioTypes>(
                            value: RadioTypes.legalStatus,
                            activeColor: AppColors.k_main_color,
                            groupValue: roleStatus,
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
                          // Text('${RadioTypes.hello}'),
                          SizedBox(width: 10),
                          Text(
                            AppLocalizations.of(context)!.legalStatus,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.k_grey300_color,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  RadioTypes.physStatus == roleStatus
                      ? Column(
                          children: [
                            CommonInput(
                              //  "${MediaQuery.of(context).padding.top}",
                              AppLocalizations.of(context)!.phone,
                              margin: EdgeInsets.only(
                                  bottom: height * 1.72, top: height * 3.65),
                              type: InputType.PHONE,
                              controller: loginTextController,
                              customColor: AppColors.k_grey300_color,
                              borderColor: AppColors.k_border_grey_color,
                              textColor: AppColors.k_grey300_color,
                              formatters: [formatter],
                              textInputAction: TextInputAction.next,
                            ),
                            CommonInput(
                              AppLocalizations.of(context)!.password,
                              margin: EdgeInsets.only(bottom: height * 2.79),
                              type: InputType.PASSWORD,
                              customColor: AppColors.k_grey300_color,
                              borderColor: AppColors.k_border_grey_color,
                              textColor: AppColors.k_grey300_color,
                              oscuredIconColor: AppColors.k_main_color,
                              controller: userPasswordController,
                              textInputAction: TextInputAction.done,
                            ),
                          ],
                        )
                      : SizedBox.shrink(),
                  RadioTypes.legalStatus == roleStatus
                      ? Column(
                          children: [
                            CommonInput(
                              //  "${MediaQuery.of(context).padding.top}",
                              AppLocalizations.of(context)!.bin,
                              margin: EdgeInsets.only(
                                  bottom: height * 1.72, top: height * 3.65),
                              type: InputType.NUMBER,
                              controller: binTextController,
                              customColor: AppColors.k_grey300_color,
                              borderColor: AppColors.k_border_grey_color,
                              textColor: AppColors.k_grey300_color,
                              formatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              textInputAction: TextInputAction.next,
                            ),
                            CommonInput(
                              AppLocalizations.of(context)!.password,
                              margin: EdgeInsets.only(bottom: height * 2.79),
                              type: InputType.PASSWORD,
                              customColor: AppColors.k_grey300_color,
                              borderColor: AppColors.k_border_grey_color,
                              oscuredIconColor: AppColors.k_main_color,
                              controller: legalPasswordController,
                              textColor: AppColors.k_grey300_color,
                              textInputAction: TextInputAction.next,
                            ),
                          ],
                        )
                      : SizedBox.shrink(),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.registration);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.forgotPassword,
                      style: TextStyle(
                        color: AppColors.k_main_color,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  BlocConsumer<AuthorizationBloc, AuthorizationState>(
                    bloc: _bloc,
                    listener: (context, state) {
                      if (state is LoginErrorState) {
                        return AlertController.showMessage(
                          context: context,
                          title: 'error',
                          content: state.error,
                        );
                        // Navigator.pushNamedAndRemoveUntil(
                        //   context,
                        //   Routes.home_screen,
                        //   (route) => false,
                        // );
                      }
                      if (state is LoginLoadedState) {
                        context.read<UserBloc>().updateUser(state.user);
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          Routes.home_screen,
                          (route) => false,
                          arguments: state.user,
                        );
                      }
                      if (state is LoginLoadingState) {
                        //  EasyLoading();
                      }
                    },
                    builder: (context, state) {
                      final isLoading = state is LoginLoadingState;
                      return BlocBuilder<AuthorizationBloc, AuthorizationState>(
                        builder: (context, state) {
                          return CommonButton(
                            onPressed: () {
                              if (isLoading) return;
                              _bloc.login(formatter.getUnmaskedText(),
                                  userPasswordController.text);
                              // Navigator.pushNamedAndRemoveUntil(
                              //   context,
                              //   Routes.home_screen,
                              //   (route) => false,
                              //    arguments: state.user,
                              // );
                            },
                            backgroundColor: AppColors.k_secondary_color,
                            radius: 8,
                            margin: EdgeInsets.only(
                                bottom: height * 1.72, top: height * 2.79),
                            child: state is LoginLoadingState
                                ? SizedBox(
                                    height: height * 1.76,
                                    width: width * 3.73,
                                    child: buildLoading())
                                : Text(AppLocalizations.of(context)!.login),
                          );
                        },
                      );
                    },
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.registration);
                    },
                    child: Text(
                      // '${height}, ${width}',
                      //'${formatter.getUnmaskedText()},\n ${userPasswordController.text}',
                      AppLocalizations.of(context)!.registration,
                      style: TextStyle(
                        color: AppColors.k_main_color,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        provider.setLocale(L10n.locales.elementAt(1));
                        // setlang(provider.locale.toString());
                      });
                      // setlang(provider.locale.toString());
                    },
                    child: Row(
                      children: [
                        Text(
                          'Рус',
                          style: TextStyle(
                            color: AppColors.k_main_color,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(width: 5),
                        SvgPicture.asset(
                          'assets/images/svg/rus.svg',
                          // width: width * 5.58,
                          // height: height * 2,
                          //color: AppColors.k_white_color,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        provider.setLocale(L10n.locales.elementAt(2));
                        //  setlang(provider.locale.toString());
                      });
                    },
                    child: Row(
                      children: [
                        Text(
                          'Қаз',
                          style: TextStyle(
                            color: AppColors.k_main_color,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(width: 5),
                        SvgPicture.asset(
                          'assets/images/svg/kaz.svg',
                          // width: width * 5.58,
                          // height: height * 2,
                          //color: AppColors.k_white_color,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        provider.setLocale(L10n.locales.elementAt(0));
                        // setlang(provider.locale.toString());
                      });
                    },
                    child: Row(
                      children: [
                        Text(
                          'Eng',
                          style: TextStyle(
                            color: AppColors.k_main_color,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(width: 5),
                        SvgPicture.asset(
                          'assets/images/svg/usa.svg',
                          // width: width * 5.58,
                          // height: height * 2,
                          //color: AppColors.k_white_color,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    loginTextController.dispose();
    userPasswordController.dispose();
  }
}
