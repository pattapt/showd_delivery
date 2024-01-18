import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:showd_delivery/class/cart.dart';
import 'package:showd_delivery/class/chodelivery.dart';
import 'package:showd_delivery/class/ui.dart';
import 'package:showd_delivery/class/address.dart' as Ad;
import 'package:showd_delivery/model/Address.dart' as AddressModel;
import 'package:showd_delivery/model/CheckOutCart.dart';
import 'package:showd_delivery/model/cartList.dart';
import 'package:showd_delivery/widget/cart/CartEditDetail.dart';
import 'package:showd_delivery/widget/cart/CartListItem.dart';
import 'package:showd_delivery/widget/history/PurchaseTransactionItem.dart';
import 'package:showd_delivery/widget/input/note.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CartContent extends StatefulWidget {
  const CartContent({Key? key}) : super(key: key);
  @override
  State<CartContent> createState() => _CartContentState();
}

class _CartContentState extends State<CartContent> with TickerProviderStateMixin {
  bool isLoading = true, isLoading2 = true, isEndPage = false;
  final scrollController = ScrollController();
  final formKey = GlobalKey<FormState>();
  late CartList cart = CartList();
  final panelController = PanelController();
  late CartData cartEditFocus = CartData();
  late double pricePerOne = 0.0;
  late int amount = 1;

  late AddressModel.AddressDetail defaultAddress = AddressModel.AddressDetail();

  final NoteController = TextEditingController();
  final cartInputController = TextEditingController();
  final cartFocusNode = FocusNode();

  int apiPage = 1, currentIndex = 0;
  bool isHaveCart = false;

  late List<AddressModel.AddressDetail> address = [];
  int destinationId = 0;

  @override
  void initState() {
    super.initState();
    getCart();
    getAddressCache();
    scrollController.addListener(scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getCart() async {
    CartList data = await Cart.getMyCart();
    setState(() {
      isLoading = false;
    });

    if (data.cart != null && data.cart!.isNotEmpty) {
      setState(() {
        cart = data;
        cartEditFocus = data.cart![0];
        isHaveCart = true;
      });
    }
  }

  void scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      getCart();
    }
  }

  void openPopUpCart(CartData data) {
    setState(() {
      cartEditFocus = data;
      NoteController.text = data.note!;
      pricePerOne = data.totalPrice! / data.amount!;
      amount = data.amount!;
    });
    panelController.open();
  }

  void saveData() async {
    bool data = await Cart.updateMyCart(cartId: cartEditFocus.cartId!, cartToken: cartEditFocus.cartToken!, amount: amount, note: NoteController.text);
    if (data) {
      panelController.close();
      getCart();
    }
  }

  void adjustAmount(bool isAdd) {
    if (isAdd) {
      setState(() {
        amount++;
      });
    } else {
      if (amount > 0) {
        setState(() {
          amount--;
        });
      }
    }
  }

  Future<void> getAddressCache() async {
    List<AddressModel.AddressDetail> x = await Ad.Address.getMyAddress();
    if (x != null) {
      setState(() {
        destinationId = x[0].destinationId!;
        defaultAddress = x[0];
        address = x;
        isLoading2 = false;
      });
    }
  }

  void checkOut() async {
    CheckOutCart data = await Cart.checkOutMyCart(destinationId: destinationId, paymentMethod: "promptpay", note: cartInputController.text);
    if (data.transactionToken != null) {
      Navigator.pushNamed(context, '/PurchaseInfoPage', arguments: data.transactionToken);
    }
  }

