import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gofriendsgo/services/shared_preferences.dart';
import 'package:gofriendsgo/utils/navigations/navigations.dart';
import 'package:gofriendsgo/view/bottom_navigation_bar/bottom_navigation.dart';
import 'package:gofriendsgo/view/login_screen/login_screen.dart';
import 'package:gofriendsgo/view/on_boarding_screen/on_boarding_screen.dart';
import 'package:gofriendsgo/view_model/banner_viewmodel.dart';
import 'package:gofriendsgo/view_model/bookings_viewmodel.dart';
import 'package:gofriendsgo/view_model/cab_viewmodel.dart';
import 'package:gofriendsgo/view_model/carosual_viewmodel.dart';
import 'package:gofriendsgo/view_model/chats/chat_list_viewmodel.dart';
import 'package:gofriendsgo/view_model/chats/create_chat_viewmodel.dart';
import 'package:gofriendsgo/view_model/departure_viewmodel.dart';
import 'package:gofriendsgo/view_model/chats/fetching_chats.dart';
import 'package:gofriendsgo/view_model/filter_passports_viewmodel.dart';
import 'package:gofriendsgo/view_model/gallery_viewmodel.dart';
import 'package:gofriendsgo/view_model/passport_viewmodel.dart';
import 'package:gofriendsgo/view_model/profile_viewmodel.dart';
import 'package:gofriendsgo/view_model/chats/send_message_viewmodel.dart';
import 'package:gofriendsgo/view_model/sales_exe_viewmodel.dart';
import 'package:gofriendsgo/view_model/service_viewmodel.dart';
import 'package:gofriendsgo/view_model/stories_viewmodel.dart';
import 'package:gofriendsgo/view_model/team_viewmodel.dart';
import 'package:gofriendsgo/view_model/user_details.dart';
import 'package:gofriendsgo/view_model/visa_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  HttpOverrides.global = MyHttpOverrides();
  //test
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => FilterScreenViewModel()),
    ChangeNotifierProvider(create: (_) => CreateChatViewModel()),
    ChangeNotifierProvider(create: (_) => FetchChatsViewModel()),
    ChangeNotifierProvider(create: (_) => ChatListViewmodel()),
    ChangeNotifierProvider(create: (_) => UserViewModel()),
    ChangeNotifierProvider(create: (_) => ServiceViewModel()),
    ChangeNotifierProvider(create: (_) => CarosualViewModel()),
    ChangeNotifierProvider(create: (_) => BannerViewModel()),
    ChangeNotifierProvider(create: (_) => StoriesViewModel()),
    ChangeNotifierProvider(create: (_) => VisaViewModel()),
    ChangeNotifierProvider(create: (_) => CabViewModel()),
    ChangeNotifierProvider(create: (_) => PassportViewModel()),
    ChangeNotifierProvider(create: (_) => ProfileViewModel()),
    ChangeNotifierProvider(create: (_) => FixedDeparturesViewModel()),
    ChangeNotifierProvider(create: (_) => SendMessageViewModel()),
    ChangeNotifierProvider(create: (_) => BookingViewModel()),
    ChangeNotifierProvider(create: (_) => SalesPersonViewModel()),
    ChangeNotifierProvider(create: (_) => TeamsViewModel()),
    ChangeNotifierProvider(create: (_) => GalleryViewModel()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final SharedPreferecesServices sharedPreferecesServices =
      SharedPreferecesServices();
  String? authToken;
  @override
  void initState() {
    checkToken(sharedPreferecesServices, (token) {
      setState(() {
        authToken = token;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'GoFriendsGo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: checkStartingScreen(authToken),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Widget checkStartingScreen(String? value) {
  if (value == null) {
    return const OnBoardingScreen();
  } else if (value.isEmpty) {
    return LoginScreen();
  } else {
    return const BottomNavigationScreen();
  }
}

checkToken(SharedPreferecesServices sharedPreferecesServices,
    TokenCallback callback) async {
  final value = await sharedPreferecesServices.getToken();
  callback(value);
}

typedef TokenCallback = void Function(String? token);
