import 'package:flutter/material.dart';
import 'package:showd_delivery/class/chodelivery.dart';
import 'package:showd_delivery/model/TransactionDetail.dart';

class ItemInCart extends StatefulWidget {
  final Items? data;
  const ItemInCart({Key? key, required this.data}) : super(key: key);

  @override
  State<ItemInCart> createState() => _ItemInCartState();
}

class _ItemInCartState extends State<ItemInCart> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "รายการสินค้าที่สั่ง",
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
        ),
        const SizedBox(height: 10),
        ListView.builder(
          itemCount: (widget.data!.cart!.length).ceil(),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return buildItemListCart(widget.data!.cart![index]);
          },
        ),
        Text(
          "ราคารวม ${Chodee.convertPrice(double.parse(widget.data!.totalPrice!.toString()))} ฿",
          textAlign: TextAlign.right,
          style: const TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        const Divider(thickness: 0.3),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget buildItemListCart(Cart data) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        data.amount!.toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          data.product!.name!,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          data.note!,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "${Chodee.convertPrice(double.parse(data.totalPrice!.toString()))} ฿",
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
