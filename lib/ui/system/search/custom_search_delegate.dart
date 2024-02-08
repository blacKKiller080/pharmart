import 'package:flutter/material.dart';
import 'package:pharma/core/components/placeholders.dart';
import 'package:pharma/core/routes/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/constants/app_colors.dart';

class CustomSearchDelegate extends SearchDelegate {
  // Demo list to show querying
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
  List<String> resentSearches = [];

  bool isSelected = false;

  // first overwrite to
  // clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  // second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  // third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  // last overwrite to show the
  // querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;
    List<String> matchQuery = [];

    debugPrint(query);
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    if (query != '') {
      resentSearches.add(query);
    }
    return query == ''
        ? StatefulBuilder(
            builder: (thisLowerContext, innerSetState) {
              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: width * 3,
                      right: width * 3,
                      top: height * 2.5,
                      bottom: height * 1.7,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.history,
                          style: TextStyle(
                            color: AppColors.k_text_secondary_color,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {
                            innerSetState(() {
                              resentSearches.clear();
                            });
                          },
                          child: Text(
                            AppLocalizations.of(context)!.clear,
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
                  divider,
                  Flexible(
                    child: ListView.builder(
                      itemCount: resentSearches.length,
                      itemBuilder: (context, index) {
                        var result = resentSearches[index];
                        return Column(
                          children: [
                            ListTile(
                              visualDensity: VisualDensity.comfortable,
                              leading: Icon(Icons.history),
                              title: Text(
                                result,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              minLeadingWidth: 5,
                            ),
                            divider,
                          ],
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: query == '' ? 0 : matchQuery.length,
            itemBuilder: (context, index) {
              var result = matchQuery[index];
              return StatefulBuilder(
                builder: (thisLowerContext, innerSetState) {
                  return ListTile(
                    title: GestureDetector(
                        onTap: (() {
                          // innerSetState(
                          //   () {
                          //     isSelected = true;
                          //     query = result;
                          //   },
                          // );
                          Navigator.pushNamed(
                            context,
                            Routes.search_screen,
                            arguments: result,
                          );
                        }),
                        child: Text(result)),
                  );
                },
              );
            },
          );
    // return Container();
  }

  //  @override
  // Widget buildSuggestions(BuildContext context) {
  //   List suggestions = localUser.searches!.where((search) {
  //     return search.toLowerCase().contains(query.toLowerCase());
  //   }).toList();

  //   return ListView.builder(
  //     itemCount: suggestions.length,
  //     itemBuilder: (context, index) {
  //       final suggestion = suggestions[index];

  //       return ListTile(
  //         leading: Icon(Icons.history, size: 22),
  //         title: Text(suggestion, style: TextStyle(fontSize: 16)),
  //         onTap: () {
  //           query = suggestion;
  //           showResults(context);
  //         },
  //         trailing: IconButton(
  //           icon: Icon(Icons.close),
  //           iconSize: 15,
  //           onPressed: () {
  //             localUser.removeSearched(suggestion);
  //             UserPreferences.setUser(localUser);
  //             buildSuggestions(context);
  //           },
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  void showResults(BuildContext context) {
    Navigator.pushNamed(
      context,
      Routes.search_screen,
      arguments: query,
    );
    super.showResults(context);
  }
}
