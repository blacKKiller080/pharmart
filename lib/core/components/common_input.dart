// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, prefer_const_constructors, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pharma/core/constants/app_colors.dart';

class CommonInput extends StatefulWidget {
  final String text;
  final InputType type;
  final bool isLabelTextOn;
  final TextEditingController? controller;
  final List<TextInputFormatter>? formatters;
  final void Function(String value)? onChanged;
  final int? maxLines;
  final bool editable;
  final bool isSearchPrefix;
  final bool isSearchSuffix;
  final bool isSuffixIcon;
  final IconData prefixIcon;
  final Widget? suffixIcon;
  final String? initialValue;
  final Color customColor;
  final Color fillColor;
  final Color borderColor;
  final Color textColor;
  final Color oscuredIconColor;
  final void Function(String value)? onSubmitted;
  final EdgeInsets? margin;
  double contentPaddingVertical;
  double contentPaddingHorizontal;
  double borderRadius;
  FontWeight fontWeight;
  bool isCenterTitle;
  bool validator;
  TextInputAction? textInputAction;
  bool leftScreenButton;
  bool rightScreenButton;

  CommonInput(
    this.text, {
    this.type = InputType.TEXT,
    this.controller,
    this.isLabelTextOn = false,
    this.validator = false,
    this.formatters,
    this.onChanged,
    this.maxLines,
    this.initialValue,
    this.editable = true,
    this.customColor = Colors.white,
    this.fillColor = Colors.transparent,
    this.borderColor = Colors.white,
    this.textColor = AppColors.k_white_color,
    this.onSubmitted,
    this.margin,
    this.isSearchPrefix = false,
    this.isSearchSuffix = false,
    this.isSuffixIcon = false,
    this.suffixIcon,
    this.prefixIcon = Icons.search_rounded,
    this.contentPaddingVertical = 1.93,
    this.contentPaddingHorizontal = 4.65,
    this.borderRadius = 5,
    this.fontWeight = FontWeight.w400,
    this.isCenterTitle = false,
    this.oscuredIconColor = AppColors.k_grey300_color,
    this.textInputAction,
    this.rightScreenButton = false,
    this.leftScreenButton = false,
  });

  @override
  _CommonInputState createState() => _CommonInputState();
}

