import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:crypto/crypto.dart';
import 'package:http_certificate_pinning/http_certificate_pinning.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showd_delivery/class/auth.dart';
import 'package:showd_delivery/main.dart';

class Chodee {
  static String baseApiUrl = "https://mobile-api-gateway.patta.dev";
  static List<String> allowedShA1FingerprintList = ['3E F6 79 70 3A 4F D7 49 03 0C 59 51 A0 A7 5B EC F3 20 65 57'];
  static String secretKey = "t8M3fCfT8B5X9tPqRYtSZMeyLdnQMLZ5PNRMPZmuC0qM1xtcxD";
  static BuildContext? context = navigatorKey.currentContext!;
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  static const String appVersion = "1.0.0";

  static Future<Map<String, String>> generateDefaultHeader() async {
    final prefs = await SharedPreferences.getInstance();
    String? lat, lng, place, local, city, province, code, country, countryCode;
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      Position position = await getCurrentPosition();
      Placemark placemark = await getAddressFromPosition(position);
      lat = position.latitude.toString();
      lng = position.longitude.toString();
      place = placemark.name.toString();
      local = placemark.locality.toString();
      city = placemark.subAdministrativeArea.toString();
      province = placemark.administrativeArea.toString();
      code = placemark.postalCode.toString();
      country = placemark.country.toString();
      countryCode = placemark.isoCountryCode.toString();
    }
    return <String, String>{
      'x-geo-position': 'lat=${lat ?? ""}; lng=${lng ?? ""}',
      'x-geo-location':
          'place=${Uri.encodeComponent(place ?? "")}; local=${Uri.encodeComponent(local ?? "")}; city=${Uri.encodeComponent(city ?? "")}; province=${Uri.encodeComponent(province ?? "")}; code=${Uri.encodeComponent(code ?? "")}; country=${Uri.encodeComponent(country ?? "")}; country_code=${Uri.encodeComponent(countryCode ?? "")}',
      'accept-language': 'th',
    };
  }

  static String getTimestamp() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  static String generateNonce() {
    final randomBytes = Random.secure().nextInt(1000000000).toString();
    final bytes = utf8.encode(randomBytes);
    final hash = sha256.convert(bytes);
    final nonce = base64Url.encode(hash.bytes);
    return nonce;
  }

  static Future<String> getDeviceID() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("deviceId") ?? "";
  }

  static Future<String> signApiRequestSignature(String method, String endpoint, String timestamp, String nonce, String jsonBody) async {
    final prefs = await SharedPreferences.getInstance();
    final deviceID = prefs.getString("deviceId") ?? "";
    final dataToSign = '$method$endpoint$timestamp$nonce$jsonBody$deviceID$secretKey';
    final bytes = utf8.encode(dataToSign);
    final hash = sha256.convert(bytes);
    final signature = base64Url.encode(hash.bytes).replaceAll('-', '+').replaceAll('_', '/');
    return signature;
  }

  static Future<String> requestAPI(String endPoint, String method, [dynamic postData = null, dynamic headersData = null]) async {
    try {
      Map<String, String> postHeader = {};
      if (postData != null && method == "POST") {
        postHeader = await generateDefaultHeader();
      }
      if (headersData != null) {
        for (var key in headersData.keys) {
          postHeader[key] = headersData[key];
        }
      }

      Uri uri = Uri.parse(baseApiUrl + endPoint);
      if (postData != null && method == "GET") {
        uri = uri.replace(queryParameters: postData);
      }
      // debugPrint(uri.toString());
      // if (endPoint != "app-composite/generic") {
      //   final secure = await HttpCertificatePinning.check(
      //       serverURL: uri.toString(),
      //       headerHttp: postHeader,
      //       sha: SHA.SHA1,
      //       allowedSHAFingerprints: allowedShA1FingerprintList,
      //       timeout: 50);
      // }
      String timestamp = getTimestamp();
      String nonce = generateNonce();
      http.Request request = http.Request(method, uri);
      request.headers.addAll(postHeader);
      request.headers['content-type'] = 'application/json';
      request.headers['cache-control'] = 'true';
      request.headers['User-Agent'] = 'csgApp/Chodee csgVersion/0.0.1 csgBuild/001 csgPlatform/ios';
      request.headers['timestamp'] = timestamp;
      request.headers['nonce'] = nonce;
      if (postData != null) {
        postData['signature'] = generatePostSignature(postData, nonce);
        // debugPrint(jsonEncode(postData));
        request.body = jsonEncode(postData);
      }
      String accessToken = await Auth.getAccessToken() ?? "";
      if (accessToken != "" && accessToken.isNotEmpty && !endPoint.contains("auth")) {
        request.headers['authorization'] = "bearer " + accessToken;
      }
      final prefs = await SharedPreferences.getInstance();
      request.headers['device-id'] = prefs.getString("deviceId") ?? "";
      String signature = await signApiRequestSignature(method, uri.toString(), timestamp, nonce, jsonEncode(postData));
      request.headers['signature'] = signature;
      var response = await request.send();
      return await processResponse(response);
    } catch (e) {
      // showDailogCSG("ไม่สามารถทำรายการได้","ไม่สามารถทำรายการได้ เนื่องจากข้อมูลไม่ถูกต้อง โปรดแก้ไขข้อมูลแล้วลองใหม่ภายหลัง","ปิด");
      return "";
    }
  }

  static Future<String> uploadImage(String endPoint, File imageTemporary) async {
    try {
      Uri uri = Uri.parse(baseApiUrl + endPoint);
      String timestamp = getTimestamp();
      String nonce = generateNonce();

      // Create a multipart request
      var request = http.MultipartRequest('POST', uri);

      // Set headers
      request.headers['content-type'] = 'multipart/form-data';
      request.headers['cache-control'] = 'true';
      request.headers['User-Agent'] = 'csgApp/Chodee csgVersion/0.0.1 csgBuild/001 csgPlatform/ios';
      request.headers['timestamp'] = timestamp;
      request.headers['nonce'] = nonce;

      String accessToken = await Auth.getAccessToken() ?? "";
      if (accessToken.isNotEmpty && !endPoint.contains("auth")) {
        request.headers['authorization'] = "bearer " + accessToken;
      }

      // Add the image file to the request
      var imageField = await http.MultipartFile.fromPath('Image', imageTemporary.path);
      request.files.add(imageField);

      // Send the request
      var response = await request.send();

      // Process the response
      return await processResponse(response);
    } catch (e) {
      print(e);
      return "";
    }
  }

  static dynamic generatePostSignature(Map<String, dynamic> postData, String nonce) {
    final flattenedData = _flattenMap(postData);
    final sortedKeys = flattenedData.keys.toList()..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));

    final values = sortedKeys.map((key) => _encodeValue(flattenedData[key])).toList();
    final dataString = values.join("|");
    final hmac = Hmac(sha256, utf8.encode(nonce + secretKey));
    final encryptedData = hmac.convert(utf8.encode(dataString)).toString();
    return encryptedData;
  }

  static String _encodeValue(dynamic value) {
    if (value is List<Map<String, dynamic>>) {
      final encodedList = value.map((item) => _flattenMap(item)).toList();
      return jsonEncode(encodedList);
    } else {
      return value.toString();
    }
  }

  static Map<String, dynamic> _flattenMap(Map<String, dynamic> map, {String parentKey = ''}) {
    final flatMap = <String, dynamic>{};
    map.forEach((key, value) {
      final newKey = parentKey.isEmpty ? key : '$parentKey.$key';
      if (value is Map<String, dynamic>) {
        flatMap.addAll(_flattenMap(value, parentKey: newKey));
      } else if (value is List<Map<String, dynamic>>) {
        for (var i = 0; i < value.length; i++) {
          final listItemKey = '$newKey.$i';
          flatMap.addAll(_flattenMap(value[i], parentKey: listItemKey));
        }
      } else {
        flatMap[newKey] = value;
      }
    });
    return flatMap;
  }

  static Future<dynamic> processResponse(http.StreamedResponse response) async {
    // switch (await response.stream.bytesToString()) {
    //   case "error code: 1033":
    //     showDailogCSG("ไม่สามารถทำรายการได้","ไม่สามารถทำรายการได้ เนื่องจากเซิฟเวอร์ขัดข้อง กรุณาลองใหม่ภายหลัง","ปิด",(){Navigator.of(Chodee.context!).pushNamed('/home');});
    // }
    switch (response.statusCode) {
      case 200:
        String contentType = response.headers['content-type'] ?? '';
        if (contentType.contains('jpeg')) {
          return response;
        } else {
          String responseBody = await response.stream.bytesToString();
          dynamic jsonResponse = jsonDecode(responseBody);
          if (jsonResponse.containsKey('status_code') && jsonResponse['status_code'] != 200) {
            showDailogCSG("ไม่สามารถทำรายการได้", "ไม่สามารถทำรายการได้ เนื่องจากข้อมูลไม่ถูกต้อง โปรดแก้ไขข้อมูลแล้วลองใหม่ภายหลัง", "ปิด");
          }
          return responseBody;
        }
      case 400:
        String responseBody = await response.stream.bytesToString();
        dynamic jsonResponse = jsonDecode(responseBody);
        if (jsonResponse.containsKey('status_code') && jsonResponse['status_code'] != 200) {
          showDailogCSG(jsonResponse['data']['title'], jsonResponse['data']['description'], "ปิด");
        }
        return responseBody;
      case 401:
        throw Exception('คุณทำรายการเกินเวลาที่กำหนดแล้ว กรุณาเข้าสู่ระบบใหม่อีกครั้งเพื่อใช้งานต่อ');
      case 403:
        throw Exception('คุณไม่มีสิทธิ์เข้าถึงข้อมูล');
      case 404:
        throw Exception('ไม่พบข้อมูลที่คุณต้องการ อาจถูกย้ายหรือลบออกแล้ว กรุณาตรวจสอบข้อมูล แล้วลองใหม่อีกครั้ง');
      case 500:
        throw Exception('ระบบไม่สามารถใช้งานได้ในขณะนี้ โปรดเว้นช่วงเวลาการทำรายการ แล้วลองทำรายการใหม่ภายหลัง');
      default:
        throw Exception('ระบบเกิดข้อผิดพลาดในการทำรายการ โปรดเว้นช่วงเวลาการทำรายการ แล้วลองทำรายการใหม่ภายหลัง');
    }
  }

  static Future<bool> isValidCertification() async {
    try {
      final secure = await HttpCertificatePinning.check(serverURL: baseApiUrl, sha: SHA.SHA1, allowedSHAFingerprints: allowedShA1FingerprintList, timeout: 50);
      if (secure.contains("CONNECTION_SECURE")) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static void showDailogCSG(String title, String description, String btnText, [VoidCallback? onClicked]) {
    onClicked ??= () {
      Navigator.of(context!).pop();
    };
    showDialog(
      context: context!,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        contentPadding: const EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Colors.white,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(45),
                    backgroundColor: Color.fromARGB(255, 0, 208, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: onClicked,
                  child: Text(
                    btnText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Future<Position> getCurrentPosition() async {
    Position geoPos;
    try {
      geoPos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high, timeLimit: const Duration(milliseconds: 100));
    } catch (e) {
      geoPos = (await Geolocator.getLastKnownPosition())!;
    }
    return geoPos;
  }

  static Future<Placemark> getAddressFromPosition(Position position) async {
    if (position.latitude == null || position.longitude == null) {
      return Placemark(name: "", locality: "", subAdministrativeArea: "", administrativeArea: "", postalCode: "", country: "", isoCountryCode: "");
    }
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude, localeIdentifier: 'en_US');
    return placemarks[0];
  }

  static Future<Map<String, dynamic>> getDevicePostData() async {
    Map<String, dynamic> data = {};
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      data = {
        "brand": androidInfo.brand,
        "device_name": androidInfo.model,
        "device_os": "android ${androidInfo.version.release}",
        "model_identifier": androidInfo.model,
        "model_number": androidInfo.model,
      };
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
      data = {
        "brand": "Apple",
        "device_name": iosInfo.name,
        "device_os": iosInfo.systemName,
        "model_identifier": iosInfo.identifierForVendor,
        "model_number": iosInfo.model,
      };
    }
    return data;
  }

  static Future<void> generateIdentity() async {
    final prefs = await SharedPreferences.getInstance();
    final mobileTracking = base64.encode(List<int>.generate(40, (i) => randomBetween(0, 255)));
    final deviceId = md5.convert(utf8.encode(mobileTracking)).toString().substring(16);

    if (!prefs.containsKey("mobileTracking") || !prefs.containsKey("deviceId")) {
      await prefs.setString("mobileTracking", mobileTracking);
      await prefs.setString("deviceId", deviceId);
    }
  }

  static void openPage(String url, dynamic args) async {
    navigatorKey.currentState?.pushNamed(url, arguments: args);
  }

  static void popPageFromEditProduct() async {
    navigatorKey.currentState?.pop();
    navigatorKey.currentState?.pushNamed('/home', arguments: 2);
  }

  static String convertPrice(double floatNumber) {
    final formatter = NumberFormat('#,##0.00');
    return formatter.format(floatNumber);
  }

  static Future<List<int>> getImagePrivate(String endpoint) async {
    dynamic processedResponse = await Chodee.getImageData(endpoint, "GET");
    if (processedResponse is http.StreamedResponse) {
      // Handle image response
      final response = processedResponse as http.StreamedResponse;
      if (response.headers['content-type']?.contains('image/jpeg') == true || response.headers['content-type']?.contains('image/png') == true) {
        return await response.stream.toBytes();
      } else {
        return [];
      }
    } else {
      return [];
    }
  }

  static Future<http.StreamedResponse> getImageData(String endPoint, String method, [dynamic postData = null, dynamic headersData = null]) async {
    try {
      Map<String, String> postHeader = {};
      if (headersData != null) {
        for (var key in headersData.keys) {
          postHeader[key] = headersData[key];
        }
      }

      Uri uri = Uri.parse(endPoint);
      if (postData != null && method == "GET") {
        uri = uri.replace(queryParameters: postData);
      }
      String timestamp = getTimestamp();
      String nonce = generateNonce();
      http.Request request = http.Request(method, uri);
      request.headers.addAll(postHeader);
      request.headers['content-type'] = 'application/json';
      request.headers['cache-control'] = 'true';
      request.headers['User-Agent'] = 'csgApp/csgame csgVersion/0.0.1 csgBuild/001 csgPlatform/ios';
      request.headers['timestamp'] = timestamp;
      request.headers['nonce'] = nonce;

      String accessToken = await Auth.getAccessToken() ?? "";
      if (accessToken != "" && accessToken.isNotEmpty && !endPoint.contains("mobile-auth-services")) {
        request.headers['authorization'] = "bearer " + accessToken;
      }
      final prefs = await SharedPreferences.getInstance();
      request.headers['device-id'] = prefs.getString("deviceId") ?? "";
      String signature = await signApiRequestSignature(method, uri.toString(), timestamp, nonce, jsonEncode(postData));
      request.headers['signature'] = signature;
      var response = await request.send();
      return response;
    } catch (e) {
      return http.StreamedResponse(
        http.ByteStream.fromBytes([]),
        404,
        headers: {},
        reasonPhrase: e.toString(),
      );
    }
  }
}
