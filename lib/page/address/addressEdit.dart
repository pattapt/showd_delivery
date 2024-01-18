import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:showd_delivery/model/Address.dart' as AddressModel;
import 'package:showd_delivery/class/Address.dart' as Ad;
import 'package:showd_delivery/model/TransactionDetail.dart';
import 'package:showd_delivery/model/addAddress.dart';
import 'package:showd_delivery/widget/input/generalInput.dart';

class AddressEditPage extends StatefulWidget {
  final String addressToken;
  final bool isEdit;
  const AddressEditPage({Key? key, required this.addressToken, required this.isEdit}) : super(key: key);
  @override
  State<AddressEditPage> createState() => _AddressEditPageState();
}

class _AddressEditPageState extends State<AddressEditPage> with TickerProviderStateMixin {
  bool isLoading = true, isEndPage = false;
  final scrollController = ScrollController();
  final formKey = GlobalKey<FormState>();
  late TransactionDetail dataTransaction = TransactionDetail();
  late AddressModel.AddressDetail? address = AddressModel.AddressDetail();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController streetControler = TextEditingController();
  final TextEditingController buildingControler = TextEditingController();
  final TextEditingController zipcodeController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController districtController = TextEditingController();

  final FocusNode nameFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode addressFocusNode = FocusNode();
  final FocusNode streetFocusNode = FocusNode();
  final FocusNode buildingFocusNode = FocusNode();
  final FocusNode zipcodeFocusNode = FocusNode();
  final FocusNode noteFocusNode = FocusNode();
  final FocusNode districtFocusNode = FocusNode();

  int districtId = 0;

  int apiPage = 1, currentIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      getAddressEditPage();
    } else {
      setState(() {
        isLoading = false;
      });
    }
    districtFocusNode.addListener(() async {
      if (districtFocusNode.hasFocus) {
        districtFocusNode.unfocus();
        final result = await Navigator.of(context).pushNamed("/districtSearch", arguments: zipcodeController.text);
        print(result);
        if (result is Map<String, dynamic>) {
          setState(() {
            districtController.text = result["district"] + " > " + result["amphure"] + " > " + result["province"];
            districtId = result["id"];
          });
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getAddressEditPage() async {
    AddressModel.AddressDetail x = await Ad.Address.getAddressDetail(addressToken: widget.addressToken);
    if (x != null) {
      setState(() {
        address = x;
        nameController.text = address!.name!;
        phoneController.text = address!.phoneNumber!;
        addressController.text = address!.address!.address!;
        streetControler.text = address!.address!.street!;
        buildingControler.text = address!.address!.building!;
        zipcodeController.text = address!.address!.zipcode!;
        noteController.text = address!.note!;
        districtController.text = address!.address!.district! + " > " + address!.address!.amphure! + " > " + address!.address!.province!;
        districtId = address!.address!.districtId!;
        isLoading = false;
      });
    }
  }

  void saveData() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      bool x = await Ad.Address.updateAddress(
        addressToken: widget.addressToken,
        name: nameController.text,
        phoneNumber: phoneController.text,
        address: addressController.text,
        street: streetControler.text,
        building: buildingControler.text,
        district: districtId,
        zipCode: zipcodeController.text,
        note: noteController.text,
      );
      if (x) {
        Navigator.of(context).pop();
      }
    }
  }

  void CreateAddress() async {
    AddAddress x = await Ad.Address.createAddress(
      name: nameController.text,
      phoneNumber: phoneController.text,
      address: addressController.text,
      street: streetControler.text,
      building: buildingControler.text,
      district: districtId,
      zipCode: zipcodeController.text,
      note: noteController.text,
    );
    if (x.success!) {
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading)
      return Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
      );
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
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Text("ข้อมูลที่อยู่"),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              isLoading = true;
            });
            if (widget.isEdit) getAddressEditPage();
          },
          child: SingleChildScrollView(
            controller: scrollController,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 1000),
              child: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle.dark,
                child: Column(
                  children: [
                    SafeArea(
                      child: Form(
                        key: formKey,
                        child: Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                            child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                              // test
                              GeneralInput(controller: nameController, focusNode: nameFocusNode, nextFocusNode: phoneFocusNode, hintText: "กรุณาระบุชื่อ", title: "ชื่อผู้รับ"),
                              const SizedBox(height: 16),
                              GeneralInput(controller: phoneController, focusNode: phoneFocusNode, nextFocusNode: addressFocusNode, hintText: "กรุณาระบุเบอร์โทรศัพท์", title: "เบอร์โทรศัพท์"),
                              const SizedBox(height: 16),
                              GeneralInput(controller: addressController, focusNode: addressFocusNode, nextFocusNode: streetFocusNode, hintText: "กรุณาระบุที่อยู่", title: "ที่อยู่"),
                              const SizedBox(height: 16),
                              GeneralInput(controller: streetControler, focusNode: streetFocusNode, nextFocusNode: buildingFocusNode, hintText: "กรุณาระบุถนน", title: "ถนน"),
                              const SizedBox(height: 16),
                              GeneralInput(controller: buildingControler, focusNode: buildingFocusNode, nextFocusNode: zipcodeFocusNode, hintText: "กรุณาระบุอาคาร", title: "อาคาร"),
                              const SizedBox(height: 16),
                              GeneralInput(
                                controller: zipcodeController,
                                focusNode: zipcodeFocusNode,
                                nextFocusNode: districtFocusNode,
                                hintText: "กรุณาระบุหมายเลขไปรษณี",
                                title: "หมายเลขไปรษณี",
                              ),
                              const SizedBox(height: 16),
                              GeneralInput(controller: districtController, focusNode: districtFocusNode, nextFocusNode: noteFocusNode, hintText: "แขวงตำบล", title: "แขวงตำบล"),
                              const SizedBox(height: 16),
                              GeneralInput(controller: noteController, focusNode: noteFocusNode, action: TextInputAction.done, hintText: "โน๊ต", title: "โน๊ต"),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size.fromHeight(50),
                                  backgroundColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                onPressed: () {
                                  if (widget.isEdit) {
                                    saveData();
                                  } else {
                                    CreateAddress();
                                  }
                                },
                                child: Text(
                                  widget.isEdit ? "บันทึกข้อมูล" : "สร้างที่อยู่ใหม่",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            ]),
                          ),
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
    );
  }
}
