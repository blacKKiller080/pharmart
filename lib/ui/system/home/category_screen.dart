// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pharma/core/components/common_button.dart';
import 'package:pharma/core/components/product_card.dart';
import 'package:pharma/core/helper/navigateable.dart';
import 'package:pharma/core/routes/routes.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import '../../../core/api/api__endpoints.dart';
import '../../../core/business/bloc/category/category_bloc.dart';
import '../../../core/business/models/category_dto.dart';
import '../../../core/components/placeholders.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/provider/authorization/authorization_provider.dart';
import '../../../l10n/l10n.dart';
import '../../nav_bar/navigation_bar.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CategoryScreen extends StatefulWidget implements Navigateable {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();

  @override
  String getName() {
    return Routes.category_screen;
  }
}

class _CategoryScreenState extends State<CategoryScreen> {
  bool isCatalog = false;

  static const List<String> list = <String>[
    'Цена по возрастанию',
    'Цена по убыванию',
    'Популярные',
    'Новинки',
    'Высокий рейтинг',
    'По размеру скидки',
  ];
  String dropdownValue = list.first;

  SfRangeValues _values = SfRangeValues(4000.0, 80000.0);

  bool saleStuff = false;
  bool overPricedStuff = false;

  late int selectedIndex = 0;
  void setIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  late ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose(); // dispose the controller
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 350), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;
    final title = ModalRoute.of(context)!.settings.arguments as String;
    final locale =
        Localizations.of<AppLocalizations>(context, AppLocalizations);
    return Scaffold(
      backgroundColor: AppColors.k_white_color,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
                onTap: _scrollToTop,
                child: Image.asset('assets/images/png/logo_blue.png')),
          ],
        ),
        actions: <Widget>[
          Center(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isCatalog = !isCatalog;
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 11, vertical: 8.5),
                margin: const EdgeInsets.only(right: 15),
                decoration: BoxDecoration(
                  color: AppColors.k_secondary_color,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    !isCatalog
                        ? SvgPicture.asset('assets/images/svg/catalog.svg')
                        : Icon(
                            Icons.close,
                            size: 19.5,
                          ),
                    SizedBox(width: 7),
                    Text(
                      AppLocalizations.of(context)!.catalog,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.k_white_color,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
        elevation: 0.0,
        // toolbarHeight: height * 5,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.k_white_color,
      ),
      body: isCatalog
          ? Container(
              margin:
                  EdgeInsets.only(left: width * 3, right: width * 3, top: 24),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    BlocProvider(
                      create: (_) => CategoryBloc(
                          RepositoryProvider.of<AuthorizationProvider>(context))
                        ..add(GetCategoryEvent(locale!.localeName)),
                      child: BlocBuilder<CategoryBloc, CategoryState>(
                        builder: (context, state) {
                          if (state is CategoryStateInitial) {
                            return buildLoading();
                          } else if (state is CategoryStateLoading) {
                            return buildLoading();
                          } else if (state is CategoryStateLoaded) {
                            List<CategoryDto>? category_dto =
                                state.category_dto;
                            return Wrap(
                              children: List.generate(
                                category_dto!.length,
                                (index) => categoryField(
                                    (ApiEndpoints.host +
                                        category_dto[index].image!),
                                    category_dto[index].name,
                                    context),
                              ),
                            );
                          } else if (state is CategoryStateError) {
                            return Container(
                              child: Center(child: Text('${state.message}')),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Container(
              height: height * 100,
              margin: EdgeInsets.only(
                right: width * 2.72,
                left: width * 2.72,
                bottom: 0,
                //top: height * 2.6,
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.zero,
                controller: _scrollController,
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 24),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: AppColors.k_black_color,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: height * 2.57,
                        left: width * 1,
                        right: width * 1,
                        bottom: height * 1.5,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(
                            'assets/images/svg/filter.svg',
                            height: height * 2.5,
                            width: width * 5.813,
                          ),
                          SizedBox(
                            width: 200, //width * 45.11,
                            height: height * 4.29,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: Color(0xFFE3E5E6),
                                ),
                                color: AppColors.k_white_color,
                              ),
                              child: ButtonTheme(
                                alignedDropdown: true,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: dropdownValue,
                                    menuMaxHeight: 400,
                                    borderRadius: BorderRadius.circular(5),
                                    icon: const Icon(
                                        Icons.keyboard_arrow_down_rounded),
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.k_black_color,
                                    ),
                                    onChanged: (String? value) {
                                      setState(() {
                                        dropdownValue = value!;
                                      });
                                    },
                                    items: list.map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    isExpanded: true,
                                    dropdownColor: Colors.grey.shade50,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    StickyHeader(
                      controller: _scrollController,
                      header: Container(
                        color: AppColors.k_white_color,
                        child: SingleChildScrollView(
                          padding: EdgeInsets.zero,
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              BlocProvider(
                                create: (_) => CategoryBloc(RepositoryProvider
                                    .of<AuthorizationProvider>(context))
                                  ..add(GetCategoryEvent(
                                      L10n.locales.first.toString())),
                                child: BlocBuilder<CategoryBloc, CategoryState>(
                                  builder: (context, state) {
                                    if (state is CategoryStateInitial) {
                                      return buildLoading();
                                    } else if (state is CategoryStateLoading) {
                                      return buildLoading();
                                    } else if (state is CategoryStateLoaded) {
                                      List<CategoryDto>? category_dto =
                                          state.category_dto;
                                      return CommonButton(
                                        onPressed: () {
                                          showModalBottomSheet<void>(
                                            context: context,
                                            isScrollControlled: true,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(40),
                                                topRight: Radius.circular(40),
                                              ),
                                            ),
                                            backgroundColor: Colors.white,
                                            builder: (context) {
                                              return StatefulBuilder(builder:
                                                  (thisLowerContext,
                                                      innerSetState) {
                                                return Container(
                                                  width: width * 100,
                                                  height: height * 85,
                                                  padding: EdgeInsets.only(
                                                    right: width * 3.72,
                                                    left: width * 3.72,
                                                    bottom: height * 2.15,
                                                    top: height * 2.79,
                                                  ),
                                                  child: ListView(
                                                    padding: EdgeInsets.zero,
                                                    physics:
                                                        BouncingScrollPhysics(),
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .transparent,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    40),
                                                            topRight:
                                                                Radius.circular(
                                                                    40),
                                                          ),
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            //Filter
                                                            Center(
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              4),
                                                                  color: Colors
                                                                      .grey
                                                                      .shade400,
                                                                ),
                                                                height: 4,
                                                                width: 44,
                                                                margin:
                                                                    EdgeInsets
                                                                        .only(
                                                                  bottom:
                                                                      height *
                                                                          2.5,
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets.only(
                                                                  bottom:
                                                                      height *
                                                                          3.64),
                                                              child: Stack(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                      AppLocalizations.of(
                                                                              context)!
                                                                          .filters,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            22,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        color: AppColors
                                                                            .k_black_color,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerRight,
                                                                    child:
                                                                        TextButton(
                                                                      style: TextButton
                                                                          .styleFrom(
                                                                        padding:
                                                                            EdgeInsets.zero,
                                                                        minimumSize: Size(
                                                                            0,
                                                                            0),
                                                                        tapTargetSize:
                                                                            MaterialTapTargetSize.shrinkWrap,
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        AppLocalizations.of(context)!
                                                                            .cancel,
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              AppColors.k_main_color,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontSize:
                                                                              14,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            //Categories
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  AppLocalizations.of(
                                                                          context)!
                                                                      .categories,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: AppColors
                                                                        .k_black_color,
                                                                  ),
                                                                ),
                                                                TextButton(
                                                                  style: TextButton
                                                                      .styleFrom(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .zero,
                                                                    minimumSize:
                                                                        Size(0,
                                                                            0),
                                                                    tapTargetSize:
                                                                        MaterialTapTargetSize
                                                                            .shrinkWrap,
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: Text(
                                                                    AppLocalizations.of(
                                                                            context)!
                                                                        .all,
                                                                    style:
                                                                        TextStyle(
                                                                      color: AppColors
                                                                          .k_main_color,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          14,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                            ListView.builder(
                                                                padding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                physics:
                                                                    NeverScrollableScrollPhysics(),
                                                                shrinkWrap:
                                                                    true,
                                                                itemCount:
                                                                    category_dto!
                                                                        .length,
                                                                itemBuilder:
                                                                    (context,
                                                                        index) {
                                                                  return Column(
                                                                    children: [
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          innerSetState(
                                                                              () {
                                                                            setIndex(index);
                                                                          });
                                                                        },
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              EdgeInsets.only(
                                                                            top:
                                                                                height * 1.72,
                                                                            bottom: category_dto[selectedIndex].subCategory!.length == 0
                                                                                ? 0
                                                                                : selectedIndex == index
                                                                                    ? height * 1.07
                                                                                    : 0,
                                                                          ),
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Flexible(
                                                                                child: ConstrainedBox(
                                                                                  constraints: BoxConstraints(),
                                                                                  child: Text(
                                                                                    ('${category_dto[index].name}'),
                                                                                    style: Theme.of(context).textTheme.displayMedium,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              selectedIndex != index ? Flexible(flex: 0, child: Icon(Icons.keyboard_arrow_down_sharp)) : Icon(Icons.keyboard_arrow_up_sharp),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      selectedIndex ==
                                                                              index
                                                                          ? Wrap(
                                                                              children: List.generate(
                                                                                category_dto[selectedIndex].subCategory!.length,
                                                                                (subIndex) => filterContainer('${category_dto[selectedIndex].subCategory![subIndex].name}'),
                                                                              ),
                                                                            )
                                                                          : SizedBox
                                                                              .shrink(),
                                                                    ],
                                                                  );
                                                                }),

                                                            Divider(
                                                              color:
                                                                  Colors.grey,
                                                              height:
                                                                  height * 6,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Expanded(
                                                                  child: Text(
                                                                    AppLocalizations.of(
                                                                            context)!
                                                                        .discountedItems,
                                                                    maxLines: 2,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .displayMedium,
                                                                  ),
                                                                ),
                                                                CupertinoSwitch(
                                                                  activeColor:
                                                                      AppColors
                                                                          .k_secondary_color,
                                                                  thumbColor:
                                                                      AppColors
                                                                          .k_white_color,
                                                                  trackColor:
                                                                      Colors
                                                                          .black12,
                                                                  value:
                                                                      overPricedStuff,
                                                                  onChanged:
                                                                      ((value) {
                                                                    innerSetState(
                                                                        () {
                                                                      overPricedStuff =
                                                                          value;
                                                                    });
                                                                  }),
                                                                ),
                                                              ],
                                                            ),
                                                            Divider(
                                                              color:
                                                                  Colors.grey,
                                                              height:
                                                                  height * 6,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Expanded(
                                                                  child: Text(
                                                                    AppLocalizations.of(
                                                                            context)!
                                                                        .itemsWithDiscount,
                                                                    maxLines: 2,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .displayMedium,
                                                                  ),
                                                                ),
                                                                CupertinoSwitch(
                                                                  activeColor:
                                                                      AppColors
                                                                          .k_secondary_color,
                                                                  thumbColor:
                                                                      AppColors
                                                                          .k_white_color,
                                                                  trackColor:
                                                                      Colors
                                                                          .black12,
                                                                  value:
                                                                      saleStuff,
                                                                  onChanged:
                                                                      ((value) {
                                                                    innerSetState(
                                                                        () {
                                                                      saleStuff =
                                                                          value;
                                                                    });
                                                                  }),
                                                                ),
                                                              ],
                                                            ),
                                                            Divider(
                                                              color:
                                                                  Colors.grey,
                                                              height:
                                                                  height * 6,
                                                            ),
                                                            Column(
                                                              children: [
                                                                //Price
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsets.only(
                                                                          bottom:
                                                                              height * 2.58),
                                                                      child:
                                                                          Text(
                                                                        AppLocalizations.of(context)!
                                                                            .price,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          color:
                                                                              AppColors.k_black_color,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SfRangeSliderTheme(
                                                                      data:
                                                                          SfRangeSliderThemeData(
                                                                        overlayRadius:
                                                                            0,
                                                                      ),
                                                                      child:
                                                                          SfRangeSlider(
                                                                        min:
                                                                            0.0,
                                                                        max:
                                                                            100000.0,
                                                                        values:
                                                                            _values,
                                                                        numberFormat:
                                                                            NumberFormat('#'),
                                                                        inactiveColor: Colors
                                                                            .grey
                                                                            .shade200,
                                                                        activeColor:
                                                                            AppColors.k_secondary_color,
                                                                        onChanged:
                                                                            (dynamic
                                                                                values) {
                                                                          innerSetState(
                                                                              () {
                                                                            _values =
                                                                                values as SfRangeValues;
                                                                          });
                                                                        },
                                                                      ),
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Container(
                                                                          width:
                                                                              width * 34.9,
                                                                          height:
                                                                              height * 4.3,
                                                                          margin:
                                                                              EdgeInsets.only(
                                                                            top:
                                                                                height * 2.58,
                                                                          ),
                                                                          padding:
                                                                              EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                width * 2.8,
                                                                            vertical:
                                                                                height * 1,
                                                                          ),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5),
                                                                            border:
                                                                                Border.all(
                                                                              color: Color(0xFFE3E5E6),
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              Text(
                                                                            '${AppLocalizations.of(context)!.from} ${_values.start.toInt()}',
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 15,
                                                                              fontWeight: FontWeight.w400,
                                                                              color: AppColors.k_black_color,
                                                                              overflow: TextOverflow.ellipsis,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          width:
                                                                              width * 34.9,
                                                                          height:
                                                                              height * 4.3,
                                                                          margin:
                                                                              EdgeInsets.only(
                                                                            top:
                                                                                height * 2.58,
                                                                          ),
                                                                          padding:
                                                                              EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                width * 2.8,
                                                                            vertical:
                                                                                height * 1,
                                                                          ),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5),
                                                                            border:
                                                                                Border.all(
                                                                              color: Color(0xFFE3E5E6),
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              Text(
                                                                            '${AppLocalizations.of(context)!.to} ${_values.end.toInt()}',
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 15,
                                                                              fontWeight: FontWeight.w400,
                                                                              color: AppColors.k_black_color,
                                                                              overflow: TextOverflow.ellipsis,
                                                                            ),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                                Divider(
                                                                  color: Colors
                                                                      .grey,
                                                                  height:
                                                                      height *
                                                                          6,
                                                                ),
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsets.only(
                                                                          bottom:
                                                                              height * 2.58),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            AppLocalizations.of(context)!.pharmacies,
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.w500,
                                                                              color: AppColors.k_black_color,
                                                                            ),
                                                                          ),
                                                                          TextButton(
                                                                            style:
                                                                                TextButton.styleFrom(
                                                                              padding: EdgeInsets.zero,
                                                                              minimumSize: Size(0, 0),
                                                                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                                            ),
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child:
                                                                                Text(
                                                                              AppLocalizations.of(context)!.all,
                                                                              style: TextStyle(
                                                                                color: AppColors.k_main_color,
                                                                                fontWeight: FontWeight.w500,
                                                                                fontSize: 14,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      child:
                                                                          Wrap(
                                                                        alignment:
                                                                            WrapAlignment.start,
                                                                        crossAxisAlignment:
                                                                            WrapCrossAlignment.center,
                                                                        children: [
                                                                          filterContainer(
                                                                              'Europharma'),
                                                                          filterContainer(
                                                                              'Доктор Хелп'),
                                                                          filterContainer(
                                                                              'ATABAY Pharm'),
                                                                          filterContainer(
                                                                              'Доктор Хелп'),
                                                                          filterContainer(
                                                                              'Europharma'),
                                                                          filterContainer(
                                                                              'ATABAY Pharm'),
                                                                          filterContainer(
                                                                              'ATABAY Pharm'),
                                                                          filterContainer(
                                                                              'Доктор Хелп'),
                                                                          filterContainer(
                                                                              'Europharma'),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Divider(
                                                                  color: Colors
                                                                      .grey,
                                                                  height:
                                                                      height *
                                                                          6,
                                                                ),
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsets.only(
                                                                          bottom:
                                                                              height * 2.58),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            AppLocalizations.of(context)!.manufacturingCountry,
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.w500,
                                                                              color: AppColors.k_black_color,
                                                                            ),
                                                                          ),
                                                                          TextButton(
                                                                            style:
                                                                                TextButton.styleFrom(
                                                                              padding: EdgeInsets.zero,
                                                                              minimumSize: Size(0, 0),
                                                                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                                            ),
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child:
                                                                                Text(
                                                                              AppLocalizations.of(context)!.all,
                                                                              style: TextStyle(
                                                                                color: AppColors.k_main_color,
                                                                                fontWeight: FontWeight.w500,
                                                                                fontSize: 14,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      child:
                                                                          Wrap(
                                                                        alignment:
                                                                            WrapAlignment.start,
                                                                        crossAxisAlignment:
                                                                            WrapCrossAlignment.center,
                                                                        children: [
                                                                          filterContainer(
                                                                              'Казахстан'),
                                                                          filterContainer(
                                                                              'Россия'),
                                                                          filterContainer(
                                                                              'Германия'),
                                                                          filterContainer(
                                                                              'США'),
                                                                          filterContainer(
                                                                              'Россия'),
                                                                          filterContainer(
                                                                              'Германия'),
                                                                          filterContainer(
                                                                              'Казахстан'),
                                                                          filterContainer(
                                                                              'США'),
                                                                          filterContainer(
                                                                              'Казахстан'),
                                                                          filterContainer(
                                                                              'Россия'),
                                                                          filterContainer(
                                                                              'США'),
                                                                          filterContainer(
                                                                              'Германия'),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                            CommonButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              backgroundColor:
                                                                  AppColors
                                                                      .k_secondary_color,
                                                              radius: 8,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                top: height *
                                                                    4.3,
                                                              ),
                                                              child: Text(
                                                                AppLocalizations.of(
                                                                        context)!
                                                                    .close,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: AppColors
                                                                      .k_white_color,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              });
                                            },
                                          );
                                        },
                                        contentPaddingVertical: 1.07,
                                        contentPaddingHorizontal: 2.79,
                                        backgroundColor:
                                            AppColors.k_white_color,
                                        hasIconMiniButton: true,
                                        radius: 5,
                                        margin: EdgeInsets.only(
                                          bottom: height * 1.72,
                                          left: width * 1,
                                          top: height * 1,
                                          right: width * 1,
                                        ),
                                        shadow: true,
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .category,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.k_black_color,
                                          ),
                                        ),
                                      );
                                    } else if (state is CategoryStateError) {
                                      return Container(
                                        child: Center(
                                            child: Text('${state.message}')),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),
                              ),
                              CommonButton(
                                onPressed: () {
                                  showModalBottomSheet<void>(
                                    context: context,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(40),
                                        topRight: Radius.circular(40),
                                      ),
                                    ),
                                    backgroundColor: Colors.white,
                                    builder: (BuildContext context) {
                                      return StatefulBuilder(
                                        builder:
                                            (thisLowerContext, innerSetState) {
                                          return Container(
                                            width: width * 100,
                                            padding: EdgeInsets.only(
                                              right: width * 3.72,
                                              left: width * 3.72,
                                              bottom: height * 2.15,
                                              top: height * 1.6,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Center(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                      color:
                                                          Colors.grey.shade400,
                                                    ),
                                                    height: 4,
                                                    width: 44,
                                                    margin: EdgeInsets.only(
                                                      bottom: height * 2.5,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: height * 3.64),
                                                  child: Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .filters,
                                                          style: TextStyle(
                                                            fontSize: 22,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: AppColors
                                                                .k_black_color,
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: TextButton(
                                                          style: TextButton
                                                              .styleFrom(
                                                            padding:
                                                                EdgeInsets.zero,
                                                            minimumSize:
                                                                Size(0, 0),
                                                            tapTargetSize:
                                                                MaterialTapTargetSize
                                                                    .shrinkWrap,
                                                          ),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .cancel,
                                                            style: TextStyle(
                                                              color: AppColors
                                                                  .k_main_color,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: height * 2.58),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .price,
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: AppColors
                                                              .k_black_color,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SfRangeSliderTheme(
                                                      data:
                                                          SfRangeSliderThemeData(
                                                        overlayRadius: 0,
                                                      ),
                                                      child: SfRangeSlider(
                                                        min: 0.0,
                                                        max: 100000.0,
                                                        values: _values,
                                                        numberFormat:
                                                            NumberFormat('#'),
                                                        inactiveColor: Colors
                                                            .grey.shade200,
                                                        activeColor: AppColors
                                                            .k_secondary_color,
                                                        onChanged:
                                                            (dynamic values) {
                                                          innerSetState(() {
                                                            _values = values
                                                                as SfRangeValues;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          width: width * 34.9,
                                                          height: height * 4.3,
                                                          margin:
                                                              EdgeInsets.only(
                                                            top: height * 2.58,
                                                          ),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            horizontal:
                                                                width * 2.8,
                                                            vertical:
                                                                height * 1,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            border: Border.all(
                                                              color: Color(
                                                                  0xFFE3E5E6),
                                                            ),
                                                          ),
                                                          child: Text(
                                                            '${AppLocalizations.of(context)!.from} ${_values.start.toInt()}',
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: AppColors
                                                                  .k_black_color,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: width * 34.9,
                                                          height: height * 4.3,
                                                          margin:
                                                              EdgeInsets.only(
                                                            top: height * 2.58,
                                                          ),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            horizontal:
                                                                width * 2.8,
                                                            vertical:
                                                                height * 1,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            border: Border.all(
                                                              color: Color(
                                                                  0xFFE3E5E6),
                                                            ),
                                                          ),
                                                          child: Text(
                                                            '${AppLocalizations.of(context)!.to} ${_values.end.toInt()}',
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: AppColors
                                                                  .k_black_color,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                CommonButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  backgroundColor: AppColors
                                                      .k_secondary_color,
                                                  radius: 8,
                                                  margin: EdgeInsets.only(
                                                    top: height * 4.3,
                                                  ),
                                                  child: Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .close,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: AppColors
                                                          .k_white_color,
                                                    ),
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
                                contentPaddingVertical: 1.07,
                                contentPaddingHorizontal: 2.79,
                                backgroundColor: AppColors.k_white_color,
                                hasIconMiniButton: true,
                                radius: 5,
                                margin: EdgeInsets.only(
                                  bottom: height * 1.72,
                                  left: width * 1,
                                  top: height * 1,
                                  right: width * 1,
                                ),
                                shadow: true,
                                child: Text(
                                  AppLocalizations.of(context)!.price,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.k_black_color,
                                  ),
                                ),
                              ),
                              CommonButton(
                                onPressed: () {
                                  showBottomFilterSheet(
                                    context,
                                    AppLocalizations.of(context)!.pharmacies,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Wrap(
                                          children: [
                                            filterContainer('Europharma'),
                                            filterContainer('Доктор Хелп'),
                                            filterContainer('ATABAY Pharm'),
                                            filterContainer('Доктор Хелп'),
                                            filterContainer('Europharma'),
                                            filterContainer('ATABAY Pharm'),
                                            filterContainer('ATABAY Pharm'),
                                            filterContainer('Доктор Хелп'),
                                            filterContainer('Europharma'),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                contentPaddingVertical: 1.07,
                                contentPaddingHorizontal: 2.79,
                                backgroundColor: AppColors.k_white_color,
                                hasIconMiniButton: true,
                                radius: 5,
                                margin: EdgeInsets.only(
                                  bottom: height * 1.72,
                                  left: width * 1,
                                  top: height * 1,
                                  right: width * 1,
                                ),
                                shadow: true,
                                child: Text(
                                  AppLocalizations.of(context)!.pharmacies,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.k_black_color,
                                  ),
                                ),
                              ),
                              CommonButton(
                                onPressed: () {
                                  showBottomFilterSheet(
                                    context,
                                    AppLocalizations.of(context)!
                                        .manufacturingCountry,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Wrap(
                                          children: [
                                            filterContainer('Казахстан'),
                                            filterContainer('Россия'),
                                            filterContainer('Германия'),
                                            filterContainer('США'),
                                            filterContainer('Россия'),
                                            filterContainer('Германия'),
                                            filterContainer('Казахстан'),
                                            filterContainer('США'),
                                            filterContainer('Казахстан'),
                                            filterContainer('Россия'),
                                            filterContainer('США'),
                                            filterContainer('Германия'),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                },
                                contentPaddingVertical: 1.07,
                                contentPaddingHorizontal: 2.79,
                                backgroundColor: AppColors.k_white_color,
                                hasIconMiniButton: true,
                                radius: 5,
                                margin: EdgeInsets.only(
                                  bottom: height * 1.72,
                                  left: width * 1,
                                  right: width * 1,
                                  top: height * 1,
                                ),
                                shadow: true,
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .manufacturingCountry,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.k_black_color,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      content: ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 7,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              ProductCard(
                                height: height * 31.55,
                                width: width * 45.11,
                                isCatalog: true,
                                margin: EdgeInsets.only(
                                  left: width * 1,
                                  right: width * 1.16,
                                  bottom: height * 1.287,
                                  top: height * .86,
                                ),
                              ),
                              ProductCard(
                                height: height * 31.55,
                                width: width * 45.11,
                                isCatalog: true,
                                margin: EdgeInsets.only(
                                  bottom: height * 1.287,
                                  top: height * .86,
                                  left: width * 1.16,
                                  right: width * 1,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),

                    // Container(
                    //   height: height * 8.5,
                    //   //537.9,
                    //   //width: width * 80,
                    //   child: ListView.builder(
                    //       padding: EdgeInsets.zero,
                    //       physics: BouncingScrollPhysics(),
                    //       //shrinkWrap: true,
                    //       //itemExtent: width * 54,
                    //       scrollDirection: Axis.horizontal,
                    //       itemCount: 7,
                    //       itemBuilder: (context, index) {
                    //         return CommonButton(
                    //           onPressed: () {},
                    //           contentPaddingVertical: 1.07,
                    //           contentPaddingHorizontal: 2.79,
                    //           backgroundColor: AppColors.k_white_color,
                    //           hasIconMiniButton: true,
                    //           radius: 5,
                    //           margin: EdgeInsets.only(
                    //             bottom: height * 1.72,
                    //             top: height * 2.5,
                    //             left: width * 1,
                    //             right: width * 1,
                    //           ),
                    //           child: Text(
                    //             'Цена',
                    //             style: TextStyle(
                    //               fontSize: 16,
                    //               fontWeight: FontWeight.w500,
                    //               color: AppColors.k_black_color,
                    //             ),
                    //           ),
                    //         );
                    //       }),
                    // ),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: const AppNavigationBar(current: 0),
    );
  }
}




