import 'package:flutter/material.dart';
import 'package:showd_delivery/class/chodelivery.dart';
import 'package:showd_delivery/model/categorylist.dart';

class QuickManu extends StatefulWidget {
  final List<Category>? categoryData;
  final String merchantToken;
  const QuickManu({Key? key, required this.categoryData, required this.merchantToken}) : super(key: key);

  @override
  State<QuickManu> createState() => _QuickManuState();
}

class _QuickManuState extends State<QuickManu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.only(top: 5),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: (widget.categoryData!.length / 4).ceil(), // Calculate the number of rows
        itemBuilder: (context, rowIndex) {
          final startingIndex = rowIndex * 4;
          final endingIndex = startingIndex + 4;
          final rowItems = widget.categoryData!.sublist(startingIndex, endingIndex < widget.categoryData!.length ? endingIndex : widget.categoryData!.length);

          return Align(
            alignment: Alignment.centerLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: rowItems.map((item) {
                return Container(
                  width: MediaQuery.of(context).size.width / 4,
                  child: QuickMenuContent(
                    image: item.imageUrl ?? "",
                    title: item.name ?? "",
                    path: "/AllProductPage",
                    arg: item.categoryToken ?? "",
                    merchantToken: widget.merchantToken,
                    categoryToken: item.categoryToken ?? "",
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}

class QuickMenuContent extends StatelessWidget {
  const QuickMenuContent({
    super.key,
    required this.image,
    required this.title,
    required this.path,
    required this.arg,
    required this.merchantToken,
    required this.categoryToken,
  });

  final String image, arg, title, path, merchantToken, categoryToken;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          Map<String, dynamic> data = {
            "categoryToken": categoryToken,
            "merchantToken": merchantToken,
          };
          Chodee.openPage(path, data);
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(10.0),
              //   child: CachedNetworkImage(
              //     key: UniqueKey(),
              //     imageUrl: image,
              //     fit: BoxFit.cover,
              //     height: 45,
              //     width: 45,
              //   ),
              // ),
              const SizedBox(height: 5),
              const SizedBox(height: 1),
              Text(
                title,
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