class _CommonInputState extends State<CommonInput> {
  bool _isTextNotObscured = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.isLabelTextOn
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    widget.text,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: widget.fontWeight,
                      color: widget.customColor == null
                          ? AppColors.k_white_color
                          : widget.customColor,
                    ),
                  ),
                )
              : Container(),
          TextFormField(
            // autofocus: true,
            onFieldSubmitted: widget.onSubmitted,
            textCapitalization: TextCapitalization.characters,
            onChanged: widget.onChanged,
            validator: widget.validator ? _textValidator : null,
            controller: widget.controller,
            style: TextStyle(
              fontSize: 14,
              fontWeight: widget.fontWeight,
              color: widget.textColor,
            ),
            textAlign:
                widget.isCenterTitle ? TextAlign.center : TextAlign.start,
            maxLines: widget.maxLines ?? 1,
            inputFormatters: _getInputFormatters(),
            keyboardType: _getKeyBoardType(widget.type),
            obscuringCharacter: "*",
            obscureText: isPasswordInput() && !_isTextNotObscured,
            initialValue: widget.initialValue,
            enabled: widget.editable,
            textInputAction: widget.textInputAction,
            decoration: InputDecoration(
              fillColor: widget.fillColor,
              filled: true,
              suffixIconConstraints: BoxConstraints(),
              suffixIconColor: AppColors.k_border_red_color,
              suffixIcon: !widget.isSearchSuffix
                  ? isPasswordInput()
                      ? Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height /
                                100 *
                                widget.contentPaddingVertical,
                            right: MediaQuery.of(context).size.width /
                                100 *
                                widget.contentPaddingHorizontal,
                            bottom: MediaQuery.of(context).size.height /
                                100 *
                                widget.contentPaddingVertical,
                          ), // add padding to adjust icon
                          child: GestureDetector(
                            onTap: () {
                              _isTextNotObscured = !_isTextNotObscured;
                              setState(() {});
                            },
                            child: Icon(
                              _isTextNotObscured
                                  ? FontAwesomeIcons.eye
                                  : FontAwesomeIcons.eyeSlash,
                              color: widget.oscuredIconColor,
                              // size: MediaQuery.of(context).size.width /
                              //     100 *
                              //     5.128,
                            ),
                          ),
                        )
                      : widget.isSuffixIcon
                          ? Padding(
                              padding: EdgeInsets.only(
                                  right: 10), // add padding to adjust icon
                              child: widget.suffixIcon,
                            )
                          : null
                  : Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(Icons.search, size: 30),
                    ),
              prefixIcon: widget.isSearchPrefix
                  ? Padding(
                      padding:
                          EdgeInsets.only(top: 0), // add padding to adjust icon
                      child: Icon(
                        widget.prefixIcon,
                        size: 24,
                        color: Color.fromARGB(255, 166, 166, 166),
                      ),
                    )
                  : null,
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height /
                    100 *
                    widget.contentPaddingVertical,
                horizontal: MediaQuery.of(context).size.width /
                    100 *
                    widget.contentPaddingHorizontal,
              ),
              hintText: widget.text,
              hintStyle: TextStyle(
                fontSize: 14,
                fontWeight: widget.fontWeight,
                color: widget.customColor,
              ),
              alignLabelWithHint: false,
              enabledBorder: widget.isSearchSuffix
                  ? UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.k_grey300_color),
                    )
                  : OutlineInputBorder(
                      borderSide: BorderSide(
                        color: widget.borderColor != null
                            ? widget.borderColor
                            : widget.customColor,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: widget.leftScreenButton
                            ? Radius.circular(0)
                            : Radius.circular(widget.borderRadius),
                        bottomLeft: widget.leftScreenButton
                            ? Radius.circular(0)
                            : Radius.circular(widget.borderRadius),
                        topRight: widget.rightScreenButton
                            ? Radius.circular(0)
                            : Radius.circular(widget.borderRadius),
                        bottomRight: widget.rightScreenButton
                            ? Radius.circular(0)
                            : Radius.circular(widget.borderRadius),
                      ),
                    ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                ),
                gapPadding: 0,
                borderRadius:
                    BorderRadius.all(Radius.circular(widget.borderRadius)),
              ),
              errorStyle: TextStyle(height: 0),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                ),
                gapPadding: 0,
                borderRadius:
                    BorderRadius.all(Radius.circular(widget.borderRadius)),
              ),
              focusedBorder: widget.isSearchSuffix
                  ? UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.k_grey300_color),
                    )
                  : OutlineInputBorder(
                      borderSide: BorderSide(
                        color: widget.borderColor != null
                            ? widget.borderColor
                            : widget.customColor,
                      ),
                      borderRadius: BorderRadius.all(
                          Radius.circular(widget.borderRadius)),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  String? _textValidator(String? value) {
    if (value?.isEmpty ?? true) {
      return '';
    }
    return null;
  }

  List<TextInputFormatter> _getInputFormatters() {
    return widget.formatters ?? [];
  }

  bool isPasswordInput() {
    return widget.type == InputType.PASSWORD;
  }

  TextInputType _getKeyBoardType(InputType type) {
    TextInputType textType;

    switch (type) {
      case InputType.EMAIL:
        textType = TextInputType.emailAddress;
        break;
      case InputType.NUMBER:
        textType = TextInputType.number;
        break;
      case InputType.NUMBER_WITH_OPTIONS:
        textType = TextInputType.numberWithOptions(decimal: true, signed: true);
        break;
      case InputType.PHONE:
        textType = TextInputType.number;
        break;
      default:
        textType = TextInputType.text;
    }

    return textType;
  }
}

enum InputType {
  TEXT,
  PASSWORD,
  EMAIL,
  NUMBER,
  NUMBER_WITH_OPTIONS,
  PHONE,
  TIME
}
