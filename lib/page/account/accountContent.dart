import 'package:flutter/material.dart';

class AccountContent extends StatefulWidget {
  const AccountContent({Key? key}) : super(key: key);
  @override
  State<AccountContent> createState() => _AccountContentState();
}

class _AccountContentState extends State<AccountContent> with TickerProviderStateMixin {
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
          child: Text("Hello world From Account"),
        ));
  }
}
