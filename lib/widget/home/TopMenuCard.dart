import 'package:flutter/material.dart';

class TopMenuCard extends StatefulWidget {
  const TopMenuCard({Key? key}) : super(key: key);
  @override
  State<TopMenuCard> createState() => _TopMenuCardState();
}

class _TopMenuCardState extends State<TopMenuCard> with TickerProviderStateMixin {
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(20.0), // Border radius
        ),
        width: double.infinity,
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 60, // Adjust the width and height as needed
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white, // Border color
                        width: 2, // Border width
                      ),
                    ),
                    child: ClipOval(
                      child: Image.network(
                        "https://news.mthai.com/app/uploads/2018/04/29-09-16-1.jpg",
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0), // Border radius
                      ),
                      width: double.infinity,
                      height: 65,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
