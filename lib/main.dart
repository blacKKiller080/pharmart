// import 'dart:async';

// import 'package:flutter/services.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:pharma/core/business/bloc/category/category_bloc.dart';
// import 'package:pharma/core/constants/app_colors.dart';
// import 'package:pharma/core/provider/locale_provider.dart';
// import 'package:pharma/ui/auth/login/login_screen.dart';
// import 'package:pharma/ui/auth/registration/registration_screen.dart';
// import 'package:pharma/ui/auth/splash/splash_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pharma/ui/system/basket/basket_screen.dart';
// import 'package:pharma/ui/system/basket/ordering_screen.dart';
// import 'package:pharma/ui/system/favorites/favorites_screen.dart';
// import 'package:pharma/ui/system/home/category_screen.dart';
// import 'package:pharma/ui/system/home/product_screen.dart';
// import 'package:pharma/ui/system/profile/legalStatus/companyEdit_screen.dart';
// import 'package:pharma/ui/system/profile/legalStatus/companyProfile_screen.dart';
// import 'package:pharma/ui/system/profile/legalStatus/company_analytic_screen.dart';
// import 'package:pharma/ui/system/profile/legalStatus/company_rating_screen.dart';
// import 'package:pharma/ui/system/profile/legalStatus/company_message_screen.dart';
// import 'package:pharma/ui/system/profile/legalStatus/company_orders_screen.dart';
// import 'package:pharma/ui/system/profile/legalStatus/company_promotion_screen.dart';
// import 'package:pharma/ui/system/profile/legalStatus/company_feedback_screen.dart';
// import 'package:pharma/ui/system/profile/legalStatus/company_stock_screen.dart';
// import 'package:pharma/ui/system/profile/physStatus/add_card_screen.dart';
// import 'package:pharma/ui/system/profile/physStatus/bonus_screen.dart';
// import 'package:pharma/ui/system/profile/physStatus/card_info_screen.dart';
// import 'package:pharma/ui/system/profile/physStatus/change_password.dart';
// import 'package:pharma/ui/system/profile/physStatus/edit_screen.dart';
// import 'package:pharma/ui/system/profile/physStatus/feedback_screen.dart';
// import 'package:pharma/ui/system/profile/physStatus/message_screen.dart';
// import 'package:pharma/ui/system/profile/physStatus/my_orders_screen.dart';
// import 'package:pharma/ui/system/profile/physStatus/profile_screen.dart';
// import 'package:pharma/ui/system/profile/physStatus/subscription_screen.dart';
// import 'package:pharma/ui/system/search/search_screen.dart';
// import 'package:provider/provider.dart';
// import 'core/business/bloc/authorization/authorization_bloc.dart';
// import 'core/business/bloc/cart/cart_action.dart';
// import 'core/business/bloc/cart/cart_bloc.dart';
// import 'core/business/bloc/favourite/favourite_action.dart';
// import 'core/business/bloc/favourite/favourite_bloc.dart';
// import 'core/business/bloc/user/user_bloc.dart';
// import 'core/helper/navigateable.dart';
// import 'core/provider/authorization/authorization_provider.dart';
// import 'core/repo/repo_settings.dart';
// import 'core/routes/routes.dart';
// import 'core/storage/local_storage.dart';
// import 'l10n/l10n.dart';
// import 'ui/system/home/home_screen.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// String? token;

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final repoSettings = RepoSettings();
//   await repoSettings.init();
//   await getAccessToken();
//   SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
//       .then((_) {
//     runApp(Pharma());
//   });
// }

// Future<String?> getAccessToken() async {
//   token = await LocalStorage().getToken();
//   return token;
// }

