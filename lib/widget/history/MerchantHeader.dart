import 'package:flutter/material.dart';
import 'package:showd_delivery/class/chodelivery.dart';

class HistoryHeaderContent extends StatefulWidget {
  final String icon, title, subTitle, path;
  final String merchantUUID;
  final bool showGotoPage;
  const HistoryHeaderContent({Key? key, required this.icon, required this.title, required this.subTitle, this.path = "", required this.merchantUUID, this.showGotoPage = true}) : super(key: key);

  @override
  State<HistoryHeaderContent> createState() => _HistoryHeaderContentState();
}

class _HistoryHeaderContentState extends State<HistoryHeaderContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage(widget.icon),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          widget.subTitle,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (widget.showGotoPage) const SizedBox(width: 10),
                  if (widget.showGotoPage)
                    GestureDetector(
                      onTap: () {
                        Chodee.openPage(widget.path, widget.merchantUUID);
                      },
                      child: const Icon(
                        Icons.chevron_right_sharp,
                        color: Colors.grey,
                        size: 22,
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
