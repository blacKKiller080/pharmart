// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors, unused_local_variable

import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class CommonButton extends StatelessWidget {
  Widget child;
  Function? onPressed;
  Widget? icon;

  EdgeInsets? margin;
  final Color backgroundColor;
  final Color foregroundColor;
  bool success;
  bool disabled;
  bool borderColor;
  bool leftScreenButton;
  bool rightScreenButton;
  double contentPaddingVertical;
  double fontSize;
  bool hasIconMiniButton;
  bool hasDownIcon;
  double? radius;
  double? containerWidth;
  double? containerHeight;

  bool bigText;
  double contentPaddingHorizontal;
  bool shadow;
  FontWeight fontWeight;

  CommonButton({
    required this.child,
    this.onPressed,
    this.radius,
    this.success = false,
    this.disabled = false,
    this.borderColor = false,
    this.rightScreenButton = false,
    this.leftScreenButton = false,
    this.backgroundColor = AppColors.k_main_color,
    this.foregroundColor = AppColors.k_white_color,
    this.margin,
    this.contentPaddingVertical = 1.72,
    this.fontSize = 16,
    this.hasIconMiniButton = false,
    this.hasDownIcon = false,
    this.icon,
    this.contentPaddingHorizontal = 0,
    this.bigText = true,
    this.shadow = false,
    this.fontWeight = FontWeight.w600,
    this.containerWidth,
    this.containerHeight,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;
    return Container(
      margin: margin,
      decoration: shadow
          ? BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2.5,
                  blurRadius: 7,
                  offset: Offset(0, 0), // changes position of shadow
                ),
              ],
            )
          : BoxDecoration(),
      child: TextButton(
        onPressed: () {
          if (!disabled) {
            onPressed?.call();
          } else if (success) {
            success = true;
            onPressed?.call();
          }
        },
        style: ButtonStyle(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          minimumSize: MaterialStateProperty.all(Size(0, 0)),
          backgroundColor: MaterialStateProperty.all(getBackgroundColor()),
          foregroundColor: MaterialStateProperty.all(getForegroundColor()),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              side: borderColor
                  ? BorderSide(color: foregroundColor)
                  : BorderSide(color: backgroundColor, strokeAlign: 3),
              borderRadius: radius == null
                  ? BorderRadius.only(
                      topLeft: leftScreenButton
                          ? Radius.circular(0)
                          : Radius.circular(5),
                      bottomLeft: leftScreenButton
                          ? Radius.circular(0)
                          : Radius.circular(5),
                      topRight: rightScreenButton
                          ? Radius.circular(0)
                          : Radius.circular(5),
                      bottomRight: rightScreenButton
                          ? Radius.circular(0)
                          : Radius.circular(5),
                    )
                  : BorderRadius.all(
                      Radius.circular(radius!),
                    ),
            ),
          ),
          textStyle: MaterialStateProperty.all(
            TextStyle(
              fontWeight: fontWeight,
              fontSize: fontSize,
            ),
          ),
          padding: MaterialStateProperty.all(
            EdgeInsets.only(
              top: height * contentPaddingVertical,
              bottom: height * contentPaddingVertical,
              right: width * contentPaddingHorizontal,
              left: width * contentPaddingHorizontal,
            ),
          ),
        ),
        child: !hasIconMiniButton
            ? hasDownIcon
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      child,
                      SizedBox(child: icon),
                    ],
                  )
                : SizedBox(
                    width: containerWidth ?? double.infinity,
                    height: containerHeight,
                    child: Center(child: child),
                  )
            : Container(
                padding:
                    EdgeInsets.symmetric(horizontal: contentPaddingHorizontal),
                // constraints: const BoxConstraints(),
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Row(
                    children: <Widget>[
                      child,
                      SizedBox(width: width * 1),
                      SizedBox(child: icon),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Color getBackgroundColor() {
    Color color;
    if (disabled) {
      if (borderColor) {
        color = AppColors.k_main_color;
      } else {
        color = AppColors.k_white_color;
      }
    } else if (success) {
      color = AppColors.k_white_color;
    } else {
      color = backgroundColor;
    }
    return color;
  }

  Color getForegroundColor() {
    Color color;
    if (disabled) {
      color = AppColors.k_main_color;
    } else if (success) {
      color = AppColors.k_main_color;
    } else {
      color = foregroundColor;
    }
    return color;
  }
}
