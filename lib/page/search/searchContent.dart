import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SearchContent extends StatefulWidget {
  const SearchContent({Key? key}) : super(key: key);
  @override
  State<SearchContent> createState() => _SearchContentState();
}

class _SearchContentState extends State<SearchContent> with TickerProviderStateMixin {
  final scrollController = ScrollController();
  final channel = WebSocketChannel.connect(
    Uri.parse('wss://socket.patta.dev/ec4c1f2f-e295-4f69-b028-ebe7d89e30ed:03e6b71a-9291-400e-81b8-11382f63a8a7'),
  );

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
        child: Center(
            child: StreamBuilder(
          stream: channel.stream,
          builder: (context, snapshot) {
            return Text(snapshot.hasData ? '${snapshot.data}' : '');
          },
        )));
  }
}