  void updateAddress(int result) async {
    int index = -1;
    await getAddressCache();

    for (int i = 0; i < address.length; i++) {
      if (address[i].destinationId == result) {
        index = i;
        break;
      }
    }

    if (index != -1) {
      print(index);
      setState(() {
        destinationId = result;
        defaultAddress = address[index];
      });
    } else {
      print('Destination not found in the address list.');
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
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          automaticallyImplyLeading: false,
          title: const Text("ตระกร้าสินค้า"),
        ),
        body: SlidingUpPanel(
          defaultPanelState: PanelState.CLOSED,
          controller: panelController,
          minHeight: 0,
          maxHeight: 500,
          color: Colors.transparent,
          onPanelClosed: () {
            setState(() {});
          },
          panel: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Column(
              children: [
                const BarIndicatorForSlidePanel(),
                const SizedBox(height: 10),
                isHaveCart
                    ? CartEditPopUp(
                        cart: cartEditFocus,
                        noteController: NoteController,
                        pricePerOne: pricePerOne,
                        amount: amount,
                        saveData: saveData,
                        callback: adjustAmount,
                      )
                    : Container()
              ],
            ),
          ),
          body: !isHaveCart
              ? Container(
                  height: double.infinity,
                  child: Center(
                    child: Column(
                      children: [
                        Lottie.asset(
                          "assets/animation/animation-empty-cart.json",
                          width: 350,
                          fit: BoxFit.fill,
                        ),
                        Text("ไม่มีสินค้าในตะกร้า เพิ่มสินค้าในตระกร้าแล้วสั่งซื้อเลย"),
                      ],
                    ),
                  ))
              : RefreshIndicator(
                  onRefresh: () async {
                    setState(() {
                      isLoading = true;
                      apiPage = 1;
                      cart = CartList();
                    });
                    getCart();
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: scrollController,
                    child: Container(
                      color: Colors.white,
                      width: double.infinity,
                      child: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "ตระกร้าสินค้า",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Text(
                                "รายการตระกร้าสินค้าของคุณ มีสินค้าในตระกร้าแล้ว มีแฟนยัง อิอิ",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Divider(thickness: 0.1),
                              cart.cart != null ? CartListItem(cart: cart.cart!, callback: openPopUpCart) : const SizedBox(),
                              cart.cart != null
                                  ? Text(
                                      "ราคารวม ${Chodee.convertPrice(double.parse(cart.totalPrice!.toString()))} ฿",
                                      textAlign: TextAlign.right,
                                      style: const TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                                    )
                                  : const SizedBox(),
                              const SizedBox(height: 20),
                              Container(
                                color: Colors.white,
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "ที่อยู่จัดส่งสินค้า",
                                      textAlign: TextAlign.left,
                                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                    ),
                                    const SizedBox(height: 10),
                                    GestureDetector(
                                      onTap: () async {
                                        final result = await Navigator.pushNamed(
                                          context,
                                          '/destination',
                                        );

                                        if (result != null && result is int) {
                                          updateAddress(result);
                                        }
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      address != null
                                                          ? Text(
                                                              defaultAddress.name!,
                                                              style: const TextStyle(
                                                                fontSize: 14.0,
                                                                fontWeight: FontWeight.w600,
                                                                color: Colors.grey,
                                                              ),
                                                            )
                                                          : const SizedBox(),
                                                      address == null
                                                          ? const Text(
                                                              "เพิ่มที่อยู่ใหม่",
                                                              style: TextStyle(
                                                                fontSize: 14.0,
                                                                fontWeight: FontWeight.w600,
                                                                color: Colors.grey,
                                                              ),
                                                            )
                                                          : const SizedBox(),
                                                      address != null
                                                          ? Text(
                                                              "โทร : ${defaultAddress.phoneNumber!}",
                                                              style: const TextStyle(
                                                                fontSize: 12.0,
                                                                fontWeight: FontWeight.w300,
                                                                color: Colors.grey,
                                                              ),
                                                            )
                                                          : const SizedBox(),
                                                      address != null
                                                          ? Text(
                                                              "ที่อยู่ : ${defaultAddress.address!.address!} ถนน ${defaultAddress.address!.street!} อาคาร ${defaultAddress.address!.building!} แขวง/ตำบล ${defaultAddress.address!.district!} เขต/อำเภ ${defaultAddress.address!.amphure!} จังหวัดด ${defaultAddress.address!.province!} ${defaultAddress.address!.zipcode!}",
                                                              style: const TextStyle(
                                                                fontSize: 12.0,
                                                                fontWeight: FontWeight.w300,
                                                                color: Colors.grey,
                                                              ),
                                                            )
                                                          : const SizedBox(),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Icon(
                                            Icons.arrow_forward_ios,
                                            size: 14,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              NoteInput(controller: cartInputController!, focusNode: cartFocusNode, action: TextInputAction.done),
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
                                  checkOut();
                                },
                                child: const Text(
                                  "สั่งซื้อเลย",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 250),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
