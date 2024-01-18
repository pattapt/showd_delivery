import 'package:flutter/material.dart';
import 'package:showd_delivery/class/chodelivery.dart';
import 'package:showd_delivery/class/products.dart';
import 'package:showd_delivery/model/productV2.dart' as ProductModel;

class ProductItemFromList extends StatefulWidget {
  final List<ProductModel.Datum> productOfMerchant;
  final String merchantToken;
  const ProductItemFromList({Key? key, required this.productOfMerchant, required this.merchantToken}) : super(key: key);

  @override
  State<ProductItemFromList> createState() => _ProductItemFromListState();
}

class _ProductItemFromListState extends State<ProductItemFromList> {
  String removeHtmlTags(String htmlString) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlString.replaceAll(exp, '');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: ListView.builder(
            itemCount: (widget.productOfMerchant.length / 2).ceil(),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              int startIndex = index * 2;
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: buildProductCard(widget.productOfMerchant[startIndex], widget.merchantToken),
                      ),
                      SizedBox(width: 16.0), // Adjust the spacing between columns
                      Expanded(
                        child: (startIndex + 1 < widget.productOfMerchant.length) ? buildProductCard(widget.productOfMerchant[startIndex + 1], widget.merchantToken) : Container(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0), // Adjust the spacing between rows
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildProductCard(ProductModel.Datum data, String merchantToken) {
    return GestureDetector(
      onTap: () {
        Map<String, dynamic> datax = {
          "productToken": data.productToken,
          "merchantToken": merchantToken,
        };
        Navigator.pushNamed(context, '/ProductInfoPage', arguments: datax);
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Shadow color
              spreadRadius: 0.2, // Spread radius
              blurRadius: 0.3, // Blur radius
              offset: Offset(0, 0.1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Image.network(
                data.imageUrl!,
                height: 150.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    data.price!.toString() + " ฿",
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    data.name!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    softWrap: false,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    removeHtmlTags(data.description!),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    softWrap: false,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 11.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
