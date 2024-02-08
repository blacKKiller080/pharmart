// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharma/core/api/api__endpoints.dart';
import 'package:pharma/core/business/bloc/category/category_bloc.dart';
import 'package:pharma/core/business/models/category_dto.dart';
import 'package:pharma/core/components/card_widget.dart';
import 'package:pharma/core/components/placeholders.dart';
import 'package:pharma/core/provider/authorization/authorization_provider.dart';
import 'package:pharma/ui/nav_bar/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/helper/navigateable.dart';
import '../../../core/provider/locale_provider.dart';
import '../../../core/routes/routes.dart';
import '../../../core/components/product_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/storage/local_storage.dart';

class HomeScreen extends StatefulWidget implements Navigateable {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

  @override
  String getName() {
    return Routes.home_screen;
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final Map<String, String> _popularCategory = {
    'Мед. техника': 'assets/images/png/main_page/technique.png',
    'Защитные средства': 'assets/images/png/main_page/means_of_protection.png',
    'Для малышей': 'assets/images/png/main_page/for_kids.png',
    'Витамины': 'assets/images/png/main_page/vitamin.png',
    'Оптика': 'assets/images/png/main_page/lenses.png',
    'Снэки': 'assets/images/png/main_page/snacks.png',
  };

  final Map<String, String> _components = {
    'Набор для профилактики': 'assets/images/png/main_page/component_1.png',
    'Для ваших питомцев': 'assets/images/png/main_page/component_2.png',
    'Средства реабилитации': 'assets/images/png/main_page/component_3.png',
  };
  final List<String> _pharmacy = [
    'assets/images/png/main_page/pharmacy1.png',
    'assets/images/png/main_page/pharmacy2.png',
  ];

  bool isCatalog = false;
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
    final locale =
        Localizations.of<AppLocalizations>(context, AppLocalizations);
    // final user = ModalRoute.of(context)!.settings.arguments as User;
    return ChangeNotifierProvider(
        create: (context) => LocaleProvider(),
        builder: (context, child) {
          final provider = Provider.of<LocaleProvider>(context);
          return Scaffold(
            resizeToAvoidBottomInset: true,
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
                        // resetToken();
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 11, vertical: 8.5),
                      margin: const EdgeInsets.only(right: 15),
                      decoration: BoxDecoration(
                        color: AppColors.k_secondary_color,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          !isCatalog
                              ? SvgPicture.asset(
                                  'assets/images/svg/catalog.svg')
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
              automaticallyImplyLeading: false,
              backgroundColor: AppColors.k_white_color,
            ),
            backgroundColor: AppColors.k_backgroung_color,
            body: isCatalog
                ? Container(
                    margin: EdgeInsets.only(
                        left: width * 3, right: width * 3, top: 24),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          BlocProvider(
                            create: (_) => CategoryBloc(
                                RepositoryProvider.of<AuthorizationProvider>(
                                    context))
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
                                    child:
                                        Center(child: Text('${state.message}')),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ),
                          // Wrap(
                          //   children: [
                          //     categoryField('assets/images/png/catalog4.png',
                          //         ' Ортопедия', context),
                          //     categoryField('assets/images/png/catalog5.png',
                          //         'Медицинские приборы', context),
                          //     categoryField('assets/images/png/catalog6.png',
                          //         'Для малышей', context),
                          //     categoryField('assets/images/png/catalog1.png',
                          //         'Лекарственные средства', context),
                          //     categoryField('assets/images/png/catalog2.png',
                          //         ' Витамины и БАД', context),
                          //     categoryField('assets/images/png/catalog3.png',
                          //         'Оптика', context),
                          //     categoryField('assets/images/png/catalog4.png',
                          //         ' Ортопедия', context),
                          //     categoryField('assets/images/png/catalog5.png',
                          //         'Медицинские приборы', context),
                          //     categoryField('assets/images/png/catalog6.png',
                          //         'Для малышей', context),
                          //     categoryField('assets/images/png/catalog1.png',
                          //         'Лекарственные средства', context),
                          //     categoryField('assets/images/png/catalog2.png',
                          //         ' Витамины и БАД', context),
                          //     categoryField('assets/images/png/catalog3.png',
                          //         'Оптика', context),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  )
                : Container(
                    margin: EdgeInsets.only(left: width * 3.72),
                    height: height * 100,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      controller: _scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: height * 24,
                            margin: EdgeInsets.only(
                              right: width * 3.72,
                              bottom: height * 5.15,
                              top: height * 2.57,
                            ),
                            padding: EdgeInsets.only(
                              left: width * 2.79,
                              right: width * 3,
                              bottom: height * 1.07,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: const LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 203, 250, 241),
                                  Color.fromRGBO(120, 232, 230, 1.0),
                                ],
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FittedBox(
                                      child: Text(
                                        //locale!.localeName,

                                        'Что такое\n Lorem Ipsum?',
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600,
                                          color:
                                              AppColors.k_text_tertiary_color,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: height * 1.5),
                                    ElevatedButton(
                                      onPressed: null,
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          AppColors.k_secondary_color,
                                        ),
                                      ),
                                      child: Text(
                                        AppLocalizations.of(context)!.goTo,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height * 11.2,
                                  width: width * 42,
                                  child: Image.asset(
                                    'assets/images/png/main_page/pharmakit_2.png',
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Text(
                            AppLocalizations.of(context)!.vipPharmacyProducts,
                            // token.toString(),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 73, top: 20),
                            height: height * 36,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              itemExtent: width * 54,
                              itemBuilder: (context, index) {
                                return ProductCard(
                                  isVip: true,
                                  // height: height * 31.55,
                                  // width: width * 55,
                                );
                              },
                            ),
                          ),

                          // // Container(
                          // //   margin: EdgeInsets.only(bottom: 77),
                          // // height: height * 38,
                          // Expanded(
                          //   child: ListView(
                          //     padding: EdgeInsets.zero,
                          //     physics: BouncingScrollPhysics(),
                          //     // shrinkWrap: true,
                          //     // itemExtent: width * 54,
                          //     scrollDirection: Axis.horizontal,
                          //     children: [
                          //       Row(
                          //         children: [
                          //           ProductCard(
                          //             isVip: true,
                          //           ),
                          //           ProductCard(
                          //             isVip: true,
                          //           ),
                          //           ProductCard(
                          //             isVip: true,
                          //           ),
                          //         ],
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          //  ),
                          Text(
                            AppLocalizations.of(context)!.popularCategories,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Container(
                            height: 172,
                            margin: const EdgeInsets.only(
                              top: 24,
                              bottom: 48,
                            ),
                            child: ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              children: [
                                ..._popularCategory.keys.map((key) {
                                  return CardWidget(
                                    width: 182,
                                    title: key,
                                    image: _popularCategory[key].toString(),
                                  );
                                })
                              ],
                            ),
                          ),
                          Text(
                            AppLocalizations.of(context)!.hotPharmacyProducts,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 73, top: 20),
                            height: height * 36,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              itemExtent: width * 54,
                              itemBuilder: (context, index) {
                                return ProductCard(
                                  isHot: true,
                                );
                              },
                            ),
                          ),
                          Text(
                            AppLocalizations.of(context)!.bestSeller,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 73, top: 20),
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
                          Text(
                            AppLocalizations.of(context)!.topPharmacyProducts,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 73, top: 20),
                            height: height * 36,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              itemExtent: width * 54,
                              itemBuilder: (context, index) {
                                return ProductCard(
                                  isTop: true,
                                );
                              },
                            ),
                          ),
                          Container(
                            height: 182,
                            margin: const EdgeInsets.only(
                              bottom: 48,
                            ),
                            child: ListView(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              children: [
                                ..._components.keys.map((key) {
                                  return CardWidget(
                                    width: 223,
                                    title: key,
                                    image: _components[key].toString(),
                                  );
                                })
                              ],
                            ),
                          ),
                          Text(
                            AppLocalizations.of(context)!.pharmacies,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              bottom: 40,
                              top: 24,
                            ),
                            height: 25,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(_pharmacy[0]),
                                    SizedBox(width: 25),
                                    Image.asset(_pharmacy[1]),
                                    SizedBox(width: 25),
                                  ],
                                );
                              },
                            ),
                          ),

                          Container(
                            height: height * 24,
                            margin: EdgeInsets.only(
                              right: width * 3.72,
                              bottom: height * 5.15,
                            ),
                            padding: EdgeInsets.only(
                              left: width * 1.86,
                              //right: width * 3,
                              bottom: height * 1.07,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: const LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 203, 250, 241),
                                  Color.fromRGBO(120, 232, 230, 1.0),
                                ],
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FittedBox(
                                      child: Text(
                                        'Что такое\n Lorem Ipsum?',
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600,
                                          color:
                                              AppColors.k_text_tertiary_color,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: height * 1.5),
                                    ElevatedButton(
                                      onPressed: null,
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          AppColors.k_secondary_color,
                                        ),
                                      ),
                                      child: Text(
                                        AppLocalizations.of(context)!.goTo,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Image.asset(
                                  'assets/images/png/main_page/pharmakit_1.png',
                                  height: height * 13.9,
                                  width: width * 46.9,
                                  alignment: Alignment.centerRight,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            bottomNavigationBar: const AppNavigationBar(current: 0),
          );
        });
  }
}

// SizedBox(
//               height: 200,
//               child: ListView(
//                 shrinkWrap: true,
//                 scrollDirection: Axis.horizontal,
//                 children: [
//                   ..._components.keys.map((key) {
//                     return CardWidget(
//                       title: key,
//                       image: _components[key].toString(),
//                     );
//                   })
//                 ],
//               ),
//             ),
