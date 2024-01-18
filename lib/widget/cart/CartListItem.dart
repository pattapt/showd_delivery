import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:showd_delivery/class/chodelivery.dart';
import 'package:showd_delivery/model/cartList.dart';

class CartListItem extends StatefulWidget {
  final List<CartData>? cart;
  final Function(CartData) callback;
  const CartListItem({Key? key, required this.cart, required this.callback}) : super(key: key);

  @override
  State<CartListItem> createState() => _CartListItemState();
}

class _CartListItemState extends State<CartListItem> {
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
          itemCount: widget.cart!.length,
          itemBuilder: (context, index) {
            final item = widget.cart![index];
            return Container(
              child: CartItem(
                data: item,
                callback: widget.callback,
              ),
            );
          },
        ),
      );
    }
  }
}

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.data, required this.callback});
  final CartData data;
  final Function(CartData) callback;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return GestureDetector(
      onTap: () {
        callback(data);
      },
      child: Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: NetworkImage(data.product!.imageUrl!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.product!.name!,
                            style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 2.0),
                          Wrap(
                            children: [
                              Text(
                                "โน๊ต : ${data.note!}",
                                style: const TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2.0),
                        ],
                      ),
                      const Text(
                        "แก้ไขข้อมูล",
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 5.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      Chodee.convertPrice(data.totalPrice!.toDouble()) + " ฿",
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 3.0),
                    Text(
                      "จำนวน ${data.amount!} ชิ้น",
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 5.0),
            const Divider(thickness: 0.1),
          ],
        ),
      ),
    );
  }
}
