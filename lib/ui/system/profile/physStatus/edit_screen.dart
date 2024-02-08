// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharma/core/helper/navigateable.dart';
import 'package:pharma/core/routes/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/business/models/user.dart';
import '../../../../core/components/common_button.dart';
import '../../../../core/components/common_input.dart';
import '../../../../core/components/placeholders.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../nav_bar/navigation_bar.dart';

class EditScreen extends StatefulWidget implements Navigateable {
  User? user;
  EditScreen({super.key, this.user});

  @override
  State<EditScreen> createState() => _EditScreenState();

  @override
  String getName() {
    return Routes.edit_screen;
  }
}

class _EditScreenState extends State<EditScreen> {
  var nameController = TextEditingController();
  var surnameController = TextEditingController();
  var emailController = TextEditingController();
  var streetController = TextEditingController();
  var apartmentController = TextEditingController();

  MaskedTextController phoneController =
      MaskedTextController(mask: '0 (000) 000-00-00');

  static const List<String> cityList = <String>[
    'Алматы',
    'Астана',
    'Тараз',
  ];

  static const List<String> regionList = <String>[
    'Жамбылская область',
    'Алматинская область',
    'Жамбылская область',
  ];
  String? cityValue;
  String? regionValue;

  RadioTypes? character = RadioTypes.physStatus;

  XFile? image;

