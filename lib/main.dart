import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showd_delivery/class/auth.dart';
import 'package:showd_delivery/model/AccountProfile.dart';
import 'package:showd_delivery/route/RouteController.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final onboard = prefs.getBool('onboard') ?? false;
  final isLogin = prefs.getBool('isLogin') ?? false;

  if (isLogin) {
    await Auth.grantAccessToken();
    // AccountProfileModel x = await Auth.getProfile();
  }

  runApp(MyApp(
    onboard: onboard,
    isLogin: isLogin,
    navigatorKey: navigatorKey,
  ));
}

class MyApp extends StatefulWidget {
  final bool onboard;
  final bool isLogin;
  final dynamic session;
  final GlobalKey<NavigatorState> navigatorKey;

  const MyApp({
    Key? key,
    required this.onboard,
    required this.isLogin,
    required this.navigatorKey,
    this.session,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChoDelivery',
      theme: _buildTheme(Brightness.light),
      initialRoute: widget.isLogin ? '/home' : (widget.onboard ? '/login' : '/onboard'),
      onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),
      navigatorKey: widget.navigatorKey,
    );
  }

  ThemeData _buildTheme(Brightness brightness) {
    var baseTheme = ThemeData(
      primaryColor: Colors.redAccent,
      primaryColorDark: Colors.red,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromARGB(255, 255, 255, 255),
        secondary: const Color.fromARGB(255, 255, 255, 255),
      ),
      useMaterial3: true,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        titleTextStyle: GoogleFonts.prompt(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
        ),
      ),
    );

    return baseTheme.copyWith(
      textTheme: GoogleFonts.promptTextTheme(baseTheme.textTheme),
    );
  }
}
