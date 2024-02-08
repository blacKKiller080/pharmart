// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pharma/core/helper/navigateable.dart';
import 'package:pharma/core/routes/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../core/components/product_card.dart';
import '../../../core/constants/app_colors.dart';
import '../../nav_bar/navigation_bar.dart';
import 'custom_search_delegate.dart';

class SearchScreen extends StatefulWidget implements Navigateable {
  const SearchScreen();

  @override
  State<SearchScreen> createState() => _SearchScreenState();

  @override
  String getName() {
    return Routes.search_screen;
  }
}

class _SearchScreenState extends State<SearchScreen> {
  List<String> searchTerms = [
    "Apple",
    "Apricot",
    "Banana",
    "Blackberry",
    "Coconut",
    "Date",
    "Fig",
    "Gooseberry",
    "Grapes",
    "Lemon",
    "Litchi",
    "Mango",
    "Orange",
    "Papaya",
    "Peach",
    "Pineapple",
    "Pomegranate",
    "Starfruit"
  ];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;
    final query = ModalRoute.of(context)!.settings.arguments;
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toString().toLowerCase())) {
        matchQuery.add(fruit);
      } else if (query.toString() == '') {
        matchQuery.add(fruit);
      } else if (query == null) {
        matchQuery.add(fruit);
      }
    }
    return Scaffold(
      bottomNavigationBar: AppNavigationBar(current: 1),
      backgroundColor: AppColors.k_white_color,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.search,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: AppColors.k_white_color,
      ),
      body: SafeArea(
        child: Container(
          height: height * 100,
          margin: EdgeInsets.only(
            right: width * 2.72,
            left: width * 2.72,
            top: height * 1,
          ),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  showSearch(
                      context: context,
                      query: query == null ? '' : query.toString(),
                      // delegate to customize the search bar
                      delegate: CustomSearchDelegate());
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 16),
                  padding:
                      EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.k_grey300_color),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        query.toString() == ''
                            ? AppLocalizations.of(context)!.search
                            : query == null
                                ? AppLocalizations.of(context)!.search
                                : query.toString(),
                      ),
                      Icon(Icons.search),
                    ],
                  ),
                ),
              ),
              matchQuery.isNotEmpty
                  ? Flexible(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.zero,
                        child: Wrap(
                          children: List.generate(
                            matchQuery.length,
                            (index) => ProductCard(
                              height: height * 31.55,
                              width: width * 45.11,
                              isCatalog: true,
                              text: matchQuery.elementAt(index),
                              margin: EdgeInsets.only(
                                left: width * 1,
                                right: width * 1.16,
                                bottom: height * 1.287,
                                top: height * .86,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Text(
                      AppLocalizations.of(context)!.searchNotFound,
                      style: TextStyle(
                        color: AppColors.k_text_primary_color,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
