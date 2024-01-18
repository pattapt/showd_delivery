import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:showd_delivery/class/chodelivery.dart';
import 'package:showd_delivery/model/cartList.dart';
import 'package:showd_delivery/model/Address.dart' as AddressModel;

class AddressItemList extends StatefulWidget {
  final List<AddressModel.AddressDetail>? address;
  final bool isEdit;
  const AddressItemList({Key? key, required this.address, required this.isEdit}) : super(key: key);

  @override
  State<AddressItemList> createState() => _AddressItemListState();
}

class _AddressItemListState extends State<AddressItemList> {
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
          itemCount: widget.address!.length,
          itemBuilder: (context, index) {
            final item = widget.address![index];
            return Container(
              child: AddressCard(
                data: item,
                // callback: widget.callback,
                isEdit: widget.isEdit,
              ),
            );
          },
        ),
      );
    }
  }
}

class AddressCard extends StatelessWidget {
  final AddressModel.AddressDetail data;
  final bool isEdit;
  const AddressCard({super.key, required this.data, required this.isEdit});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (isEdit) {
                      Navigator.pushNamed(context, '/editAddress', arguments: data.destinationToken);
                    } else {
                      Navigator.pop(context, data.destinationId);
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.name!,
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "โทร : ${data.phoneNumber!}",
                        style: const TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "ที่อยู่ : ${data.address!.address!} ถนน ${data.address!.street!} อาคาร ${data.address!.building!} แขวง/ตำบล ${data.address!.district!} เขต/อำเภ ${data.address!.amphure!} จังหวัดด ${data.address!.province!} ${data.address!.zipcode!}",
                        style: const TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 5),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/editAddress', arguments: data.destinationToken);
                },
                child: const Icon(
                  Icons.settings,
                  size: 18,
                ),
              ),
            ],
          ),
          const Divider(thickness: 0.3),
          const SizedBox(height: 5)
        ],
      ),
    );
  }
}
