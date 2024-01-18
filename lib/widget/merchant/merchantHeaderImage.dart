import 'package:flutter/material.dart';

class MerchantHeaderImage extends StatefulWidget {
  final ScrollController scrollController;
  final Image? image;
  const MerchantHeaderImage({Key? key, required this.scrollController, required this.image}) : super(key: key);

  @override
  State<MerchantHeaderImage> createState() => _MerchantHeaderImageState();
}

class _MerchantHeaderImageState extends State<MerchantHeaderImage> {
  double height = 300;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.scrollController.addListener(scrollListener);
  }

  void scrollListener() {
    if (widget.scrollController.offset < 0) {
      setState(() {
        height = 300 + (widget.scrollController.offset * (-1));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      child: widget.image,
    );
  }
}
