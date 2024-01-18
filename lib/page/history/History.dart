import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:showd_delivery/class/transaction.dart';
import 'package:showd_delivery/model/TransactionList.dart' as transactionModel;
import 'package:showd_delivery/widget/history/PurchaseTransactionItem.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({Key? key}) : super(key: key);
  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> with TickerProviderStateMixin {
  bool isLoading = true, isEndPage = false;
  final scrollController = ScrollController();
  final formKey = GlobalKey<FormState>();
  late List<transactionModel.Transaction>? dataTransaction = [];

  int apiPage = 1, currentIndex = 0;

  @override
  void initState() {
    super.initState();
    getTransactionHistory(apiPage);
    scrollController.addListener(scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getTransactionHistory(int index) async {
    List<transactionModel.Transaction> data = await Transaction.getAllTransactionList(page: index);
    if (data.isNotEmpty) {
      setState(() {
        dataTransaction!.addAll(data);
        isLoading = false;
        apiPage++;
      });
    } else {
      setState(() {
        isLoading = false;
        isEndPage = true;
      });
    }
  }

  void scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      getTransactionHistory(apiPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          automaticallyImplyLeading: false,
          title: const Text("ประวัติการทำรายการ"),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              isLoading = true;
              apiPage = 1;
              dataTransaction = [];
            });
            getTransactionHistory(apiPage);
          },
          child: SingleChildScrollView(
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
                        "ประวัติการสั่งซื้อสินค้า",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Text(
                        "คุณสามารถตรวจสอบสถานะคำสั่งซื้อ รวมถึงแชทกับเจ้าหน้าที่ร้านค้าได้ที่เมนูนี้",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Divider(thickness: 0.1),
                      PurchaseTransactionList(transaction: dataTransaction)
                      // const SizedBox(height: 80),
                    ],
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
