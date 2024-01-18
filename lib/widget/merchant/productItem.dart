import 'package:flutter/material.dart';
import 'package:showd_delivery/class/chodelivery.dart';
import 'package:showd_delivery/class/products.dart';
import 'package:showd_delivery/class/products.dart';
import 'package:showd_delivery/model/categorylist.dart';
import 'package:showd_delivery/class/products.dart';
import 'package:showd_delivery/model/product.dart' as productModel;

class ProductItem extends StatefulWidget {
  final String categoryToken, merchantToken;
  const ProductItem({Key? key, required this.categoryToken, required this.merchantToken}) : super(key: key);

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  late bool isLoad = true;
  late List<productModel.Product> dataProduct = [];

  @override
  void initState() {
    super.initState();
    getProductData();
  }

  void getProductData() async {
    List<productModel.Product> x = await Product.getProductOfCategoryInMerchant(merchantToken: widget.merchantToken, categoryToken: widget.categoryToken, limit: 10);
    if (x != null) {
      setState(() {
        isLoad = false;
        dataProduct = x;
      });
    }
  }

  String removeHtmlTags(String htmlString) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlString.replaceAll(exp, '');
  }

  @override
  Widget build(BuildContext context) {
    if (isLoad) return Container();
    return Column(
      children: [
        Container(
          child: ListView.builder(
            itemCount: (dataProduct.length / 2).ceil(),
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
                        child: buildProductCard(dataProduct[startIndex], widget.merchantToken),
                      ),
                      SizedBox(width: 16.0), // Adjust the spacing between columns
                      Expanded(
                        child: (startIndex + 1 < dataProduct.length) ? buildProductCard(dataProduct[startIndex + 1], widget.merchantToken) : Container(),
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

  Widget buildProductCard(productModel.Product data, String merchantToken) {
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
