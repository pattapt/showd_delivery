import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:showd_delivery/class/chodelivery.dart';
import 'package:showd_delivery/model/cartList.dart';
import 'package:showd_delivery/widget/input/note.dart';
import 'package:showd_delivery/widget/input/username.dart';
import 'package:flutter_html_v3/flutter_html.dart';

class CartEditPopUp extends StatefulWidget {
  final CartData? cart;
  final TextEditingController? noteController;
  final double pricePerOne;
  final int amount;
  final Function(bool) callback;
  final Function() saveData;
  const CartEditPopUp({Key? key, required this.cart, required this.noteController, required this.pricePerOne, required this.amount, required this.callback, required this.saveData}) : super(key: key);

  @override
  State<CartEditPopUp> createState() => _CartEditPopUpState();
}

class _CartEditPopUpState extends State<CartEditPopUp> {
  FocusNode usernameFocusNode = FocusNode();
  late int amount = widget.amount;
  late double totalPrice = widget.cart!.totalPrice!.toDouble();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: NetworkImage(widget.cart!.product!.imageUrl!),
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
                          widget.cart!.product!.name!,
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2.0),
                        const SizedBox(height: 2.0),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${Chodee.convertPrice(widget.pricePerOne.toDouble() * widget.amount)} ฿",
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 3.0),
                  Text(
                    "จำนวน ${widget.amount} ชิ้น",
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
          Html(data: widget.cart!.product!.description!),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Column(
              children: [
                NoteInput(controller: widget.noteController!, focusNode: usernameFocusNode, action: TextInputAction.done),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        widget.callback(false);
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey, // Set your desired border color
                            width: 0.5, // Set your desired border width
                          ),
                          borderRadius: BorderRadius.circular(10.0), // Set your desired border radius
                        ),
                        child: const Icon(
                          Icons.remove,
                          color: Colors.grey,
                          size: 30,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 100,
                      height: 50,
                      child: Center(
                        child: Text(
                          widget.amount.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        widget.callback(true);
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey, // Set your desired border color
                            width: 0.5, // Set your desired border width
                          ),
                          borderRadius: BorderRadius.circular(10.0), // Set your desired border radius
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.grey,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: widget.amount == 0 ? Colors.red : Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () {
                    widget.saveData();
                  },
                  child: Text(
                    widget.amount == 0 ? "ลบสินค้า" : "บันทึก",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
