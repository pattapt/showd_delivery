import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:showd_delivery/class/auth.dart';
import 'package:showd_delivery/model/AccountProfile.dart';
import 'package:showd_delivery/widget/home/AllMerchantCard.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({Key? key}) : super(key: key);
  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> with TickerProviderStateMixin {
  final scrollController = ScrollController();
  String accountName = "";
  String data = "test api res";

  @override
  void initState() {
    super.initState();
    getAccountData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> getAccountData() async {
    AccountProfileModel x = await Auth.getProfile();
    setState(() {
      accountName = x.username!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SingleChildScrollView(
        controller: scrollController,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "🖐🏻สวัสดีคุณ $accountName",
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Text(
                  "คุณสามารถค้นหาร้านค้า หรือสินค้าที่ต้องการได้ที่นี่ แล้วรอรับสินค้าที่บ้านในไม่กี่นาทีได้ลย",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const Divider(
                  thickness: 0.3,
                ),
                const SizedBox(height: 16),
                const AllMerchantCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