  final ImagePicker picker = ImagePicker();

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
    });
  }

  @override
  void initState() {
    //  user = ModalRoute.of(context)!.settings.arguments as User;
    nameController.text = widget.user!.fname!;
    surnameController.text = widget.user!.lname!;
    emailController.text = widget.user!.email!;
    phoneController.text = widget.user!.phone!;
    super.initState();
  }

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
                    GestureDetector(
                      onTap: () {
                        myAlert();
                      },
                      child: Row(
                        children: [
                          image != null
                              ? ClipOval(
                                  child: Image.file(
                                    //to show image, you type like this.
                                    File(image!.path),
                                    fit: BoxFit.fill,
                                    width: 70,
                                    height: 70,
                                  ),
                                )
                              : Container(
                                  padding: EdgeInsets.all(19), // Border width
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: AppColors.k_main_color),
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/images/svg/add_photo.svg',
                                    // width: width * 5.58,
                                    // height: height * 2.57,
                                  ),
                                ),
                          SizedBox(width: width * 2.33),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size(0, 0),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: () {
                              myAlert();
                            },
                            child: Text(
                              AppLocalizations.of(context)!.uploadPhoto,
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
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.status,
                          style: TextStyle(
                            color: AppColors.k_text_primary_color,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: height * 1.5),
                        Row(
                          children: [
                            Radio<RadioTypes>(
                              value: RadioTypes.physStatus,
                              groupValue: character,
                              activeColor: AppColors.k_main_color,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              visualDensity: const VisualDensity(
                                horizontal: VisualDensity.minimumDensity,
                                vertical: VisualDensity.minimumDensity,
                              ),
                              onChanged: (RadioTypes? value) {
                                setState(() {
                                  character = value;
                                });
                              },
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              width: width * 27,
                              child: Wrap(
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.physStatus,
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
                  ],
                ),
                CommonInput(
                  //widget.user!.fname == ''
                  AppLocalizations.of(context)!.fName,
                  // : '${widget.user!.fname}',
                  margin: EdgeInsets.only(
                      bottom: height * 1.72, top: height * 2.57),
                  type: InputType.TEXT,
                  customColor: AppColors.k_grey300_color,
                  borderColor: AppColors.k_border_grey_color,
                  textColor: AppColors.k_text_primary_color,
                  controller: nameController,
                  contentPaddingVertical: 1.72,
                  textInputAction: TextInputAction.next,
                ),
                CommonInput(
                  AppLocalizations.of(context)!.lName,
                  margin: EdgeInsets.only(bottom: height * 1.72),
                  type: InputType.TEXT,
                  customColor: AppColors.k_grey300_color,
                  borderColor: AppColors.k_border_grey_color,
                  textColor: AppColors.k_text_primary_color,
                  controller: surnameController,
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
                  // formatters: [formatter],
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
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, height * 1.72),
                  child: SizedBox(
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
                              AppLocalizations.of(context)!.selectCity,
                              style: TextStyle(
                                color: AppColors.k_grey3_color,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            icon: const Icon(Icons.keyboard_arrow_down_rounded),
                            style: const TextStyle(
                              color: AppColors.k_text_primary_color,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                cityValue = value!;
                              });
                            },
                            items: cityList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            isExpanded: true,
                            dropdownColor: AppColors.k_white_color,
                          ),
                        ),
                      ),
                    ),
                  ),
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
                    AppLocalizations.of(context)!.editPersInfo,
                  ),
                ),
                CommonButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.change_pass_screen);
                  },
                  // backgroundColor: AppColors.neutral3,
                  foregroundColor: AppColors.k_main_color,
                  backgroundColor: AppColors.k_white_color,
                  radius: 8,
                  margin: EdgeInsets.only(bottom: height * 2.57),
                  child: Text(
                    AppLocalizations.of(context)!.changePassword,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.address,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Padding(
                  padding:
                      EdgeInsets.fromLTRB(0, height * 1.72, 0, height * 1.72),
                  child: SizedBox(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.k_white_color,
                        border: Border.all(
                          color: AppColors.neutral3,
                        ),
                      ),
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: regionValue,
                            menuMaxHeight: 400,
                            hint: Text(
                              AppLocalizations.of(context)!.region,
                              style: TextStyle(
                                color: AppColors.k_grey3_color,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            icon: const Icon(Icons.keyboard_arrow_down_rounded),
                            style: const TextStyle(
                              color: AppColors.k_text_primary_color,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                regionValue = value!;
                              });
                            },
                            items: regionList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            isExpanded: true,
                            dropdownColor: AppColors.k_white_color,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, height * 1.72),
                  child: SizedBox(
                    height: height * 5.47,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.k_white_color,
                        border: Border.all(
                          color: AppColors.neutral3,
                        ),
                      ),
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: cityValue,
                            menuMaxHeight: 400,
                            hint: Text(
                              AppLocalizations.of(context)!.city,
                              style: TextStyle(
                                color: AppColors.k_grey3_color,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            icon: const Icon(Icons.keyboard_arrow_down_rounded),
                            style: const TextStyle(
                              color: AppColors.k_text_primary_color,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                cityValue = value!;
                              });
                            },
                            items: cityList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            isExpanded: true,
                            dropdownColor: AppColors.k_white_color,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                CommonInput(
                  AppLocalizations.of(context)!.streetAndHouseNumber,
                  margin: EdgeInsets.only(bottom: height * 1.72),
                  type: InputType.TEXT,
                  customColor: AppColors.k_grey300_color,
                  borderColor: AppColors.k_border_grey_color,
                  textColor: AppColors.k_text_primary_color,
                  controller: streetController,
                  contentPaddingVertical: 1.72,
                  textInputAction: TextInputAction.next,
                ),
                CommonInput(
                  AppLocalizations.of(context)!.apartment,
                  margin: EdgeInsets.only(bottom: height * 1.72),
                  type: InputType.TEXT,
                  customColor: AppColors.k_grey300_color,
                  borderColor: AppColors.k_border_grey_color,
                  textColor: AppColors.k_text_primary_color,
                  controller: apartmentController,
                  contentPaddingVertical: 1.72,
                  textInputAction: TextInputAction.done,
                ),
                CommonButton(
                  onPressed: () {},
                  // backgroundColor: AppColors.neutral3,
                  foregroundColor: AppColors.k_main_color,
                  backgroundColor: AppColors.k_white_color,
                  radius: 8,
                  margin: EdgeInsets.only(bottom: height * 2.57),
                  child: Text(
                    AppLocalizations.of(context)!.changeAddress,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.myCard,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Wrap(
                  direction: Axis.horizontal,
                  //runSpacing: height * .86,
                  spacing: width * 2.35,
                  children: [
                    credirCard(false, false),
                    credirCard(true, true),
                    credirCard(false, true),
                    credirCard(false, false),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.add_card_screen);
                      },
                      child: Container(
                        width: width * 45.10,
                        height: 110,
                        padding: EdgeInsets.only(
                          // left: width * 3.26,
                          // right: width * 3.26,
                          bottom: height * 1.93,
                          top: height * 2.7,
                        ),
                        margin: EdgeInsets.only(top: height * 1.72),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.k_grey300_color,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/images/svg/plus.svg',
                              // width: width * 5.58,
                              // height: height * 2.57,
                            ),
                            SizedBox(height: height * 1.18),
                            Text(
                              AppLocalizations.of(context)!.addCard,
                              style: TextStyle(
                                color: AppColors.k_black_color,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 2.57),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget credirCard(bool isMain, bool isVisa) {
    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;
    return GestureDetector(
      onTap: (() {
        Navigator.pushNamed(context, Routes.edit_card_screen);
      }),
      child: Container(
        width: width * 45.10,
        height: 110,
        padding: EdgeInsets.only(
          left: width * 3.26,
          right: width * 3.26,
          bottom: height * 1.72,
          top: height * 1.5,
        ),
        margin: EdgeInsets.only(top: height * 1.72),
        decoration: BoxDecoration(
          border: Border.all(
            color: isMain ? AppColors.k_main_color : AppColors.k_grey300_color,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            isMain
                ? Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/svg/tick_circle.svg',
                        // width: width * 5.58,
                        // height: height * 2.57,
                        color: AppColors.k_secondary_color,
                      ),
                      SizedBox(width: width * 2.32),
                      Text(
                        AppLocalizations.of(context)!.mainCard,
                        style: TextStyle(
                          color: AppColors.k_secondary_color,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  )
                : SizedBox.shrink(),
            SizedBox(height: isMain ? height * 1.72 : height * 3.22),
            Text(
              '12345******5959',
              style: TextStyle(
                color: isMain
                    ? AppColors.k_text_tertiary_color
                    : AppColors.k_text_secondary_color,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: height * 1.72),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '08/24',
                  style: TextStyle(
                    color: isMain
                        ? AppColors.k_main_color
                        : AppColors.unselectedBottomIconColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                isVisa
                    ? SvgPicture.asset(
                        'assets/images/svg/visa.svg',
                        // width: width * 5.58,
                        // height: height * 2.57,
                        // color: isMain
                        //     ? AppColors.k_main_color
                        //     : AppColors.k_grey400_color,
                      )
                    : SvgPicture.asset(
                        'assets/images/svg/mastercard.svg',
                        // width: width * 5.58,
                        // height: height * 2.57,

                        // color: isMain
                        //     ? AppColors.k_main_color
                        //     : AppColors.k_grey400_color,
                      ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text(AppLocalizations.of(context)!.chooseMediaUploadType),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        Text(AppLocalizations.of(context)!.fromGallery),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera),
                        Text(AppLocalizations.of(context)!.fromCamera),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    nameController.dispose();
    surnameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    streetController.dispose();
    apartmentController.dispose();
    super.dispose();
  }
}
