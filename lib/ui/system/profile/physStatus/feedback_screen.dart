// ignore_for_file: prefer_const_constructors
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharma/core/helper/navigateable.dart';
import 'package:pharma/core/routes/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/components/common_button.dart';
import '../../../../core/components/common_input.dart';
import '../../../../core/components/placeholders.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../nav_bar/navigation_bar.dart';

class FeedBackScreen extends StatefulWidget implements Navigateable {
  const FeedBackScreen({super.key});

  @override
  State<FeedBackScreen> createState() => _FeedBackScreenState();

  @override
  String getName() {
    return Routes.feedback_screen;
  }
}

class _FeedBackScreenState extends State<FeedBackScreen> {
  bool waitFeedBack = true;
  bool myFeedBack = false;
  var prosController = TextEditingController();
  var consController = TextEditingController();

  double rating = 1;

  XFile? image;
  final ImagePicker picker = ImagePicker();

  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
    });
  }

  void myPictureDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text(AppLocalizations.of(context)!.chooseMediaUploadType),
            content: Container(
              height: MediaQuery.of(context).size.height / 8,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        getImage(ImageSource.gallery);
                      });
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
                      setState(() {
                        getImage(ImageSource.camera);
                      });
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
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: const AppNavigationBar(current: 4),
      backgroundColor: AppColors.k_white_color,
      appBar: appBar(context, AppLocalizations.of(context)!.myFeedbacks),
      body: Container(
        height: height * 100,
        margin: EdgeInsets.only(
          right: width * 2.72,
          left: width * 2.72,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CommonButton(
                    onPressed: () {
                      setState(() {
                        waitFeedBack = true;
                        myFeedBack = false;
                      });
                    },
                    contentPaddingVertical: 1.07,
                    contentPaddingHorizontal: 2.79,
                    backgroundColor: AppColors.k_white_color,
                    hasIconMiniButton: true,
                    radius: 5,
                    margin: EdgeInsets.only(
                      top: 10,
                      left: width * 1,
                      right: width * 1,
                      bottom: height * 2.57,
                    ),
                    fontWeight: FontWeight.w500,
                    foregroundColor: AppColors.k_black_color,
                    shadow: true,
                    disabled: waitFeedBack,
                    child: Text(
                      AppLocalizations.of(context)!.awaitFeedback,
                    ),
                  ),
                  CommonButton(
                    onPressed: () {
                      setState(() {
                        waitFeedBack = false;
                        myFeedBack = true;
                      });
                    },
                    contentPaddingVertical: 1.07,
                    contentPaddingHorizontal: 2.79,
                    backgroundColor: AppColors.k_white_color,
                    hasIconMiniButton: true,
                    radius: 5,
                    margin: EdgeInsets.only(
                      top: 10,
                      left: width * 1,
                      right: width * 1,
                      bottom: height * 2.57,
                    ),
                    fontWeight: FontWeight.w500,
                    foregroundColor: AppColors.k_black_color,
                    shadow: true,
                    disabled: myFeedBack,
                    child: Text(
                      AppLocalizations.of(context)!.myFeedbacks,
                    ),
                  ),
                ],
              ),
            ),
            waitFeedBack
                ? Flexible(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        return feedBackCard();
                      },
                    ),
                  )
                : const SizedBox.shrink(),
            myFeedBack
                ? Flexible(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            feedBackCard(),
                            personCard(),
                          ],
                        );
                      },
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  Widget feedBackCard() {
    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;
    return GestureDetector(
      onTap: () {
        showModalBottomSheet<void>(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          isScrollControlled: true,
          backgroundColor: Colors.white,
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (thisLowerContext, innerSetState) {
                return Container(
                  width: width * 100,
                  height: height * 85,
                  padding: EdgeInsets.only(
                    top: height * 2.79,
                    right: width * 2.72,
                    left: width * 2.72,
                  ),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    physics: BouncingScrollPhysics(),
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.grey.shade400,
                                ),
                                height: 4,
                                width: 44,
                                margin: EdgeInsets.only(
                                  bottom: height * 2.25,
                                ),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: EdgeInsets.only(bottom: height * 1.57),
                                child: Text(
                                  AppLocalizations.of(context)!.leaveFeedback,
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.k_black_color,
                                  ),
                                ),
                              ),
                            ),
                            feedBackCard(),
                            SizedBox(height: height * 1.65),
                            Center(
                              child: Text(
                                AppLocalizations.of(context)!.rateProduct,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.k_grey3_color,
                                ),
                              ),
                            ),
                            Center(
                              child: RatingBar.builder(
                                initialRating: rating,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                glow: false,
                                unratedColor: AppColors.k_grey_divider_color,
                                itemPadding: EdgeInsets.only(right: 6, top: 18),
                                itemBuilder: (context, _) => SvgPicture.asset(
                                  'assets/images/svg/star.svg',
                                  // width: width * 5.58,
                                  // height: height * 2.57,
                                  color: Colors.yellow,
                                ),
                                onRatingUpdate: (value) {
                                  innerSetState(() {
                                    rating = value;
                                  });
                                },
                              ),
                            ),
                            CommonInput(
                              AppLocalizations.of(context)!.advantages,
                              margin: EdgeInsets.only(
                                  bottom: height * 1.72, top: height * 4.4),
                              type: InputType.TEXT,
                              controller: prosController,
                              customColor: AppColors.k_grey3_color,
                              borderColor: AppColors.k_grey_divider_color,
                              textColor: AppColors.k_text_primary_color,
                              maxLines: 6,
                            ),
                            CommonInput(
                              AppLocalizations.of(context)!.disadvantages,
                              type: InputType.TEXT,
                              controller: consController,
                              customColor: AppColors.k_grey3_color,
                              borderColor: AppColors.k_grey_divider_color,
                              textColor: AppColors.k_text_primary_color,
                              maxLines: 3,
                            ),
                            CommonButton(
                              margin: EdgeInsets.only(
                                  bottom: height * 1.72, top: height * 2.79),
                              onPressed: () {
                                innerSetState(
                                  () {
                                    myPictureDialog();
                                  },
                                );
                              },
                              backgroundColor: AppColors.k_white_color,
                              foregroundColor: AppColors.k_main_color,
                              hasDownIcon: true,
                              icon: Icon(Icons.download),
                              radius: 8,
                              borderColor: true,
                              contentPaddingVertical: 1.82,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              child: Text(
                                AppLocalizations.of(context)!.uploadPhoto,
                              ),
                            ),
                            image != null
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.file(
                                        //to show image, you type like this.
                                        File(image!.path),
                                        fit: BoxFit.cover,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 300,
                                      ),
                                    ),
                                  )
                                : Text(
                                    "No Image",
                                    style: TextStyle(fontSize: 20),
                                  ),
                            Text(
                              AppLocalizations.of(context)!
                                  .dragPhotosInfeedback,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.k_grey300_color,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            CommonButton(
                              margin: EdgeInsets.only(
                                bottom: height * 3.65,
                                top: height * 2.72,
                              ),
                              backgroundColor: AppColors.k_secondary_color,
                              radius: 8,
                              child: Text(
                                AppLocalizations.of(context)!.send,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          bottom: height * 1.6,
          top: height * 1.4,
          left: width * 3,
          // right: width * 3.5,
        ),
        margin: EdgeInsets.only(
          bottom: height * 1.14,
          top: height * 1,
          left: width * 1,
          right: width * 1,
        ),
        decoration: BoxDecoration(
          color: AppColors.k_white_color,
          border: Border.all(color: AppColors.k_grey_divider_color),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/png/feedBack_test.png',
                  height: height * 8.59,
                  width: width * 22.8,
                  // color: AppColors.k_main_color,
                ),
                SizedBox(width: width * 4.41),
                SizedBox(
                  height: height * 8.59,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: width * 60,
                        child: Text(
                          'Витамин С (Аскорби́новая кислота́)',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.k_text_primary_color,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 3,
                        ),
                      ),
                      Text(
                        '1 973 ₸',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.k_text_primary_color,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 2.4),
            Row(
              children: [
                Image.asset(
                  'assets/images/png/main_page/pharmacy1.png',
                  // height: height * 8.59,
                  // width: width * 22.8,
                  // color: AppColors.k_main_color,
                ),
                SizedBox(width: width * 6.28),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 20,
                    ),
                    Text(
                      '3.9',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.k_grey300_color,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10),
                Text(
                  // AppLocalizations.of(context)!.manyFeedbaks(90),
                  '',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.k_text_secondary_color,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget personCard() {
    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        bottom: height * 1.6,
        top: height * 1.4,
        left: width * 3,
        // right: width * 3.5,
      ),
      margin: EdgeInsets.only(
        bottom: height * 1.14,
        top: height * 1,
        left: width * 1,
        right: width * 1,
      ),
      decoration: BoxDecoration(
        color: AppColors.k_white_color,
        border: Border.all(color: AppColors.k_grey_divider_color),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(14), // Border width
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.k_grey_divider_color,
                ),
                child: SvgPicture.asset(
                  'assets/images/svg/add_photo.svg',
                  color: AppColors.k_white_color,
                ),
              ),
              SizedBox(width: width * 4.41),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width * 60,
                    child: Text(
                      'Бексултан Амиров',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.k_text_primary_color,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  SizedBox(height: height * 1.3),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 20,
                      ),
                      SizedBox(width: 5),
                      Text(
                        '3.9',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.k_grey300_color,
                        ),
                      ),
                      SizedBox(width: 30),
                      Text(
                        '25.08.2022',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.k_grey300_color,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: height * 2.4),
          Text(
            'Lorem Ipsum - текст-"рыба", часто используемый в печати и вэб-дизайне. Lorem Ipsum является стандартной "рыбой" для текстов на латинице с начала XVI века. ',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.k_text_secondary_color,
            ),
          ),
          SizedBox(height: height * 1.72),
          Text(
            'На рассмотрении',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.k_main_color,
            ),
          ),
        ],
      ),
    );
  }
}
