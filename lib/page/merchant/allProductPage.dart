import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:showd_delivery/class/chodelivery.dart';
import 'package:showd_delivery/class/products.dart' as Product;
import 'package:showd_delivery/model/product.dart' as ProductModel;
import 'package:showd_delivery/model/productV2.dart' as productV2Model;
import 'package:showd_delivery/model/product.dart' as productModel;
import 'package:showd_delivery/widget/merchant/productItemProList.dart';

class AllProductPage extends StatefulWidget {
  final Map<String, dynamic>? data;

  const AllProductPage({
    Key? key,
    this.data,
  }) : super(key: key);

  @override
  State<AllProductPage> createState() => _AllProductPageState();
}

class _AllProductPageState extends State<AllProductPage> with TickerProviderStateMixin {
  late bool isLoading = true, isHaveProduct = false;
  final scrollController = ScrollController();
  int page = 1;
  List<productV2Model.Datum> productOfMerchant = [];
  late bool showBag = true;

  @override
  void initState() {
    super.initState();
    getProduct(page);
    scrollController.addListener(scrollListener);
  }

  void scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      getProduct(page);
    }
  }

  void getProduct(int page) async {
    String merchantToken = widget.data!["merchantToken"];
    String categoryToken = widget.data!["categoryToken"];

    productV2Model.ProductV2 x = await Product.Product.getProductOfCategoryInMerchantV2(merchantToken: merchantToken, categoryToken: categoryToken, limit: 50);
    if (x != null) {
      setState(() {
        productOfMerchant.addAll(x.data!);
        isLoading = false;
        this.page++;
      });
      if (!isHaveProduct) {
        setState(() {
          isHaveProduct = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading)
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
          title: Text("รายการสินค้า"),
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
        body: !isHaveProduct
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
            : SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                controller: scrollController,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    color: Colors.white,
                    child: ProductItemFromList(productOfMerchant: productOfMerchant, merchantToken: widget.data!["merchantToken"]),
                  ),
                ),
              ),
      ),
    );
  }
}
