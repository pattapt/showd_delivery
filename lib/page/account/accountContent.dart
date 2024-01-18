import 'package:flutter/material.dart';
import 'package:showd_delivery/class/auth.dart';
import 'package:showd_delivery/model/AccountProfile.dart';

class AccountContent extends StatefulWidget {
  const AccountContent({Key? key}) : super(key: key);
  @override
  State<AccountContent> createState() => _AccountContentState();
}

class _AccountContentState extends State<AccountContent> with TickerProviderStateMixin {
  final scrollController = ScrollController();
  String accountName = "";
  bool isLoading = true;
  late AccountProfileModel accountProfileModel;

  @override
  void initState() {
    super.initState();
    getAccountData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> getAccountData() async {
    AccountProfileModel x = await Auth.getProfile();
    setState(() {
      accountName = x.username!;
      isLoading = false;
      accountProfileModel = x;
    });
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
      onWillPop: () async => false,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(accountProfileModel.profileImageUrl ?? ""),
                ),
                const SizedBox(height: 16),
                Text(
                  "🖐🏻 $accountName",
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Text(
                  "เขียนแอพจนตี 4 วันที่ 12/12/2023 แล้วพรีเซ้น 9 โมง\nผมจะตุยคั้บจาร",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const Divider(
                  thickness: 0.3,
                ),
                const SizedBox(height: 16),
                const ActionCard(title: "แก้ไขที่อยู่", path: "/destination"),
                const ActionCard(title: "ออกจากระบบ", path: "/Logout"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ActionCard extends StatelessWidget {
  final String title;
  final String path;
  const ActionCard({super.key, required this.title, required this.path});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (path == "/Logout") {
                      Auth.setAccessToken("");
                      Auth.setIsLogin(false);
                      return;
                    }

                    Navigator.pushNamed(context, path);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 5),
              const Icon(
                Icons.arrow_forward_ios,
                size: 14,
              ),
            ],
          ),
          const Divider(thickness: 0.3),
          const SizedBox(height: 5)
        ],
      ),
    );
  }
}
