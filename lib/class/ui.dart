import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:showd_delivery/class/chodelivery.dart';

class GetImagePrivate extends StatefulWidget {
  final String imageUrl;
  final double? width, height;

  const GetImagePrivate({Key? key, required this.imageUrl, this.width = 200, this.height = 200}) : super(key: key);

  @override
  _GetImagePrivateState createState() => _GetImagePrivateState();
}

class _GetImagePrivateState extends State<GetImagePrivate> {
  late Future<List<int>> _imageFuture;
  Uint8List? _imageBytes;

  @override
  void initState() {
    super.initState();
    _imageFuture = Chodee.getImagePrivate(widget.imageUrl);
    _imageFuture.then((imageBytes) {
      if (mounted) {
        setState(() {
          _imageBytes = Uint8List.fromList(imageBytes);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _imageBytes != null
        ? _buildContainer()
        : FutureBuilder<List<int>>(
            future: _imageFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                final imageBytes = snapshot.data!;
                _imageBytes = Uint8List.fromList(imageBytes);
                return _buildContainer();
              } else if (snapshot.hasError) {
                return Text('ไม่สามารถแสดงผลรูปภาพได้ในขณะนี้ โปรดลองใหม่อีกครั้งภายหลัง');
              } else {
                return CircularProgressIndicator();
              }
            },
          );
  }

  Widget _buildContainer() {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: MemoryImage(
            _imageBytes!,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.red.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDescriptionBadge extends StatelessWidget {
  final String description;

  const CustomDescriptionBadge({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey[100],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          description,
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

class BarIndicatorForSlidePanel extends StatelessWidget {
  const BarIndicatorForSlidePanel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 5,
          width: 50,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

class GetImagePrivateV2 extends StatefulWidget {
  final String imageUrl;
  final double? width, height;

  const GetImagePrivateV2({Key? key, required this.imageUrl, this.width = 200, this.height = 200}) : super(key: key);

  @override
  _GetImagePrivateV2State createState() => _GetImagePrivateV2State();
}

class _GetImagePrivateV2State extends State<GetImagePrivateV2> {
  late Future<List<int>> _imageFuture;
  Uint8List? _imageBytes;

  @override
  void initState() {
    super.initState();
    _imageFuture = Chodee.getImagePrivate(widget.imageUrl);
    _imageFuture.then((imageBytes) {
      if (mounted) {
        setState(() {
          _imageBytes = Uint8List.fromList(imageBytes);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _imageBytes != null
        ? _buildImageWidget()
        : FutureBuilder<List<int>>(
            future: _imageFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                final imageBytes = snapshot.data!;
                _imageBytes = Uint8List.fromList(imageBytes);
                return _buildImageWidget();
              } else if (snapshot.hasError) {
                return Text('ไม่สามารถแสดงผลรูปภาพได้ในขณะนี้ โปรดลองใหม่อีกครั้งภายหลัง');
              } else {
                return CircularProgressIndicator();
              }
            },
          );
  }

  Widget _buildImageWidget() {
    return Image.memory(
      _imageBytes!,
      width: 300,
      fit: BoxFit.cover,
    );
  }
}
