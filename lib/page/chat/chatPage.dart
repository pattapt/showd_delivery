import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:showd_delivery/class/chat.dart';
import 'package:showd_delivery/model/MessageList.dart';
import 'package:showd_delivery/widget/chat/BottomElement.dart';
import 'package:showd_delivery/widget/chat/chatbubble.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatPage extends StatefulWidget {
  final Map<String, dynamic> data;

  const ChatPage({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  late bool isLoading = true, isHaveChat = false;
  final scrollController = ScrollController();
  int page = 1;
  late bool showBag = true;
  List<Message> message = [];
  late WebSocketChannel channel;

  void listeningWS() {
    channel.stream.listen((message) {
      Message x = messageDetaillFromJson(message);
      debugPrint(jsonEncode(x));
      addMessage(x);
    });
  }

  void addMessage(Message x) {
    setState(() {
      message.insert(0, x);
    });
  }

  @override
  void initState() {
    super.initState();
    getMessage(page);
    scrollController.addListener(scrollListener);
  }

  void scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      // getProduct(page);
    }
  }

  Future<void> getMessage(int page) async {
    // GET MESSAGE FROM PAGE 1
    List<Message> x = await Chat.getMessage(chatToken: widget.data["chatToken"], page: page);
    if (x != null) {
      setState(() {
        isLoading = false;
        this.page++;
        message = x;
      });
      if (!isHaveChat) {
        setState(() {
          isHaveChat = true;
        });
      }
    }

    channel = WebSocketChannel.connect(
      Uri.parse('wss://socket.patta.dev/${widget.data["chatToken"]}:${widget.data["memberUUID"]}'),
    );
    listeningWS();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading)
      return Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Center(child: CircularProgressIndicator()),
      );
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: AppBar(
          title: Text("คำสั่งซื้อ #CHO1"),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: !isHaveChat
            ? Container(
                height: double.infinity,
                width: double.infinity,
                child: Center(
                  child: Column(
                    children: [
                      Lottie.asset(
                        "assets/animation/animation-not-found-merchant.json",
                        width: 350,
                        fit: BoxFit.fill,
                      ),
                      Text("ไม่พบข้อมูลที่คุณต้องการ โปรดลองใหม่ภายหลัง"),
                    ],
                  ),
                ))
            : Container(
                color: Colors.white,
                height: double.infinity,
                width: double.infinity,
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Container(
                        width: double.infinity,
                        child: Column(children: [
                          ChatBubble(chatList: message),
                        ]),
                      ),
                    ),
                    ChatBottm(chatToken: widget.data["chatToken"]),
                  ],
                ),
              ),
      ),
    );
  }
}
