// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:pharma/main.dart';
// import '../../../core/constants/app_colors.dart';
// import '../../../core/helper/navigateable.dart';
// import '../../../core/routes/routes.dart';
// import '../../../core/storage/local_storage.dart';

// class SplashScreen extends StatefulWidget implements Navigateable {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();

//   @override
//   String getName() {
//     return Routes.splash;
//   }
// }

// class _SplashScreenState extends State<SplashScreen> {
//   Future<String?> getAccessToken() async {
//     token = await LocalStorage().getToken();
//     return token;
//   }

//   @override
//   void initState() {
//     super.initState();
//     // countDownTime();
//     Future.delayed(Duration(seconds: 1), () async {
//       var token = await getAccessToken();
//       if (token != null) {
//         Navigator.pushReplacementNamed(context, Routes.home_screen);
//       } else {
//         Navigator.pushReplacementNamed(context, Routes.login);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.k_main_color,
//       body: Center(
//         child: Image.asset('assets/images/png/logo_white.png'),
//       ),
//     );
//   }
// }
