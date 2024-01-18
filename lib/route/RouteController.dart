import 'package:flutter/material.dart';
import 'package:showd_delivery/page/address/addressEdit.dart';
import 'package:showd_delivery/page/address/addressPage.dart';
import 'package:showd_delivery/page/address/districtPageEdit.dart';
import 'package:showd_delivery/page/authentication/LoginPage.dart';
import 'package:showd_delivery/page/authentication/RegisterPage.dart';
import 'package:showd_delivery/page/chat/chatPage.dart';
import 'package:showd_delivery/page/history/HistoryInfo.dart';
import 'package:showd_delivery/page/home/mainHomePage.dart';
import 'package:showd_delivery/page/merchant/allProductPage.dart';
import 'package:showd_delivery/page/merchant/merchantInfoPage.dart';
import 'package:showd_delivery/page/merchant/productInfoPage.dart';
import 'package:showd_delivery/page/onboard/onboarding.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    dynamic args = settings.arguments;
    String path = settings.name!;
    switch (path) {
      case '/onboard':
        return MaterialPageRoute(builder: (_) => const OnBoardingPage());
      // case '/ssl-error':
      //   return MaterialPageRoute(builder: (_) => DefaultErrorPage(error: generic.data?.error?.ssl));
      case '/':
        if (args is int) {
          return MaterialPageRoute(builder: (_) => HomePage(index: args));
        }
        return _errorRoute();
      case '/home':
        return MaterialPageRoute(builder: (_) => HomePage(index: args));
      case '/login':
        if (args is bool) {
          return MaterialPageRoute(builder: (_) => const LoginPage());
        }
        return MaterialPageRoute(builder: (_) => LoginPage());
      // case '/forgot-password':
      //   return MaterialPageRoute(builder: (_) => ForgotPasswordPage(generic: generic));
      // case '/phone-editor':
      //   return MaterialPageRoute(builder: (_) => PhoneEditPage(generic: generic));
      // case '/otp-submit':
      //   return MaterialPageRoute(builder: (_) => OTPSubmitPage(generic: generic));
      case '/register':
        if (args is bool) {
          return MaterialPageRoute(builder: (_) => const RegisterPage());
        }
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case '/PurchaseInfoPage':
        if (args is String) {
          return MaterialPageRoute(builder: (_) => TransactionHistoryDetail(orderToken: args));
        }
        return _errorRoute();
      case '/merchant':
        if (args is String) {
          return MaterialPageRoute(builder: (_) => MerchantPage(merchantToken: args));
        }
        return _errorRoute();
      case '/AllProductPage':
        if (args is Map<String, dynamic>) {
          return MaterialPageRoute(builder: (_) => AllProductPage(data: args));
        }
        return _errorRoute();
      case '/ProductInfoPage':
        if (args is Map<String, dynamic>) {
          return MaterialPageRoute(builder: (_) => ProductInfoPage(data: args));
        }
        return _errorRoute();
      case '/chat':
        if (args is Map<String, dynamic>) {
          return MaterialPageRoute(builder: (_) => ChatPage(data: args));
        }
        return _errorRoute();
      case '/destination':
        return MaterialPageRoute(builder: (_) => const addressPage());
      case '/editAddress':
        if (args is String) {
          return MaterialPageRoute(builder: (_) => AddressEditPage(addressToken: args, isEdit: true));
        }
        return _errorRoute();
      case '/addAddress':
        if (args is String) {
          return MaterialPageRoute(builder: (_) => AddressEditPage(addressToken: args, isEdit: false));
        }
        return _errorRoute();
      case '/districtSearch':
        if (args is String) {
          return MaterialPageRoute(builder: (_) => DistrictListPage(zipcode: args));
        }
        return _errorRoute();
      case '/Logout':
        return MaterialPageRoute(builder: (_) => LoginPage());
      //   if(args is String){
      //     return MaterialPageRoute(builder: (_) => PurchaseInfoPage(generic: generic, refID: args));
      //   }
      //   return _errorRoute();
      // case '/TopupInfoPage':
      //   if(args is Map<String, dynamic>){
      //     return MaterialPageRoute(builder: (_) => TopupInfoPage(generic: generic, refID: args['token'], redirectTopup: args['openPay']));
      //   }
      //   if(args is String){
      //     return MaterialPageRoute(builder: (_) => TopupInfoPage(generic: generic, refID: args));
      //   }
      //   return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('ERROR'),
        ),
        body: const Center(
          child: Text('Error the page that you request are not found'),
        ),
      );
    });
  }
}
