// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pharma/core/helper/navigateable.dart';
import 'package:pharma/core/routes/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/api/api__endpoints.dart';
import '../../../core/business/bloc/category/category_bloc.dart';
import '../../../core/business/models/category_dto.dart';
import '../../../core/components/common_button.dart';
import '../../../core/components/placeholders.dart';
import '../../../core/components/product_card.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/provider/authorization/authorization_provider.dart';
import '../../nav_bar/navigation_bar.dart';

class ProductScreen extends StatefulWidget implements Navigateable {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();

  @override
  String getName() {
    return Routes.product_screen;
  }
}

class _ProductScreenState extends State<ProductScreen> {
  bool isCatalog = false;
  bool isSpecifications = false;
  bool isDescription = false;
  bool isReview = false;
  bool isDelivery = false;

  int activePage = 0;

  late PageController _pageController;

  List<String> images = [
    'assets/images/png/product_test.png',
    'assets/images/png/test_product.png',
    'assets/images/png/product_test.png',
    'assets/images/png/product_test.png',
    'assets/images/png/product_test.png'
  ];

  static const List<String> list = <String>[
    'Сначала полезные',
    'Сначала',
    'Популярные',
    'Новинки',
    'Высокий рейтинг'
  ];
  String dropdownValue = '';

  final divider = Divider(
    color: AppColors.k_grey400_color,
    height: 0,
  );

