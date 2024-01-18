import 'package:flutter/material.dart';
import 'package:showd_delivery/class/chodelivery.dart';
import 'package:showd_delivery/model/categorylist.dart';
import 'package:showd_delivery/widget/merchant/productItem.dart';

class CategoryItem extends StatefulWidget {
  final List<Category> category;
  final String? merchantToken;
  const CategoryItem({Key? key, required this.category, required this.merchantToken}) : super(key: key);

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 5),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.category!.length,
            itemBuilder: (context, index) {
              final item = widget.category![index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name ?? "",
                              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Text(
                              item.description ?? "",
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          Map<String, dynamic> data = {
                            "categoryToken": item.categoryToken,
                            "merchantToken": widget.merchantToken,
                          };
                          Chodee.openPage("/AllProductPage", data);
                        },
                        child: const Text(
                          'ดูทั้งหมด',
                          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ProductItem(categoryToken: item.categoryToken ?? "", merchantToken: widget.merchantToken ?? ""),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
