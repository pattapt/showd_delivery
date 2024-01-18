import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:showd_delivery/class/chodelivery.dart';
import 'package:showd_delivery/class/transaction.dart';
import 'package:showd_delivery/class/ui.dart';
import 'package:showd_delivery/model/TransactionDetail.dart';
import 'package:showd_delivery/model/TransactionList.dart' as transactionModel;
import 'package:showd_delivery/widget/history/Destination.dart';
import 'package:showd_delivery/widget/history/ItemList.dart';
import 'package:showd_delivery/widget/history/MerchantHeader.dart';
import 'package:showd_delivery/widget/history/PaymentInfo.dart';
import 'package:showd_delivery/widget/history/StatusBadge.dart';
import 'package:showd_delivery/widget/history/TransactionHeader.dart';

class TransactionHistoryDetail extends StatefulWidget {
  final String orderToken;
  const TransactionHistoryDetail({Key? key, required this.orderToken}) : super(key: key);
  @override
  State<TransactionHistoryDetail> createState() => _TransactionHistoryDetailState();
}

class _TransactionHistoryDetailState extends State<TransactionHistoryDetail> with TickerProviderStateMixin {
  bool isLoading = true, isEndPage = false;
  final scrollController = ScrollController();
  final formKey = GlobalKey<FormState>();
  late TransactionDetail dataTransaction = TransactionDetail();

  int apiPage = 1, currentIndex = 0;

  @override
  void initState() {
    super.initState();
    getTransactionHistoryDetail();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getTransactionHistoryDetail() async {
    TransactionDetail x = await Transaction.getTransactionDetail(orderToken: widget.orderToken);
    setState(() {
      dataTransaction = x;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading)
      return Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
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
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Text("รายการสั่งซื้อ"),
          actions: [
            GestureDetector(
              onTap: () {
                Map<String, dynamic> datax = {
                  "chatToken": dataTransaction.chat!.chatToken!,
                  "memberUUID": dataTransaction.chatProfile!.memberUUID!,
                };
                Chodee.openPage("/chat", datax);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.center,
                child: const Text(
                  "แชทกับร้านค้า",
                  style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              isLoading = true;
            });
            getTransactionHistoryDetail();
          },
          child: SingleChildScrollView(
            controller: scrollController,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 1000),
              child: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle.dark,
                child: Column(
                  children: [
                    HistoryTopBar(title: "คำสั่งซื้อ", transactionID: "#CHO${dataTransaction.orderId!}"),
                    SafeArea(
                      child: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              HistoryHeaderContent(
                                  icon: dataTransaction.merchant!.imageUrl!,
                                  title: dataTransaction.merchant!.name!,
                                  subTitle: dataTransaction.merchant!.description!,
                                  path: "/merchant",
                                  merchantUUID: dataTransaction.merchant!.merchantUuid!),
                              const SizedBox(height: 5),
                              const Divider(thickness: 0.5),
                              PurchaseStatusBade(status: dataTransaction.status!),
                              const SizedBox(height: 10),
                              dataTransaction.status == "preparing" ? PaymentInfo(OrderUUID: dataTransaction.orderToken!) : Container(),
                              const SizedBox(height: 10),
                              Text(
                                "ข้อความถึงร้านค้า",
                                textAlign: TextAlign.left,
                                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                dataTransaction.note!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 10),
                              ItemInCart(data: dataTransaction.items!),
                              AddressDestination(data: dataTransaction.destination!),
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
                                  Map<String, dynamic> datax = {
                                    "chatToken": dataTransaction.chat!.chatToken!,
                                    "memberUUID": dataTransaction.chatProfile!.memberUUID!,
                                  };
                                  Chodee.openPage("/chat", datax);
                                },
                                child: const Text(
                                  "แชทกับร้านค้า",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              // const SizedBox(height: 10),
                              // CustomAlertBadge(
                              //     title: "หมายเหตุคำสั่งซื้อ", description: purchaseData.note!),
                              // const SizedBox(height: 10),
                              // if (purchaseData.orderData!.isNotEmpty)
                              //   CardPinGenerator(list: purchaseData.orderData!),
                              // if (purchaseData.status == purchaseModel.Status.WAITFORPAY &&
                              //     purchaseData.payment!.paymentStatus ==
                              //         topupModel.PaymentStatus.PENDING)
                              //   PaymentInfoContent(
                              //       transactionPayment: purchaseData.payment!,
                              //       tutorialfunction: openPanel),
                              // if (purchaseData.status == purchaseModel.Status.WAITFORPAY &&
                              //     purchaseData.payment!.paymentStatus ==
                              //         topupModel.PaymentStatus.FAILED)
                              //   const CustomErrorDescriptionBadge(
                              //       description:
                              //           "การชำระเงินของคุณถูกยกเลิกแล้ว หากคุณกำลังทำการชำระเงินอยู่ โปรดหยุดการชำระเงิน แล้วสร้างรายการสั่งซื้อสินค้าใหม่อีกครั้ง"),
                              // if (purchaseData.status == purchaseModel.Status.WAITFORPAY &&
                              //     purchaseData.payment!.paymentStatus ==
                              //         topupModel.PaymentStatus.SUCCESS)
                              //   const CustomDescriptionBadge(
                              //       description:
                              //           "การชำระเงินของคุณได้รับการยืนยันแล้ว โปรดรอสักครู่เพื่อดำเนินการจัดส่งสินค้าให้กับคุณ"),
                              // const SizedBox(height: 10),
                              // PurchaseHistoryPricingPreview(
                              //     data: purchaseData.summary!,
                              //     methodName: purchaseData.payment!.methodTh!),
                              // const SizedBox(height: 10),
                              // ElementGenerator(list: purchaseData.list!),
                              // const SizedBox(height: 10),
                              // CustomAlertBadge(
                              //     title: "รายละเอียดการสั่งซื้อสินค้า",
                              //     description: widget.generic.data!.message!.purchaseInfoDetail!),
                              // const SizedBox(height: 130),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
