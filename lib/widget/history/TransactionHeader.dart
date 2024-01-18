import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HistoryTopBar extends StatefulWidget {
  final String title, transactionID;
  const HistoryTopBar({Key? key, required this.title, required this.transactionID}) : super(key: key);

  @override
  State<HistoryTopBar> createState() => _HistoryTopBarState();
}

class _HistoryTopBarState extends State<HistoryTopBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      color: Colors.grey[200],
      child: SafeArea(
        top: false,
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      widget.transactionID,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 2),
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: widget.transactionID));
                      },
                      child: const Icon(
                        Icons.copy,
                        color: Colors.blue,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
