import 'package:flutter/material.dart';
import 'package:pharma/core/constants/app_colors.dart';

class CardWidget extends StatelessWidget {
  final String image;
  final String title;
  final double width;

  const CardWidget(
      {Key? key, required this.image, required this.title, required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      // padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(
        right: 10,
      ),
      padding: EdgeInsets.only(right: 15, left: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromRGBO(90, 225, 225, 1.0),
            Color.fromARGB(255, 191, 254, 238),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image),
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: TextStyle(
              color: AppColors.k_main_color,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
