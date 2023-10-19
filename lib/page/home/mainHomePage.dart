import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:showd_delivery/page/account/accountContent.dart';
import 'package:showd_delivery/page/cart/cartContent.dart';
import 'package:showd_delivery/page/home/homeContent.dart';
import 'package:showd_delivery/page/loading/PageLoadingV1.dart';
import 'package:showd_delivery/page/search/searchContent.dart';

class HomePage extends StatefulWidget {
  final int? index;
  final bool isFromLogin;
  const HomePage({Key? key, required this.index, this.isFromLogin = false}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  bool isLoading = true;
  List<Widget> pageList = [
    const PageLoadingV1(),
  ];
  int currentIndexPage = 0;
  int notiId = 0;

  void changePageIndex(int index) {
    setState(() {
      currentIndexPage = index;
    });
  }

  @override
  void initState() {
    currentIndexPage = widget.index ?? 0;
    initializeGeneric();
    super.initState();
  }

  void initializeGeneric() async {
    setState(() {
      isLoading = false;
      pageList = [
        const HomeContent(),
        const SearchContent(),
        const CartContent(),
        const AccountContent(),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading == true ? const PageLoadingV1() : pageList[currentIndexPage],
      bottomNavigationBar: BottomNavigationBar(
        unselectedFontSize: 12,
        selectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
        onTap: changePageIndex,
        currentIndex: currentIndexPage,
        selectedItemColor: Colors.black54,
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "ค้นหา"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_checkout_outlined), label: "ตระกร้า"),
          // BottomNavigationBarItem(icon: Icon(Icons.my_library_books_outlined), label: "รายการ"),
          BottomNavigationBarItem(icon: Icon(Icons.person_2_outlined), label: "ฉัน"),
        ],
      ),
    );
  }
}
