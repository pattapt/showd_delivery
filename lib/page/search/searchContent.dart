import 'package:flutter/material.dart';

class SearchContent extends StatefulWidget {
  const SearchContent({Key? key}) : super(key: key);
  @override
  State<SearchContent> createState() => _SearchContentState();
}

class _SearchContentState extends State<SearchContent> with TickerProviderStateMixin {
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
          child: Text("Hello world From Search"),
        ));
  }
}
