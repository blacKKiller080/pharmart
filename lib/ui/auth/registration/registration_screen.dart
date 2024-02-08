// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pharma/core/helper/input_helper.dart';
import 'package:pharma/core/helper/navigateable.dart';
import 'package:pharma/core/routes/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/business/bloc/authorization/authorization_bloc.dart';
import '../../../core/components/common_button.dart';
import '../../../core/components/common_input.dart';
import '../../../core/components/placeholders.dart';
import '../../../core/constants/app_colors.dart';

class RegistrationScreen extends StatefulWidget implements Navigateable {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();

  @override
  String getName() {
    return Routes.registration;
  }
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  var nameTextController = TextEditingController();
  var surnameTextController = TextEditingController();
  var userPhoneTextController = TextEditingController();
  var userEmailController = TextEditingController();
  var userPasswordController = TextEditingController();
  var userRepeatPasswordController = TextEditingController();

  var companyNameController = TextEditingController();
  var binTextController = TextEditingController();
  var legalAddressController = TextEditingController();
  var actualAddressController = TextEditingController();
  var phoneTextController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var repeatPasswordController = TextEditingController();

  MaskTextInputFormatter userFormatter = InputHelper.maskTextInputFormatter();
  MaskTextInputFormatter formatter = InputHelper.maskTextInputFormatter();

  bool isRemember = false;

