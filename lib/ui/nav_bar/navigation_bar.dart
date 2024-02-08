// ignore_for_file: prefer_const_constructors

import 'package:pharma/core/components/placeholders.dart';
import 'package:pharma/ui/system/basket/basket_screen.dart';
import 'package:pharma/ui/system/favorites/favorites_screen.dart';
import 'package:pharma/ui/system/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pharma/ui/system/profile/legalStatus/companyProfile_screen.dart';
import 'package:pharma/ui/system/profile/legalStatus/company_message_screen.dart';
import 'package:pharma/ui/system/profile/legalStatus/company_orders_screen.dart';
import 'package:pharma/ui/system/search/search_screen.dart';
import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';
import '../system/profile/physStatus/profile_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({Key? key, required this.current}) : super(key: key);
  final int current;

  PageRouteBuilder _createRoute(Widget screen) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppColors.unselectedBottomIconColor,
          ),
        ),
      ),
      child: BottomNavigationBar(
        elevation: 0,
        currentIndex: current,
        showUnselectedLabels: true,
        selectedItemColor: AppColors.selectedBottomIconColor,
        unselectedItemColor: AppColors.unselectedBottomIconColor,
        selectedFontSize: 10.0,
        unselectedFontSize: 10.0,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppAssets.svg.bottomHomeIcon,
              color: current == 0 || current == 5
                  ? AppColors.selectedBottomIconColor
                  : AppColors.unselectedBottomIconColor,
            ),
            label: AppLocalizations.of(context)!.home,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppAssets.svg.bottomSeacrhIcon,
              color: current == 1
                  ? AppColors.selectedBottomIconColor
                  : AppColors.unselectedBottomIconColor,
            ),
            label: AppLocalizations.of(context)!.search,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              RadioTypes.legalStatus == roleStatus
                  ? AppAssets.svg.bottomMessageIcon
                  : AppAssets.svg.bottomBasketIcon,
              color: current == 2
                  ? AppColors.selectedBottomIconColor
                  : AppColors.unselectedBottomIconColor,
            ),
            label: RadioTypes.legalStatus == roleStatus
                ? AppLocalizations.of(context)!.messages
                : AppLocalizations.of(context)!.basket,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              RadioTypes.legalStatus == roleStatus
                  ? AppAssets.svg.bottomBasketIcon
                  : AppAssets.svg.bottomFavoritesIcon,
              color: current == 3
                  ? AppColors.selectedBottomIconColor
                  : AppColors.unselectedBottomIconColor,
            ),
            label: RadioTypes.legalStatus == roleStatus
                ? AppLocalizations.of(context)!.orders
                : AppLocalizations.of(context)!.favorites,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              RadioTypes.legalStatus == roleStatus
                  ? AppAssets.svg.bottomAptekaIcon
                  : AppAssets.svg.bottomProfileIcon,
              color: current == 4
                  ? AppColors.selectedBottomIconColor
                  : AppColors.unselectedBottomIconColor,
            ),
            label: RadioTypes.legalStatus == roleStatus
                ? AppLocalizations.of(context)!.pharmacy
                : AppLocalizations.of(context)!.profile,
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.of(context).pushAndRemoveUntil(
              _createRoute(const HomeScreen()),
              (route) => false,
            );
          } else if (index == 1) {
            Navigator.of(context).pushAndRemoveUntil(
              _createRoute(const SearchScreen()),
              (route) => false,
            );
          } else if (index == 2) {
            RadioTypes.legalStatus == roleStatus
                ? Navigator.of(context).pushAndRemoveUntil(
                    _createRoute(const CompanyMessageScreen()),
                    (route) => false,
                  )
                : Navigator.of(context).pushAndRemoveUntil(
                    _createRoute(const BasketScreen()),
                    (route) => false,
                  );
          } else if (index == 3) {
            RadioTypes.legalStatus == roleStatus
                ? Navigator.of(context).pushAndRemoveUntil(
                    _createRoute(const CompanyOrdersScreen()),
                    (route) => false,
                  )
                : Navigator.of(context).pushAndRemoveUntil(
                    _createRoute(const FavoritesScreen()),
                    (route) => false,
                  );
          } else if (index == 4) {
            RadioTypes.legalStatus == roleStatus
                ? Navigator.of(context).pushAndRemoveUntil(
                    _createRoute(const CompanyProfileScreen()),
                    (route) => false,
                  )
                : Navigator.of(context).pushAndRemoveUntil(
                    _createRoute(const ProfileScreen()),
                    (route) => false,
                  );
          }
        },
      ),
    );
  }
}
