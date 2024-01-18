import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:showd_delivery/class/chodelivery.dart';
import 'package:showd_delivery/model/TransactionList.dart' as transactionModel;

class PurchaseTransactionList extends StatefulWidget {
  final List<transactionModel.Transaction>? transaction;
  const PurchaseTransactionList({Key? key, required this.transaction}) : super(key: key);

  @override
  State<PurchaseTransactionList> createState() => _PurchaseTransactionListState();
}

class _PurchaseTransactionListState extends State<PurchaseTransactionList> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container();
    } else {
      return Container(
        child: ListView.builder(
          padding: EdgeInsets.only(top: 5),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.transaction!.length,
          itemBuilder: (context, index) {
            final item = widget.transaction![index];
            return Container(
              child: PurchaseItem(
                data: item,
              ),
            );
          },
        ),
      );
    }
  }
}

class PurchaseItem extends StatelessWidget {
  const PurchaseItem({super.key, required this.data});
  final transactionModel.Transaction data;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final isToday = data.createDate!.year == now.year && data.createDate!.month == now.month && data.createDate!.day == now.day;

    return GestureDetector(
      onTap: () {
        Chodee.openPage("/PurchaseInfoPage", data.orderToken);
      },
      child: Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: NetworkImage(data.merchant!.imageUrl!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.merchant!.name!,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2.0),
                      Wrap(
                        children: [
                          Text(
                            "#CHO${data.orderId.toString()}",
                            style: const TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(width: 5.0, height: 5),
                          Text(
                            data.status == "preparing"
                                ? "รับออเดอร์แล้ว"
                                : data.status == "waiting_for_delivery"
                                    ? "กำลังเตรียมสินค้า"
                                    : data.status == "on_the_way"
                                        ? "กำลังจัดส่งสินค้า"
                                        : data.status == "done"
                                            ? "จัดส่งสำเร็จ"
                                            : data.status == "failed"
                                                ? "ยกเลิกคำสั่งซื้อ"
                                                : "สถานะไม่ทราบ",
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600,
                              color: data.status == "preparing"
                                  ? Colors.yellow[700]
                                  : data.status == "waiting_for_delivery"
                                      ? Colors.yellow[700]
                                      : data.status == "on_the_way"
                                          ? Colors.blue
                                          : data.status == "done"
                                              ? Colors.green
                                              : data.status == "failed"
                                                  ? Colors.red
                                                  : Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${data.totalPay!} ฿",
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 3.0),
                    Text(
                      isToday ? DateFormat('HH:mm').format(data.createDate!) : DateFormat('dd/MM/yy').format(data.createDate!),
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 5.0),
            const Divider(thickness: 0.1),
          ],
        ),
      ),
    );
  }
}
