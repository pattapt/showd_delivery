import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:showd_delivery/class/chat.dart';
import 'package:showd_delivery/class/chodelivery.dart';
import 'package:showd_delivery/widget/input/chatMessage.dart';

class ChatBottm extends StatefulWidget {
  final String chatToken;
  const ChatBottm({Key? key, required this.chatToken}) : super(key: key);

  @override
  State<ChatBottm> createState() => _ChatBottmState();
}

class _ChatBottmState extends State<ChatBottm> {
  FocusNode focusNode = FocusNode();
  TextEditingController controller = TextEditingController();
  late bool isFocus = false;

  set image(File image) {}

  @override
  void initState() {
    super.initState();
    focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {
      isFocus = focusNode.hasFocus;
    });
  }

  void sendMessage() async {
    bool sendTextMessage = await Chat.sendTextMessage(chatToken: widget.chatToken, chatId: 0, text: controller.text);
    if (sendTextMessage) {
      controller.clear();
    }
  }

  Future pickImage(ImageSource s) async {
    try {
      final image = await ImagePicker().pickImage(source: s);
      if (image == null) return;

      final imageTemporary = File(image.path);
      String x = await Chodee.uploadImage("/api/store/v1/chat/${widget.chatToken}/SendImage", imageTemporary);
      debugPrint(x);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future<ImageSource?> showImageSource(BuildContext context) async {
    if (Platform.isIOS) {
      return showCupertinoModalPopup<ImageSource>(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              onPressed: () => Navigator.of(context).pop(ImageSource.camera),
              child: const Text("กล้องถ่ายรูป"),
            ),
            CupertinoActionSheetAction(
              onPressed: () => Navigator.of(context).pop(ImageSource.gallery),
              child: const Text("คลังภาพ"),
            ),
          ],
        ),
      );
    } else {
      return showModalBottomSheet(
          context: context,
          builder: (context) => Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.camera_alt),
                    title: const Text("กล้องถ่ายรูป"),
                    onTap: () => Navigator.of(context).pop(ImageSource.camera),
                  ),
                  ListTile(
                    leading: const Icon(Icons.camera_alt),
                    title: const Text("คลังภาพ"),
                    onTap: () => Navigator.of(context).pop(ImageSource.gallery),
                  ),
                ],
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey, width: 0.5),
          ),
        ),
        child: Card(
          elevation: 0,
          color: Colors.white,
          margin: const EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
          child: SafeArea(
            top: false,
            bottom: true,
            child: Container(
              color: Colors.white,
              child: SizedBox(
                width: 100,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: ChatMessageInput(
                        focusNode: focusNode,
                        controller: controller,
                        action: TextInputAction.done,
                      )),
                      const SizedBox(width: 10),
                      !isFocus
                          ? GestureDetector(
                              onTap: () async {
                                final source = await showImageSource(context);
                                if (source == null) return;
                                pickImage(source);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 211, 211, 211),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                width: 50,
                                height: 50,
                                child: const Icon(
                                  Icons.image,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : const SizedBox(width: 0),
                      !isFocus ? const SizedBox(width: 10) : const SizedBox(width: 0),
                      GestureDetector(
                        onTap: () {
                          sendMessage();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 31, 188, 36),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: 50,
                          height: 50,
                          child: const Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
