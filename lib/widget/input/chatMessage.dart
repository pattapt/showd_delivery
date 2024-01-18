import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatMessageInput extends StatefulWidget {
  final TextEditingController controller;
  final TextInputAction? action;
  final FocusNode? focusNode, nextFocusNode;
  const ChatMessageInput({Key? key, required this.controller, this.action, this.focusNode, this.nextFocusNode}) : super(key: key);
  @override
  State<ChatMessageInput> createState() => _ChatMessageInputState();
}

class _ChatMessageInputState extends State<ChatMessageInput> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(onListen);
  }

  @override
  void dispose() {
    widget.controller.removeListener(onListen);
    super.dispose();
  }

  void onListen() => setState(() {});

  @override
  Widget build(BuildContext context) => Theme(
      data: ThemeData(
        primaryColor: Colors.redAccent,
        primaryColorDark: Colors.red,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            style: GoogleFonts.getFont('Prompt'),
            controller: widget.controller,
            focusNode: widget.focusNode,
            onEditingComplete: () {
              if (widget.nextFocusNode != null) {
                FocusScope.of(context).requestFocus(widget.nextFocusNode);
              }
            },
            decoration: InputDecoration(
              hintText: 'พิมพ์ข้อความเลย',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              errorStyle: GoogleFonts.prompt(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.red,
              ),
            ),
            textInputAction: (widget.action != null) ? widget.action : TextInputAction.next,
            keyboardType: TextInputType.text,
            autofillHints: const [AutofillHints.email],
            autofocus: false,
          )
        ],
      ));
}
