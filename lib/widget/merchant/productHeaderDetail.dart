import 'package:flutter/material.dart';
import 'package:showd_delivery/class/chodelivery.dart';
import 'package:showd_delivery/model/MerchantList.dart';
import 'package:showd_delivery/model/product.dart' as productModel;

class ProductHeaderDetail extends StatefulWidget {
  final productModel.Product? productData;
  final bool showInfoBTN;
  const ProductHeaderDetail({Key? key, required this.productData, this.showInfoBTN = false}) : super(key: key);

  @override
  State<ProductHeaderDetail> createState() => _ProductHeaderDetailState();
}

class _ProductHeaderDetailState extends State<ProductHeaderDetail> {
  bool isLoading = true;
  String title = "";
  String subTitle = "";
  String icon = "";
  bool isOnlyPrimary = false;
  String deliveryType = "";
  double price = 0.0;
  @override
  void initState() {
    setState(() {
      isLoading = false;
      title = widget.productData!.name!;
      subTitle = widget.productData!.description!;
      icon = widget.productData!.imageUrl!;
      price = widget.productData!.price!.toDouble();
    });
    super.initState();
  }

  String removeHtmlTags(String htmlString) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlString.replaceAll(exp, '');
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container();
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "ราคา ${Chodee.convertPrice(double.parse(price.toString()))} ฿",
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                            removeHtmlTags(subTitle),
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
