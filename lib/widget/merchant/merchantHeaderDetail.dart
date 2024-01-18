import 'package:flutter/material.dart';
import 'package:showd_delivery/model/MerchantList.dart';

class MerchantHeaderDetail extends StatefulWidget {
  final MerchantDetail? merchantData;
  final bool showInfoBTN;
  const MerchantHeaderDetail({Key? key, required this.merchantData, this.showInfoBTN = false}) : super(key: key);

  @override
  State<MerchantHeaderDetail> createState() => _MerchantHeaderDetailState();
}

class _MerchantHeaderDetailState extends State<MerchantHeaderDetail> {
  bool isLoading = true;
  String title = "";
  String subTitle = "";
  String icon = "";
  bool isOnlyPrimary = false;
  String deliveryType = "";
  @override
  void initState() {
    setState(() {
      isLoading = false;
      title = widget.merchantData!.name!;
      subTitle = widget.merchantData!.description!;
      icon = widget.merchantData!.imageUrl!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container();
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 65,
                height: 65,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: NetworkImage(icon),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            subTitle,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      );
    }
  }
}
