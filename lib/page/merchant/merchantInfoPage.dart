import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:showd_delivery/class/chodelivery.dart';
import 'package:showd_delivery/class/products.dart';
import 'package:showd_delivery/class/address.dart' as Ad;
import 'package:showd_delivery/model/Address.dart' as AddressModel;
import 'package:showd_delivery/model/MerchantList.dart';
import 'package:showd_delivery/model/categorylist.dart';
import 'package:showd_delivery/widget/merchant/categoryIcon.dart';
import 'package:showd_delivery/widget/merchant/categoryItem.dart';
import 'package:showd_delivery/widget/merchant/merchantHeaderDetail.dart';
import 'package:showd_delivery/widget/merchant/merchantHeaderImage.dart';

class MerchantPage extends StatefulWidget {
  final String? merchantToken;
  const MerchantPage({Key? key, required this.merchantToken}) : super(key: key);
  @override
  State<MerchantPage> createState() => _MerchantPageState();
}

class _MerchantPageState extends State<MerchantPage> with TickerProviderStateMixin {
  late bool isLoading = true, isLoading2 = true, isHaveMerchant = false;
  String title = "";
  bool isOnlyPrimary = false;
  final scrollController = ScrollController();
  String htmlData = "";
  late MerchantDetail merchantData = MerchantDetail();
  late List<Category> CategoryOfMerchant = [];
  late bool showBag = true;

  @override
  void initState() {
    super.initState();
    getMerchantData();
    getMerchantCategory();
  }

  void getMerchantData() async {
    MerchantDetail x = await Product.getMerchantDetail(merchantToken: widget.merchantToken!);
    if (x != null) {
      setState(() {
        isHaveMerchant = true;
        merchantData = x;
        isLoading = false;
      });
    }
  }

  void getMerchantCategory() async {
    List<Category> x = await Product.getCategoryOfMerchant(merchantToken: widget.merchantToken!);
    if (x != null) {
      setState(() {
        CategoryOfMerchant = x;
        isLoading2 = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading || isLoading2)
      return Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Center(child: CircularProgressIndicator()),
      );
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: AppBar(
          title: Text(merchantData.name!),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        floatingActionButton: showBag
            ? FloatingActionButton(
                backgroundColor: Colors.green,
                onPressed: () async {
                  Chodee.openPage("/", 1);
                },
                tooltip: 'ตระกร้าสินค้า',
                child: const Icon(
                  Icons.shopping_bag,
                  color: Colors.white,
                ),
              )
            : null,
        body: !isHaveMerchant
            ? Container(
                height: double.infinity,
                width: double.infinity,
                child: Center(
                  child: Column(
                    children: [
                      Lottie.asset(
                        "assets/animation/animation-not-found-merchant.json",
                        width: 350,
                        fit: BoxFit.fill,
                      ),
                      Text("ไม่พบร้านค้าที่คุณระบุ กรุณาตรวจสอบข้อมูลแล้วลองใหม่"),
                    ],
                  ),
                ))
            : Container(
                color: Colors.white,
                child: Stack(
                  children: [
                    MerchantHeaderImage(
                      scrollController: scrollController,
                      image: Image.network(
                        merchantData.imageUrl!,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    SingleChildScrollView(
                      controller: scrollController,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(minHeight: 1200),
                        child: Container(
                          margin: const EdgeInsets.only(top: 200),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MerchantHeaderDetail(merchantData: merchantData),
                                  ],
                                ),
                              ),
                              QuickManu(categoryData: CategoryOfMerchant, merchantToken: widget.merchantToken ?? ""),
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0, right: 16),
                                child: CategoryItem(category: CategoryOfMerchant, merchantToken: widget.merchantToken ?? ""),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
