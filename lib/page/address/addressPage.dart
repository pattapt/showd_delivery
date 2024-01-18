import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:showd_delivery/class/address.dart' as Ad;
import 'package:showd_delivery/model/Address.dart' as AddressModel;
import 'package:showd_delivery/widget/address/addressItemList.dart';

class addressPage extends StatefulWidget {
  const addressPage({Key? key}) : super(key: key);
  @override
  State<addressPage> createState() => _addressPageState();
}

class _addressPageState extends State<addressPage> with TickerProviderStateMixin {
  bool isLoading = true, isEndPage = false;
  final scrollController = ScrollController();
  final formKey = GlobalKey<FormState>();
  late List<AddressModel.AddressDetail>? address = [];

  int apiPage = 1, currentIndex = 0;

  @override
  void initState() {
    super.initState();
    getaddressPage();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getaddressPage() async {
    List<AddressModel.AddressDetail> x = await Ad.Address.getMyAddress();
    if (x != null) {
      setState(() {
        address = x;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text("ที่อยู่"),
          actions: [
            GestureDetector(
              onTap: () async {
                final result = await Navigator.pushNamed(context, '/addAddress', arguments: '');
                if (result is bool) {
                  getaddressPage();
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.center,
                child: const Text(
                  "เพิ่มที่อยู่",
                  style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              isLoading = true;
              apiPage = 1;
              address = [];
            });
            getaddressPage();
          },
          child: SingleChildScrollView(
            controller: scrollController,
            child: Container(
              color: Colors.white,
              width: double.infinity,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "สถานที่จัดส่ง",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Text(
                        "รายการสถานที่จัดส่งสินค้าของคุณ แตไ่ม่ว่าคุณจะอยู่ไหน ก็ไม่มีทางไปอยู่ในใจเขาได้หรอก",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Divider(thickness: 0.1),
                      AddressItemList(address: address, isEdit: false),
                      // const SizedBox(height: 80),
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
