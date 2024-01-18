import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:showd_delivery/class/chodelivery.dart';
import 'package:showd_delivery/model/DistrictDataTh.dart';
import 'package:showd_delivery/model/cartList.dart';
import 'package:showd_delivery/model/Address.dart' as AddressModel;

class DistrictListItem extends StatefulWidget {
  final List<DistrictDataTh>? district;
  const DistrictListItem({Key? key, required this.district}) : super(key: key);

  @override
  State<DistrictListItem> createState() => _DistrictListItemState();
}

class _DistrictListItemState extends State<DistrictListItem> {
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
          itemCount: widget.district!.length,
          itemBuilder: (context, index) {
            final item = widget.district![index];
            return Container(
              child: AddressCard(
                data: item,
                // callback: widget.callback,
              ),
            );
          },
        ),
      );
    }
  }
}

class AddressCard extends StatelessWidget {
  final DistrictDataTh data;
  const AddressCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: GestureDetector(
        onTap: () {
          Map<String, dynamic> datax = {
            "id": data.district!.districtId,
            "district": data.district!.nameTh!,
            "amphure": data.amphure!.nameTh!,
            "province": (data.province!.nameTh ?? ""),
          };
          Navigator.pop(context, datax);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    data.district!.nameTh! + " > " + data.amphure!.nameTh! + " > " + (data.province!.nameTh ?? ""),
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
                Icon(
                  Icons.check_circle,
                  size: 18,
                  color: Colors.black,
                ),
              ],
            ),
            const SizedBox(height: 5),
            Divider(thickness: 0.3),
          ],
        ),
      ),
    );
  }
}