  late AuthorizationBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<AuthorizationBloc>();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;
    return Listener(
      onPointerDown: (PointerDownEvent event) =>
          FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.k_main_color,
        body: SizedBox(
          height: height * 100,
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            padding: EdgeInsets.only(
              left: width * 3.72,
              right: width * 3.72,
              top: (height * 13.9) + MediaQuery.of(context).padding.top,
              bottom: height * 4.2,
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: height * 4.5),
                  // width: width * 49.8,
                  // height: height * 4.4,
                  child: Image.asset(
                    'assets/images/png/logo_white.png',
                    scale: 1.5,
                  ),
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Radio<RadioTypes>(
                          value: RadioTypes.physStatus,
                          activeColor: Color.fromARGB(255, 254, 131, 38),
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
                            color: AppColors.k_white_color,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 24),
                    Row(
                      children: [
                        Radio<RadioTypes>(
                          value: RadioTypes.legalStatus,
                          activeColor: Color.fromARGB(255, 254, 131, 38),
                          // fillColor: MaterialStateProperty.all(
                          //     Color.fromARGB(255, 188, 188, 187)),
                          // overlayColor: MaterialStateProperty.all(
                          //     Color.fromARGB(255, 254, 131, 38)),
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
                            color: AppColors.k_white_color,
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
                            //"${character}",
                            AppLocalizations.of(context)!.fName,
                            margin: EdgeInsets.only(
                                bottom: height * 1.72, top: height * 3.65),
                            type: InputType.TEXT,
                            controller: nameTextController,
                            customColor: AppColors.k_white_color,
                            borderColor: AppColors.k_white_color,
                            textInputAction: TextInputAction.next,
                          ),
                          CommonInput(
                            AppLocalizations.of(context)!.lName,
                            margin: EdgeInsets.only(bottom: height * 1.72),
                            type: InputType.TEXT,
                            customColor: AppColors.k_white_color,
                            borderColor: AppColors.k_white_color,
                            controller: surnameTextController,
                            textInputAction: TextInputAction.next,
                          ),
                          CommonInput(
                            AppLocalizations.of(context)!.phone,
                            margin: EdgeInsets.only(bottom: height * 1.72),
                            type: InputType.PHONE,
                            customColor: AppColors.k_white_color,
                            borderColor: AppColors.k_white_color,
                            controller: userPhoneTextController,
                            formatters: [userFormatter],
                            textInputAction: TextInputAction.next,
                          ),
                          CommonInput(
                            AppLocalizations.of(context)!.email,
                            margin: EdgeInsets.only(bottom: height * 1.72),
                            type: InputType.EMAIL,
                            customColor: AppColors.k_white_color,
                            borderColor: AppColors.k_white_color,
                            controller: userEmailController,
                            textInputAction: TextInputAction.next,
                          ),
                          CommonInput(
                            AppLocalizations.of(context)!.password,
                            margin: EdgeInsets.only(bottom: height * 1.72),
                            type: InputType.PASSWORD,
                            controller: userPasswordController,
                            customColor: AppColors.k_white_color,
                            borderColor: AppColors.k_white_color,
                            oscuredIconColor: AppColors.k_white_color,
                            textInputAction: TextInputAction.next,
                          ),
                          CommonInput(
                            AppLocalizations.of(context)!.repeatPassword,
                            margin: EdgeInsets.only(bottom: height * 2.79),
                            type: InputType.PASSWORD,
                            customColor: AppColors.k_white_color,
                            borderColor: AppColors.k_white_color,
                            oscuredIconColor: AppColors.k_white_color,
                            controller: userRepeatPasswordController,
                            textInputAction: TextInputAction.done,
                          ),
                        ],
                      )
                    : SizedBox.shrink(),
                RadioTypes.legalStatus == roleStatus
                    ? Column(
                        children: [
                          CommonInput(
                            //"${character}",
                            AppLocalizations.of(context)!.companyName,
                            margin: EdgeInsets.only(
                                bottom: height * 1.72, top: height * 3.65),
                            type: InputType.TEXT,
                            controller: companyNameController,
                            customColor: AppColors.k_white_color,
                            borderColor: AppColors.k_white_color,
                            textInputAction: TextInputAction.next,
                          ),
                          CommonInput(
                            AppLocalizations.of(context)!.bin,
                            margin: EdgeInsets.only(bottom: height * 1.72),
                            type: InputType.TEXT,
                            customColor: AppColors.k_white_color,
                            borderColor: AppColors.k_white_color,
                            controller: binTextController,
                            textInputAction: TextInputAction.next,
                          ),
                          CommonInput(
                            AppLocalizations.of(context)!.phone,
                            margin: EdgeInsets.only(bottom: height * 1.72),
                            type: InputType.PHONE,
                            customColor: AppColors.k_white_color,
                            borderColor: AppColors.k_white_color,
                            controller: phoneTextController,
                            formatters: [formatter],
                            textInputAction: TextInputAction.next,
                          ),
                          CommonInput(
                            AppLocalizations.of(context)!.email,
                            margin: EdgeInsets.only(bottom: height * 1.72),
                            type: InputType.EMAIL,
                            customColor: AppColors.k_white_color,
                            borderColor: AppColors.k_white_color,
                            controller: emailController,
                            textInputAction: TextInputAction.next,
                          ),
                          CommonInput(
                            AppLocalizations.of(context)!.registeredAddress,
                            margin: EdgeInsets.only(bottom: height * 1.72),
                            type: InputType.TEXT,
                            controller: legalAddressController,
                            customColor: AppColors.k_white_color,
                            borderColor: AppColors.k_white_color,
                            textInputAction: TextInputAction.next,
                          ),
                          CommonInput(
                            AppLocalizations.of(context)!.actualAddress,
                            margin: EdgeInsets.only(bottom: height * 1.72),
                            type: InputType.TEXT,
                            customColor: AppColors.k_white_color,
                            borderColor: AppColors.k_white_color,
                            controller: actualAddressController,
                            textInputAction: TextInputAction.done,
                          ),
                          CommonInput(
                            AppLocalizations.of(context)!.password,
                            margin: EdgeInsets.only(bottom: height * 1.72),
                            type: InputType.PASSWORD,
                            controller: passwordController,
                            customColor: AppColors.k_white_color,
                            borderColor: AppColors.k_white_color,
                            oscuredIconColor: AppColors.k_white_color,
                            textInputAction: TextInputAction.next,
                          ),
                          CommonInput(
                            AppLocalizations.of(context)!.repeatPassword,
                            margin: EdgeInsets.only(bottom: height * 2.79),
                            type: InputType.PASSWORD,
                            customColor: AppColors.k_white_color,
                            borderColor: AppColors.k_white_color,
                            oscuredIconColor: AppColors.k_white_color,
                            controller: repeatPasswordController,
                            textInputAction: TextInputAction.done,
                          ),
                        ],
                      )
                    : SizedBox.shrink(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      isSelected: isRemember,
                      onPressed: () {
                        setState(
                          () {
                            isRemember = !isRemember;
                          },
                        );
                      },
                      icon: !isRemember
                          ? Icon(
                              Icons.check_box_outline_blank,
                              color: AppColors.k_white_color,
                            )
                          : Icon(
                              Icons.check_box_outlined,
                              color: AppColors.k_white_color,
                            ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      AppLocalizations.of(context)!.rememberPassword,
                      style: TextStyle(
                        color: AppColors.k_white_color,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                BlocConsumer<AuthorizationBloc, AuthorizationState>(
                  bloc: _bloc,
                  listener: (context, state) {
                    print('state iss $state');
                    if (state is RegistrationLoaded) {
                      //   context.read<UserBloc>().updateUser(state.user);
                      print('success register');
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        Routes.home_screen,
                        (route) => false,
                      );
                    } else if (state is RegistrationErrorState) {
                      return AlertController.showMessage(
                        context: context,
                        title: 'Error',
                        content: state.error,
                      );
                    }
                    //Navigator.pushReplacementNamed(context, Routes.system);
                  },
                  builder: (context, state) {
                    final isLoading = state is RegistrationLoading;
                    return state is LoginLoadingState
                        ? const CircularProgressIndicator()
                        : CommonButton(
                            onPressed: () {
                              if (isLoading) return;
                              _bloc.registration(
                                  firstName: nameTextController.text,
                                  lastName: surnameTextController.text,
                                  phone: userFormatter.getUnmaskedText(),
                                  email: userEmailController.text,
                                  password: userPasswordController.text);
                            },
                            backgroundColor: AppColors.k_secondary_color,
                            radius: 8,
                            margin: EdgeInsets.only(
                                bottom: height * 1.72, top: height * 2.79),
                            child: Text(
                                AppLocalizations.of(context)!.registration),
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
                    Navigator.pushNamed(context, Routes.login);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.login,
                    style: TextStyle(
                      color: AppColors.k_white_color,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                // SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    nameTextController.dispose();
    userPasswordController.dispose();
  }
}