  @override
  void initState() {
    super.initState();
    dropdownValue = list.first;
    _pageController = PageController(viewportFraction: 0.9, initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;
    final locale =
        Localizations.of<AppLocalizations>(context, AppLocalizations);
    return Scaffold(
      backgroundColor: AppColors.k_white_color,
      appBar: AppBar(
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/png/logo_blue.png'),
            ],
          ),
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
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
        elevation: 0.0,
        toolbarHeight: height * 7,
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
                right: width * 3.72,
                left: width * 3.72,
                bottom: 0,
                top: height * 3.1,
              ),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: height * 2.57),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: SvgPicture.asset(
                                'assets/images/svg/arrow_left.svg',
                                width: width * 5.58,
                                height: height * 2.57,
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: BoxConstraints(),
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.share_sharp,
                                    color: Color.fromRGBO(130, 130, 130, 1),
                                  ),
                                ),
                                SizedBox(width: width * 4.65),
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: BoxConstraints(),
                                  onPressed: () {},
                                  icon: SvgPicture.asset(
                                    'assets/images/svg/navbar/favourites.svg',
                                    width: width * 5.58,
                                    height: height * 2.57,
                                    color: Color.fromRGBO(130, 130, 130, 1),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                        child: PageView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: images.length,
                            pageSnapping: true,
                            controller: _pageController,
                            onPageChanged: (page) {
                              setState(() {
                                activePage = page;
                              });
                            },
                            itemBuilder: (context, pagePosition) {
                              return GestureDetector(
                                onTap: () {
                                  showGeneralDialog(
                                    context: context,
                                    // barrierDismissible: true,
                                    // barrierLabel:
                                    //     MaterialLocalizations.of(context)
                                    //         .modalBarrierDismissLabel,
                                    // barrierColor: Colors.black45,
                                    transitionDuration:
                                        const Duration(milliseconds: 200),
                                    pageBuilder: (BuildContext buildContext,
                                        Animation animation,
                                        Animation secondaryAnimation) {
                                      return StatefulBuilder(
                                        builder:
                                            (thisLowerContext, innerSetState) {
                                          return Container(
                                            height: height * 100,
                                            padding: EdgeInsets.only(
                                              right: width * 3.72,
                                              left: width * 3.72,
                                            ),
                                            color: Colors.white,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: height * 2.57),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: SvgPicture.asset(
                                                      'assets/images/svg/close.svg',
                                                      width: width * 5.58,
                                                      height: height * 2.57,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 300,
                                                  child: PageView.builder(
                                                      physics:
                                                          const BouncingScrollPhysics(),
                                                      itemCount: images.length,
                                                      pageSnapping: true,
                                                      controller:
                                                          _pageController,
                                                      onPageChanged: (page) {
                                                        innerSetState(() {
                                                          activePage = page;
                                                        });
                                                      },
                                                      itemBuilder: (context,
                                                          pagePosition) {
                                                        return Image.asset(
                                                          images[pagePosition],
                                                          fit: BoxFit.cover,
                                                        );
                                                      }),
                                                ),
                                                //Indicators
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: indicators(
                                                      images.length,
                                                      activePage),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                                child: Image.asset(
                                  images[pagePosition],
                                  fit: BoxFit.cover,
                                ),
                              );
                            }),
                      ),
                      SizedBox(height: height * 1.07),
                      //Indicators
                      Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: indicators(images.length, activePage),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                showGeneralDialog(
                                  context: context,
                                  // barrierDismissible: true,
                                  // barrierLabel:
                                  //     MaterialLocalizations.of(context)
                                  //         .modalBarrierDismissLabel,
                                  // barrierColor: Colors.black45,
                                  transitionDuration:
                                      const Duration(milliseconds: 200),
                                  pageBuilder: (BuildContext buildContext,
                                      Animation animation,
                                      Animation secondaryAnimation) {
                                    return StatefulBuilder(
                                      builder:
                                          (thisLowerContext, innerSetState) {
                                        return Container(
                                          height: height * 100,
                                          padding: EdgeInsets.only(
                                            right: width * 3.72,
                                            left: width * 3.72,
                                          ),
                                          color: Colors.white,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: height * 2.57),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: SvgPicture.asset(
                                                    'assets/images/svg/close.svg',
                                                    width: width * 5.58,
                                                    height: height * 2.57,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 300,
                                                child: PageView.builder(
                                                    physics:
                                                        const BouncingScrollPhysics(),
                                                    itemCount: images.length,
                                                    pageSnapping: true,
                                                    controller: _pageController,
                                                    onPageChanged: (page) {
                                                      innerSetState(() {
                                                        activePage = page;
                                                      });
                                                    },
                                                    itemBuilder: (context,
                                                        pagePosition) {
                                                      return Image.asset(
                                                        images[pagePosition],
                                                        fit: BoxFit.cover,
                                                      );
                                                    }),
                                              ),
                                              //Indicators
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: indicators(
                                                    images.length, activePage),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                              child: SvgPicture.asset(
                                'assets/images/svg/expand.svg',
                                width: width * 5.5,
                                height: height * 2.5,
                                // color: AppColors.k_main_color,
                              ),
                            ),
                          ),
                        ],
                      ),
                      //Name
                      Padding(
                        padding: EdgeInsets.only(
                            top: height * 2.57, bottom: height * 1.72),
                        child: Text(
                          'Аскорбиновая кислота в порошке без сахара',
                          style: TextStyle(
                            color: AppColors.k_black_color,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '500 ₸ ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColors.k_text_primary_color,
                            ),
                          ),
                          Text(
                            '600 ₸',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.k_grey3_color,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 1.72),
                      //TechSpecs
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.productCode,
                                style: TextStyle(
                                  color: AppColors.k_grey400_color,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                ' 13672986',
                                style: TextStyle(
                                  color: AppColors.k_text_primary_color,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 20,
                              ),
                              Text(
                                '3.5',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.k_text_primary_color,
                                ),
                              ),
                              SizedBox(width: 12),
                              Text(
                                // AppLocalizations.of(context)!.manyFeedbaks(180),
                                '',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.k_text_primary_color,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      //Specifications
                      textWithArrowIcon(
                        context,
                        AppLocalizations.of(context)!.specifications,
                        () {
                          setState(() {
                            isSpecifications = !isSpecifications;
                          });
                        },
                        topPadding: 5.8,
                        expression: isSpecifications,
                      ),
                      divider,
                      isSpecifications
                          ? Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: height * 2.15,
                                      top: height * 2.57),
                                  child: Row(
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .productForm,
                                        style: TextStyle(
                                          color: AppColors.k_grey400_color,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text('.' * 100, maxLines: 1),
                                      ),
                                      Text(
                                        'Порошок',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(bottom: height * 2.15),
                                  child: Row(
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .manufacturingCountry,
                                        style: TextStyle(
                                          color: AppColors.k_grey400_color,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text('.' * 100, maxLines: 1),
                                      ),
                                      Text(
                                        'Россия',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(bottom: height * 2.15),
                                  child: Row(
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .kindOfVitamins,
                                        style: TextStyle(
                                          color: AppColors.k_grey400_color,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text('.' * 100, maxLines: 1),
                                      ),
                                      Text(
                                        'Витамин C',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(bottom: height * 2.15),
                                  child: Row(
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.type,
                                        style: TextStyle(
                                          color: AppColors.k_grey400_color,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text('.' * 100, maxLines: 1),
                                      ),
                                      Text(
                                        'Витамины',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(bottom: height * 3.86),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      // Expanded(
                                      //   child: Container(
                                      //     padding: EdgeInsets.only(right: 1.0),
                                      //     child:
                                      Text(
                                        AppLocalizations.of(context)!.areOfUse,
                                        style: TextStyle(
                                          color: AppColors.k_grey400_color,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      //   ),
                                      // ),
                                      Expanded(
                                        child: Text(
                                          '.' * 100,
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Text(
                                        'Витамины',
                                        style: TextStyle(
                                          color: AppColors.k_text_primary_color,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                divider,
                              ],
                            )
                          : SizedBox.shrink(),
                      //Description
                      textWithArrowIcon(
                        context,
                        AppLocalizations.of(context)!.description,
                        () {
                          setState(() {
                            isDescription = !isDescription;
                          });
                        },
                        expression: isDescription,
                      ),
                      isDescription
                          ? Column(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(bottom: height * 2.57),
                                  child: Text(
                                    'Профилактика и лечение гипо- и авитаминоза витамина С. В качестве вспомогательного средства: гемморагический диатез, носовые, маточные, легочные и другие кровотечения, в том числе вызванные лучевой болезнью, передозировка антикоагулянтов, заболевания желудочно-кишечного тракта, сопровождающиеся нарушением всасывания витамина С, травмы. Состояния, сопровождающиеся повышенной потребностью в витамине С: повышенные физические и умственные нагрузки, период беременности и грудного вскармливания, период выздоровления после длительных заболеваний.',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall,
                                  ),
                                ),
                                divider,
                              ],
                            )
                          : divider,
                      //Review
                      textWithArrowIcon(
                        context,
                        AppLocalizations.of(context)!.feedbacks,
                        () {
                          setState(() {
                            isReview = !isReview;
                          });
                        },
                        expression: isReview,
                      ),
                      isReview
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                      size: 20,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                      size: 20,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                      size: 20,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Color.fromARGB(255, 228, 228, 228),
                                      size: 20,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Color.fromARGB(255, 228, 228, 228),
                                      size: 20,
                                    ),
                                    SizedBox(width: 12),
                                    Text(
                                      '3.5',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.k_main_color,
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Text(
                                      // AppLocalizations.of(context)!
                                      //     .manyFeedbaks(855),
                                      '',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.k_text_primary_color,
                                      ),
                                    ),
                                  ],
                                ),
                                CommonButton(
                                  onPressed: () {},
                                  backgroundColor: AppColors.k_main_color,
                                  radius: 8,
                                  margin: EdgeInsets.only(
                                      bottom: height * 2.57,
                                      top: height * 1.72),
                                  child: Text(AppLocalizations.of(context)!
                                      .writeAreview),
                                ),
                                Text(
                                  AppLocalizations.of(context)!.customerPhotos,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.k_grey400_color,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    bottom: height * 2.57,
                                    top: height * 1.72,
                                  ),
                                  height: 60,
                                  //height * 6.437,
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 8,
                                    itemExtent: 70,
                                    //width * 13.953,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.only(right: 10.0),
                                        child: Image.asset(
                                          images[1],
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.sortBy,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.k_text_primary_color,
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * 55,
                                      height: height * 4.29,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              icon: const Icon(Icons
                                                  .keyboard_arrow_down_rounded),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displaySmall,
                                              onChanged: (String? value) {
                                                setState(() {
                                                  dropdownValue = value!;
                                                });
                                              },
                                              items: list.map<
                                                      DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                              isExpanded: true,
                                              dropdownColor:
                                                  Colors.grey.shade50,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    top: height * 2.57,
                                    bottom: height * 2.57,
                                  ),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor:
                                            AppColors.k_white_color,
                                        radius: height * 3.76,
                                        backgroundImage: AssetImage(
                                          "assets/images/png/avatar.png",
                                        ),
                                      ),
                                      SizedBox(width: width * 5.58),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Марина Исмаилова',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors
                                                  .k_text_primary_color,
                                            ),
                                          ),
                                          Text(
                                            '3 марта 2022, 19:37',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.k_grey300_color,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: Color.fromRGBO(
                                                    9, 158, 191, 1),
                                                size: 20,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Color.fromRGBO(
                                                    9, 158, 191, 1),
                                                size: 20,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Color.fromRGBO(
                                                    9, 158, 191, 1),
                                                size: 20,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Color.fromARGB(
                                                    255, 228, 228, 228),
                                                size: 20,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Color.fromARGB(
                                                    255, 228, 228, 228),
                                                size: 20,
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Text(
                                  AppLocalizations.of(context)!.advantages,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.k_text_primary_color,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Повседневная практика показывает, что сствующая теория представляет собой интересный эксперимент проверки анализа существующих паттернов поведения. Сложно сказать, почему явные признаки победы институционализации обнародованы. Сложно сказать, почему активно развивающиеся страны третьего мира, которые представляют собой яркий пример континентально-европейского типа политической культуры, будут ассоциативно распределены по отраслям.',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.k_grey400_color,
                                    height: 1.35,
                                  ),
                                ),
                                SizedBox(
                                  height: height * 2.6,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.disadvantages,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.k_text_primary_color,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Повседневная практика показывает, что ствующая теория представляет собой интересный эксперимент проверки анализа существующих паттернов поведения. Сложно сказать, почему явные признаки победы институционализации обнародованы. ',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.k_grey400_color,
                                    height: 1.35,
                                  ),
                                ),
                                SizedBox(
                                  height: height * 2.6,
                                ),
                                Text(
                                  '3 из 3 человек посчитали отзыв полезным',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.k_text_primary_color,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: height * 1.72,
                                    bottom: height * 3.22,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Отзыв был полезен?',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.k_grey3_color,
                                        ),
                                      ),
                                      CommonButton(
                                        onPressed: () {},
                                        backgroundColor: AppColors.k_main_color,
                                        radius: 5,
                                        margin: EdgeInsets.only(
                                          left: width * 5.58,
                                          right: 10,
                                        ),
                                        contentPaddingVertical: 0.85,
                                        containerWidth: width * 11.86,
                                        child: Text('Да'),
                                      ),
                                      CommonButton(
                                        onPressed: () {},
                                        backgroundColor:
                                            AppColors.k_white_color,
                                        borderColor: true,
                                        foregroundColor: AppColors.k_main_color,
                                        radius: 5,
                                        contentPaddingVertical: 0.85,
                                        containerWidth: width * 13.72,
                                        child: Text('Нет'),
                                      ),
                                    ],
                                  ),
                                ),
                                divider,
                              ],
                            )
                          : divider,
                      //Delivery
                      textWithArrowIcon(
                        context,
                        AppLocalizations.of(context)!.providers,
                        () {
                          setState(() {
                            isDelivery = !isDelivery;
                          });
                        },
                        expression: isDelivery,
                      ),
                      divider,
                      isDelivery
                          ? Column(
                              children: [
                                companyCard(context),
                                companyCard(context),
                                companyCard(context),
                                companyCard(context),
                                SizedBox(height: height * 2.72),
                                divider,
                              ],
                            )
                          : SizedBox.shrink(),
                      //Recomendacion
                      Padding(
                        padding: EdgeInsets.only(
                            top: height * 5.15, bottom: height * 2.25),
                        child: Text(
                          AppLocalizations.of(context)!.recamendacion,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      SizedBox(
                        //margin: EdgeInsets.only(bottom: height * 5.8, top: 20),
                        height: height * 36,
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemExtent: width * 54,
                          itemBuilder: (context, index) {
                            return ProductCard();
                          },
                        ),
                      ),
                      CommonButton(
                        onPressed: () {},
                        backgroundColor: AppColors.k_secondary_color,
                        radius: 8,
                        margin: EdgeInsets.only(
                            bottom: height * 2.57, top: height * 5.8),
                        child: Text(AppLocalizations.of(context)!.addToBasket),
                      ),
                    ],
                  ),
                ],
              ),
            ),
      bottomNavigationBar: const AppNavigationBar(current: 0),
    );
  }
}

List<Widget> indicators(imagesLength, currentIndex) {
  return List<Widget>.generate(imagesLength, (index) {
    return Container(
      margin: EdgeInsets.only(left: 3, top: 4),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color:
            currentIndex == index ? AppColors.k_main_color : AppColors.neutral3,
        shape: BoxShape.circle,
      ),
    );
  });
}
