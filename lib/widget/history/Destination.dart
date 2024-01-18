import 'package:flutter/material.dart';
import 'package:showd_delivery/model/TransactionDetail.dart';

class AddressDestination extends StatefulWidget {
  final Destination data;
  const AddressDestination({Key? key, required this.data}) : super(key: key);

  @override
  State<AddressDestination> createState() => _AddressDestinationState();
}

class _AddressDestinationState extends State<AddressDestination> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "ข้อมูลผู้รับสินค้า",
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
        ),
        const SizedBox(height: 3),
        Text(
          widget.data.name!,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        Text(
          'โทร : ${widget.data.phoneNumber!}',
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          "ที่อยู่",
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
        ),
        const SizedBox(height: 3),
        Text(
          "เลขที่ ${widget.data.address!.address!} อาคาร ${widget.data.address!.building!} ถนน ${widget.data.address!.street!} แขวง ${widget.data.address!.district!} เขต ${widget.data.address!.address!} จังหวัด ${widget.data.address!.province!} รหัสไปรษณีย์ ${widget.data.address!.zipcode!}",
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
