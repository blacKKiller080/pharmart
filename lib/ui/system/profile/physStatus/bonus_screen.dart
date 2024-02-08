import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pharma/core/helper/navigateable.dart';
import 'package:pharma/core/routes/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/components/placeholders.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../nav_bar/navigation_bar.dart';

class BonusScreen extends StatefulWidget implements Navigateable {
  const BonusScreen({super.key});

  @override
  State<BonusScreen> createState() => _BonusScreenState();

  @override
  String getName() {
    return Routes.bonus_screen;
  }
}

class _BonusScreenState extends State<BonusScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: AppNavigationBar(current: 4),
      backgroundColor: AppColors.k_white_color,
      appBar: appBar(context, AppLocalizations.of(context)!.myBonuses),
      body: Container(
        height: height * 100,
        margin: EdgeInsets.only(
          right: width * 3.72,
          left: width * 3.72,
        ),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(bottom: height * 2.57),
          shrinkWrap: true,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  //  height: height * 22.55,

                  margin: EdgeInsets.only(
                    top: 10,
                    right: width * 1,
                    left: width * 1,
                    bottom: height * 2.57,
                  ),
                  padding: EdgeInsets.only(
                    right: width * 3.72,
                    left: width * 3.72,
                    top: height * 2.57,
                    bottom: height * 4,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 212, 252, 242),
                        Color.fromARGB(255, 112, 230, 229),
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color:
                            const Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                '104',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.k_secondary_color,
                                ),
                              ),
                              Text(
                                AppLocalizations.of(context)!.eranedBonuses,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.k_secondary_color,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: width * 9.77),
                          SvgPicture.asset('assets/images/svg/gift.svg'),
                        ],
                      ),
                      SizedBox(height: height * 3.43),
                      Text(
                        'Начисляем 10% бонусов от стомиости полученного заказа, которыми можно оплатить следующую покупку',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF87878C),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.bonusHistory,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                bonusContainer(),
                bonusContainer(),
                bonusContainer(),
                bonusContainer(),
                bonusContainer(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget bonusContainer() {
    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;
    return Container(
      margin: EdgeInsets.only(
        top: height * 1.72,
      ),
      padding: EdgeInsets.only(
        right: width * 3.72,
        left: width * 3.72,
        top: height * 1.6,
        bottom: height * 1.6,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.neutral3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'Начислены бонусы 450 за покупку на сумму 5000₸',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.k_black_color,
            ),
          ),
          Text(
            '27.08.2023 15:20',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.k_grey400_color,
            ),
          ),
        ],
      ),
    );
  }
}