// class Pharma extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     var authorization_provider = AuthorizationProvider();
//     return RepositoryProvider(
//       create: (_) => AuthorizationProvider(),
//       child: MultiBlocProvider(
//         providers: [
//           BlocProvider<AuthorizationBloc>(
//             create: (_) => AuthorizationBloc(),
//           ),
//           BlocProvider<UserBloc>(
//             create: (_) => UserBloc(),
//           ),
//           BlocProvider<CategoryBloc>(
//             create: (_) => CategoryBloc(authorization_provider),
//           ),
//           BlocProvider<CardBloc>(
//             create: (_) => CardBloc(CardAction())..add(GetCardEvent()),
//           ),
//           BlocProvider<FavouriteBloc>(
//             create: (_) =>
//                 FavouriteBloc(FavouriteAction())..add(FavouriteStarted()),
//           ),
//         ],
//         child: ChangeNotifierProvider(
//             create: (context) => LocaleProvider(),
//             builder: (context, child) {
//               final provider = Provider.of<LocaleProvider>(context);
//               return MaterialApp(
//                 debugShowCheckedModeBanner: false,
//                 title: 'Flutter Demo',
//                 theme: ThemeData(
//                   fontFamily: 'Inter',
//                   backgroundColor: AppColors.k_white_color,
//                   textTheme: const TextTheme(
//                     displaySmall: TextStyle(
//                       color: AppColors.k_text_primary_color,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w400,
//                     ),
//                     displayMedium: TextStyle(
//                       fontWeight: FontWeight.w500,
//                       fontSize: 16,
//                       color: AppColors.k_black_color,
//                     ),
//                     titleMedium: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.k_text_primary_color,
//                     ),
//                     titleSmall: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.k_main_color,
//                     ),
//                   ),
//                 ),
//                 routes: routes(),
//                 initialRoute: // Routes.splash,
//                     getAccessToken() == '' ? Routes.splash : Routes.home_screen,
//                 locale: provider.locale,
//                 supportedLocales: L10n.locales,
//                 localizationsDelegates: [
//                   AppLocalizations.delegate,
//                   GlobalMaterialLocalizations.delegate,
//                   GlobalCupertinoLocalizations.delegate,
//                   GlobalWidgetsLocalizations.delegate,
//                 ],
//               );
//             }),
//       ),
//     );
//   }
// }

// routes() {
//   List<Navigateable> screens = generateRoutes();
//   Map<String, Widget Function(BuildContext)> routes = {};
//   for (var element in screens) {
//     routes[element.getName()] = (context) => element;
//   }
//   return routes;
// }

// List<Navigateable> generateRoutes() {
//   return [
//     const SplashScreen(),
//     const LoginScreen(),
//     const RegistrationScreen(),
//     const HomeScreen(),
//     const SearchScreen(),
//     const BasketScreen(),
//     const FavoritesScreen(),
//     const ProfileScreen(),
//     const CategoryScreen(),
//     const ProductScreen(),
//     const OrderingScreen(),
//     EditScreen(),
//     const MessageScreen(),
//     const MyOrdersScreen(),
//     const BonusScreen(),
//     const FeedBackScreen(),
//     const SubscriptionScreen(),
//     const CompanyProfileScreen(),
//     const CompanyEditScreen(),
//     const CompanyMessageScreen(),
//     const CompanyOrdersScreen(),
//     const CompanyAnalyticScreen(),
//     const CompanyStockScreen(),
//     const CompanyPromotionScreen(),
//     const CompanyFeedbackScreen(),
//     const CompanyRatingScreen(),
//     const AddCardScreen(),
//     const CardInfoScreen(),
//     const ChangePasswordScreen(),
//   ];
// }

import 'package:flutter/material.dart';
import 'my_halyk_ios.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    initializeHalykID();
  }

  Future<void> initializeHalykID() async {
    try {
      await MyHalykIos.initializeHalykID(
        clientID: 'your_client_id',
        scope: 'your_scope',
        redirectURL: 'your_redirect_url',
        state: 'your_state',
        localization: 'kaz', // or 'ru', 'en'
        configuration: 'development', // or 'production'
      );
    } catch (e) {
      print('Error initializing HalykID: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HalykID SDK Example'),
      ),
      body: Center(
        child: Text('Welcome to HalykID SDK Example!'),
      ),
    );
  }
}
