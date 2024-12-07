import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getifyjobs/Models/CandidateProfileModel.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:motion_toast/motion_toast.dart';

final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
String? accesstokens = 'accessToken';
String? candidateId = 'candidate_id';
String? candidateType = 'candidate_type';
String? fcmToken = 'fcmToken';

String Storage = 'storage';
String? routes = "routes_Log";

AndroidOptions _androidOptions() => AndroidOptions();
IOSOptions _getIOSOptions() => IOSOptions(
      accountName: Storage,
    );

void deleteAll() async {
  await _secureStorage.deleteAll(iOptions: _getIOSOptions());
}

accessToken(dynamic val) async {
  await _secureStorage.write(
      key: accesstokens!, value: val, aOptions: _androidOptions());
  print("val!:$val" + "$accesstokens");
}

Future<dynamic> getToken() async {
  final String? gettoken = await _secureStorage.read(
      key: accesstokens!, aOptions: _androidOptions());
  print("valu:$gettoken");
  return gettoken!;
}

StoreFCMToken(dynamic val) async {
  await _secureStorage.write(
      key: fcmToken!, value: val, aOptions: _androidOptions());
  print("val!:$val" + "$fcmToken");
}

Future<dynamic> getFCMToken() async {
  final String? gettoken =
      await _secureStorage.read(key: fcmToken!, aOptions: _androidOptions());
  print("valu:$gettoken");
  return gettoken!;
}

CandidateId(dynamic val) async {
  await _secureStorage.write(
      key: candidateId!, value: val!, aOptions: _androidOptions());
  print("value!:${val!}" + "$candidateId");
}

Future<dynamic> getcandidateId() async {
  dynamic candidate_id =
      await _secureStorage.read(key: candidateId!, aOptions: _androidOptions());
  print("valuesss:$candidate_id");
  return candidate_id;
}

CandidateType(dynamic val) async {
  await _secureStorage.write(
      key: candidateType!, value: val!, aOptions: _androidOptions());
  print("value!:${val!}" + "$candidateType");
}

Future<dynamic> getcandidateType() async {
  dynamic candidate_type = await _secureStorage.read(
      key: candidateType!, aOptions: _androidOptions());
  print("valuesss:$candidateType");
  return candidate_type;
}

Routes(dynamic val) async {
  await _secureStorage.write(
      key: routes!, value: val!, aOptions: _androidOptions());
  print("valuesss:$routes");
  return routes;
}

Future<dynamic> getRoutes() async {
  dynamic routes_Log =
      await _secureStorage.read(key: routes!, aOptions: _androidOptions());
  print("valuesss:$routes_Log");
  return routes_Log;
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

void ShowToastMessage(String message) => Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 16.0);

void MotionToastErr(String message) {
  MotionToast.error(
    description: Text(message),
    height: 60,
    width: 280,
  ).show(NavigationService.navigatorKey.currentContext!);
}

void MotionToastErrwithoutTitle(String message) {
  MotionToast.error(
    description: Text(message),
    height: 60,
    width: 280,
  ).show(NavigationService.navigatorKey.currentContext!);
}

void MotionToastErrwithTitle(String title, String message) {
  MotionToast.error(
    title: Text(title),
    description: Text(message),
    height: 60,
    width: 280,
  ).show(NavigationService.navigatorKey.currentContext!);
}

void MotionToastSuccess(String message) {
  MotionToast.success(description: Text(message), height: 60, width: 280)
      .show(NavigationService.navigatorKey.currentContext!);
}

void MotionToastSuccessDuration(String message, int duration) {
  MotionToast.success(
    description: Text(message),
    height: 60,
    width: 280,
    toastDuration: Duration(seconds: duration),
  ).show(NavigationService.navigatorKey.currentContext!);
}

void MotionToastCustom(String message) {
  MotionToast(
    icon: Icons.alarm,
    primaryColor: Colors.pink,
    title: Text(message),
    description: Text(""),
    width: 300,
    height: 100,
  ).show(NavigationService.navigatorKey.currentContext!);
}

class GetterSetter {
  String? _myValue;

  String get myValue {
    return _myValue ?? "";
  }

  set myValue(String value) {
    _myValue = value;
  }
}

class SingleTon {
  static final SingleTon qwerty = SingleTon._internal();
  factory SingleTon() {
    return qwerty;
  }
  SingleTon._internal();

  String setLocation = "";
  String lattidue = "";
  String setTime = "";
  String longitude = "";
  // LatLng locationLat = LatLng(0.0, 0.0);
  File? setPdf;
  canidateProfileData? userModelData;
  bool isLoading = true;
  bool isDataLoaded = true;

}

void showBottomLoader(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return const SizedBox(
        height: 200.0, // You can customize the height as needed
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    },
  );
}

Widget buildLoadingIndicator() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Center(
      child: SpinKitWave(
        type: SpinKitWaveType.center,
        size: 50,
        itemBuilder: (_, int index) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: index.isEven ? blue1 : Colors.black,
            ),
          );
        },
      ),
    ),
  );
}

Future<List<int>> compressImage(File file) async {
  var result = await FlutterImageCompress.compressWithFile(
    file.absolute.path,
    quality: 25, // Adjust the quality as needed (0 to 100)
  );

  if (result == null) {
    throw Exception('Failed to compress image');
  }

  return result;
}


// Future<void> readall() async{
// final all =await _secureStorage.readAll(aOptions: _androidOptions());
// }

// void tokenVal(tokens, farmerId) async {
//   final prefs = await SharedPreferences.getInstance();
//   await prefs.setString("tokenval", tokens);
//   await prefs.setInt("farmerID", farmerId);
//   final _tokenval = await prefs.getString("tokenval");
//   final _idVal = await prefs.getInt("farmerID");
//   print(_tokenval);
//   print(_idVal);
// }


