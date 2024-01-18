import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:showd_delivery/class/cart.dart';
import 'package:showd_delivery/class/products.dart';
import 'package:showd_delivery/model/product.dart' as productModel;
import 'package:showd_delivery/class/address.dart' as Ad;
import 'package:showd_delivery/model/Address.dart' as AddressModel;
import 'package:showd_delivery/model/MerchantList.dart';
import 'package:showd_delivery/model/categorylist.dart';
import 'package:showd_delivery/widget/input/note.dart';
import 'package:showd_delivery/widget/merchant/categoryIcon.dart';
import 'package:showd_delivery/widget/merchant/categoryItem.dart';
import 'package:showd_delivery/widget/merchant/merchantHeaderDetail.dart';
import 'package:showd_delivery/widget/merchant/merchantHeaderImage.dart';
import 'package:showd_delivery/widget/merchant/productHeaderDetail.dart';

class ProductInfoPage extends StatefulWidget {
  final Map<String, dynamic>? data;

  const ProductInfoPage({
    Key? key,
    this.data,
  }) : super(key: key);

  @override
  State<ProductInfoPage> createState() => _ProductInfoPageState();
}

class _ProductInfoPageState extends State<ProductInfoPage> with TickerProviderStateMixin {
  late bool isLoading = true, isLoading2 = true, isHaveProduct = false;
  String title = "";
  bool isOnlyPrimary = false;
  final scrollController = ScrollController();
  String htmlData = "";
  late List<Category> CategoryOfMerchant = [];
  late productModel.Product productData = productModel.Product();

  final TextEditingController noteController = TextEditingController();
  final FocusNode noteFocusNode = FocusNode();
  int amount = 1;

  @override
  void initState() {
    super.initState();
    getProductData();
  }

  void getProductData() async {
    String productToken = widget.data!["productToken"];
    String merchantToken = widget.data!["merchantToken"];
    productModel.Product x = await Product.getProductDetail(merchantToken: merchantToken, productToken: productToken);
    if (x != null) {
      setState(() {
        isLoading = false;
        productData = x;
      });
      if (productData.name != null) {
        setState(() {
          isHaveProduct = true;
        });
      }
    }
  }

  void buyItem() async {
    bool x = await Cart.addItemCart(productId: productData.productId!, productToken: productData.productToken!, amount: amount, note: noteController.text);
    if (x) {
      Navigator.pop(context);
    }
  }

  void adjustAmount(bool isAdd) {
    if (isAdd) {
      setState(() {
        amount++;
      });
    } else {
      if (amount > 1) {
        setState(() {
          amount--;
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
          title: Text(productData.name!),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
        ),
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
            : Container(
                color: Colors.white,
                child: Stack(
                  children: [
                    MerchantHeaderImage(
                      scrollController: scrollController,
                      image: Image.network(
                        productData.imageUrl!,
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
                                    ProductHeaderDetail(productData: productData),
                                    const SizedBox(height: 30),
                                    NoteInput(controller: noteController, focusNode: noteFocusNode, action: TextInputAction.done),
                                    const SizedBox(height: 30),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            adjustAmount(false);
                                          },
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.grey, // Set your desired border color
                                                width: 0.5, // Set your desired border width
                                              ),
                                              borderRadius: BorderRadius.circular(10.0), // Set your desired border radius
                                            ),
                                            child: const Icon(
                                              Icons.remove,
                                              color: Colors.grey,
                                              size: 30,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Container(
                                          width: 100,
                                          height: 50,
                                          child: Center(
                                            child: Text(
                                              amount.toString(),
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontSize: 30.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        GestureDetector(
                                          onTap: () {
                                            adjustAmount(true);
                                          },
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.grey, // Set your desired border color
                                                width: 0.5, // Set your desired border width
                                              ),
                                              borderRadius: BorderRadius.circular(10.0), // Set your desired border radius
                                            ),
                                            child: const Icon(
                                              Icons.add,
                                              color: Colors.grey,
                                              size: 30,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: const Size.fromHeight(50),
                                        backgroundColor: Colors.blue,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                      ),
                                      onPressed: () {
                                        buyItem();
                                      },
                                      child: const Text(
                                        "สั่งซื้อสินค้า",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // QuickManu(categoryData: CategoryOfMerchant, merchantToken: widget.merchantToken ?? ""),
                              // Padding(
                              //   padding: const EdgeInsets.only(left: 16.0, right: 16),
                              //   child: CategoryItem(category: CategoryOfMerchant, merchantToken: widget.merchantToken ?? ""),
                              // ),
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
