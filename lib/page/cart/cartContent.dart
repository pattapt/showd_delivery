import 'package:flutter/material.dart';

class CartContent extends StatefulWidget {
  const CartContent({Key? key}) : super(key: key);
  @override
  State<CartContent> createState() => _CartContentState();
}

class _CartContentState extends State<CartContent> with TickerProviderStateMixin {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: const Center(
          child: Text("Hello world From Cart"),
        ));
  }
}
