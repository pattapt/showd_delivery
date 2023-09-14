import 'package:flutter/material.dart';
import 'package:showd_delivery/page/home/mainHomePage.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    dynamic args = settings.arguments;
    String path = settings.name!;

    switch (path) {
      // case '/onboard':
      //   return MaterialPageRoute(builder: (_) => OnBoardingPage(generic: generic));
      // case '/ssl-error':
      //   return MaterialPageRoute(builder: (_) => DefaultErrorPage(error: generic.data?.error?.ssl));
      case '/':
        if (args is int) {
          return MaterialPageRoute(builder: (_) => HomePage(index: args));
        }
        return _errorRoute();
      case '/home':
        return MaterialPageRoute(builder: (_) => HomePage(index: args));
      // case '/login':
      //   if (args is bool) {
      //     return MaterialPageRoute(builder: (_) => LoginPage(generic: generic, showCloseBTN: args));
      //   }
      //   return MaterialPageRoute(builder: (_) => LoginPage(generic: generic));
      // case '/forgot-password':
      //   return MaterialPageRoute(builder: (_) => ForgotPasswordPage(generic: generic));
      // case '/phone-editor':
      //   return MaterialPageRoute(builder: (_) => PhoneEditPage(generic: generic));
      // case '/otp-submit':
      //   return MaterialPageRoute(builder: (_) => OTPSubmitPage(generic: generic));
      // case '/register':
      //   if (args is bool) {
      //     return MaterialPageRoute(builder: (_) => RegisterPage(generic: generic, showCloseBTN: args));
      //   }
      //   return MaterialPageRoute(builder: (_) => RegisterPage(generic: generic));
      // case '/product':
      //   if (args is int) {
      //     return MaterialPageRoute(builder: (_) => ItemCategoryPage(generic: generic, id: args));
      //   }
      //   return _errorRoute();
      // case '/productInfo':
      //   if (args is CategoryModel) {
      //     return MaterialPageRoute(builder: (_) => ItemCategoryInfoPage(generic: generic, categoryData: args));
      //   }
      //   return _errorRoute();
      // case '/addToCart':
      //   if (args is Map<String, dynamic>) {
      //     return MaterialPageRoute(builder: (_) => AddToCartPage(generic: generic, id: args['id'], categoryModel: args['model']));
      //   }
      //   return _errorRoute();
      // case '/Cart':
      //   if(args is CartDataModel){
      //     return MaterialPageRoute(builder: (_) => CartPage(generic: generic, data: args));
      //   }
      //   return _errorRoute();
      // case '/CartPaymentSelect':
      //   if(args is Map<String, dynamic>){
      //     return MaterialPageRoute(builder: (_) => CartPaymentSelectPage(generic: generic, cartData: args['data'], selectedMethodCode: args['methodCode']));
      //   }
      //   return _errorRoute();
      // case '/topup':
      //   return MaterialPageRoute(builder: (_) => TopupPageContent(generic: generic));
      // case '/TopupPaymentSelect':
      //   if(args is Map<String, dynamic>){
      //     return MaterialPageRoute(builder: (_) => TopupPaymentSelectPage(generic: generic, data: args['data'], selectedMethodCode: args['methodCode']));
      //   }
      //   return _errorRoute();
      // case '/PurchaseInfoPage':
      //   if(args is Map<String, dynamic>){
      //     return MaterialPageRoute(builder: (_) => PurchaseInfoPage(generic: generic, refID: args['token'], redirectTopup: args['openPay']));
      //   }
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
