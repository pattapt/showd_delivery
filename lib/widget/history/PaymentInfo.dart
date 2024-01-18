import 'package:flutter/material.dart';
import 'package:showd_delivery/class/ui.dart';
import 'package:showd_delivery/model/TransactionDetail.dart';

class PaymentInfo extends StatefulWidget {
  final String OrderUUID;
  const PaymentInfo({Key? key, required this.OrderUUID}) : super(key: key);

  @override
  State<PaymentInfo> createState() => _PaymentInfoState();
}

class _PaymentInfoState extends State<PaymentInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "กรุณาทำการชำระเงิน",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 5),
        GetImagePrivate(imageUrl: "https://mobile-api-gateway.patta.dev/api/store/v1/transaction/${widget.OrderUUID}/QR", width: 200, height: 200),
        const SizedBox(height: 5),
        const CustomDescriptionBadge(description: "ใช้แอพพลิดเคชั่นธนาคารทำการสแกน QR CODE ที่ปรากฏเพื่อทำการชำระเงิน จากนั้นส่งให้เจ้าหน้าที่ตรวจสอบในแชทได้เลยค่ะ !")
      ],
    );
  }
}
