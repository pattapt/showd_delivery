import 'package:flutter/material.dart';
import 'package:showd_delivery/class/products.dart';
import 'package:showd_delivery/model/MerchantList.dart';

class AllMerchantCard extends StatefulWidget {
  const AllMerchantCard({Key? key}) : super(key: key);
  @override
  State<AllMerchantCard> createState() => _AllMerchantCardState();
}

class _AllMerchantCardState extends State<AllMerchantCard> with TickerProviderStateMixin {
  bool isLoad = true;
  List<MerchantDetail> dataMerchant = [];
  @override
  void initState() {
    super.initState();
    getMerchantData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getMerchantData() async {
    MerchantList x = await Product.getMerchant();
    setState(() {
      isLoad = false;
      dataMerchant = x.merchants!;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoad) return Container();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "เลือกร้านค้าที่ต้องการสั่งซื้อสินค้าได้เลย",
          textAlign: TextAlign.start,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Text(
          "เลือกซื้อสินต้าจากร้านไหนก็ได้ ขอแค่คุณมีเงินพอก็โอเคแล้ว",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
        ),
        const SizedBox(height: 16.0),
        ListView.builder(
          itemCount: (dataMerchant.length / 2).ceil(),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            int startIndex = index * 2;
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: buildMerchantCard(dataMerchant[startIndex]),
                    ),
                    SizedBox(width: 16.0), // Adjust the spacing between columns
                    Expanded(
                      child: (startIndex + 1 < dataMerchant.length) ? buildMerchantCard(dataMerchant[startIndex + 1]) : Container(),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0), // Adjust the spacing between rows
              ],
            );
          },
        ),
      ],
    );
  }

  Widget buildMerchantCard(MerchantDetail merchant) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/merchant', arguments: merchant.uuid);
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Image.network(
                merchant.imageUrl!,
                height: 150.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  merchant.name!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 2.0),
                Text(
                  merchant.description!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  softWrap: false,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
