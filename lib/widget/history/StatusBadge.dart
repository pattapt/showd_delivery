import 'package:flutter/material.dart';

class PurchaseStatusBade extends StatefulWidget {
  final String status;
  const PurchaseStatusBade({Key? key, required this.status}) : super(key: key);

  @override
  State<PurchaseStatusBade> createState() => _PurchaseStatusBadeState();
}

class _PurchaseStatusBadeState extends State<PurchaseStatusBade> {
  @override
  Widget build(BuildContext context) {
    return widget.status == "preparing"
        ? IntrinsicWidth(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Container(
                color: Colors.yellow[800],
                child: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.add_circle_outline_sharp,
                        color: Colors.black,
                        size: 14,
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        "รับออเดอร์แล้ว",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : widget.status == "failed"
            ? IntrinsicWidth(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Container(
                    color: Colors.red,
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.close_sharp,
                            color: Colors.white,
                            size: 14,
                          ),
                          SizedBox(width: 5.0),
                          Text(
                            "ยกเลิกคำสั่งซื้อ",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : widget.status == "waiting_for_delivery"
                ? IntrinsicWidth(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Container(
                        color: Colors.yellow[700],
                        child: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.shopping_bag,
                                color: Colors.white,
                                size: 14,
                              ),
                              SizedBox(width: 5.0),
                              Text(
                                "กำลังเตรียมสินค้า",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : widget.status == "on_the_way"
                    ? IntrinsicWidth(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: Container(
                            color: Colors.blue,
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.motorcycle,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                  SizedBox(width: 5.0),
                                  Text(
                                    "กำลังจัดส่ง",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : widget.status == "done"
                        ? IntrinsicWidth(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                              child: Container(
                                color: Colors.green,
                                child: const Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.check_circle_sharp,
                                        color: Colors.white,
                                        size: 14,
                                      ),
                                      SizedBox(width: 5.0),
                                      Text(
                                        "จัดส่งแล้ว",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : widget.status == "failed"
                            ? IntrinsicWidth(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: Container(
                                    color: Colors.red,
                                    child: const Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.close_sharp,
                                            color: Colors.white,
                                            size: 14,
                                          ),
                                          SizedBox(width: 5.0),
                                          Text(
                                            "ยกเลิกคำสั่งซื้อ",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : IntrinsicWidth(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: Container(
                                    color: Colors.green[600],
                                    child: const Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.check_circle_sharp,
                                            color: Colors.white,
                                            size: 14,
                                          ),
                                          SizedBox(width: 5.0),
                                          Text(
                                            "---",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
  }
}
