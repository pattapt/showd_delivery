import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:showd_delivery/class/address.dart' as Ad;
import 'package:showd_delivery/model/Address.dart' as AddressModel;
import 'package:showd_delivery/model/DistrictDataTh.dart';
import 'package:showd_delivery/widget/address/districtListItem.dart';

class DistrictListPage extends StatefulWidget {
  final String zipcode;
  const DistrictListPage({Key? key, required this.zipcode}) : super(key: key);
  @override
  State<DistrictListPage> createState() => _DistrictListPageState();
}

class _DistrictListPageState extends State<DistrictListPage> with TickerProviderStateMixin {
  bool isLoading = true, isEndPage = false;
  final scrollController = ScrollController();
  final formKey = GlobalKey<FormState>();
  late List<DistrictDataTh>? district = [];

  int apiPage = 1, currentIndex = 0;

  @override
  void initState() {
    super.initState();
    getDistrictListPage(apiPage);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getDistrictListPage(int index) async {
    List<DistrictDataTh> x = await Ad.Address.getDristrictFromZipcode(zipcode: widget.zipcode);
    if (x != null) {
      setState(() {
        district = x;
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
          title: const Text("เลือกตำบลของคุณ"),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              isLoading = true;
              district = [];
            });
            getDistrictListPage(apiPage);
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
                      Text(
                        "ตำบลจากหมายเลขไปรษณีย์ ${widget.zipcode}",
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Text(
                        "ไปรษณียังมาส่งของ แล้วคนของน้องส่งใจให้บ้างหรือยัง",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Divider(thickness: 0.1),
                      DistrictListItem(district: district),
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
