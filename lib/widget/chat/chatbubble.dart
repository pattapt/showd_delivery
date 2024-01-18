import 'package:flutter/material.dart';
import 'package:showd_delivery/class/ui.dart';
import 'package:showd_delivery/model/MerchantList.dart';
import 'package:showd_delivery/model/MessageList.dart';

class ChatBubble extends StatefulWidget {
  final List<Message> chatList;
  const ChatBubble({Key? key, required this.chatList}) : super(key: key);
  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          itemCount: (widget.chatList.length).ceil(),
          shrinkWrap: true,
          reverse: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            Message chat = widget.chatList[index];
            if (chat.type == Type.MESSAGE_RECEIVE) {
              if (chat.message!.messageType == MessageType.MESSAGE) {
                return ChatBubbleLeft(message: chat.message!.message!);
              } else {
                return ChatImageBubbleLeft(imageURL: chat.message!.message!);
              }
            }

            if (chat.type == Type.MESSAGE_SEND) {
              if (chat.message!.messageType == MessageType.MESSAGE) {
                return ChatBubbleRight(message: chat.message!.message!);
              } else {
                return ChatImageBubbleRight(imageURL: chat.message!.message!);
              }
            }
          },
        ),
        const SizedBox(height: 100),
      ],
    );
  }
}

class ChatImageBubbleLeft extends StatelessWidget {
  final String imageURL;

  const ChatImageBubbleLeft({
    Key? key,
    required this.imageURL,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 0, 179, 244),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: GetImagePrivateV2(imageUrl: imageURL),
        ),
      ],
    );
  }
}

class ChatBubbleLeft extends StatelessWidget {
  final String message;

  const ChatBubbleLeft({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          width: 300,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 0, 179, 244),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              message,
              textAlign: TextAlign.start,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

class ChatImageBubbleRight extends StatelessWidget {
  final String imageURL;

  const ChatImageBubbleRight({
    Key? key,
    required this.imageURL,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 0, 179, 244),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: GetImagePrivateV2(imageUrl: imageURL),
        ),
      ],
    );
  }
}

class ChatBubbleRight extends StatelessWidget {
  final String message;

  const ChatBubbleRight({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          width: 300,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 69, 69, 69),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              message,
              textAlign: TextAlign.end,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
