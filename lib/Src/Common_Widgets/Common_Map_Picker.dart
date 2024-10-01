// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:getifyjobs/Src/utilits/Generic.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// import '../utilits/Common_Colors.dart';
// import '../utilits/Text_Style.dart';
// import 'Image_Path.dart';
//
// class Common_Map extends StatefulWidget {
//   const Common_Map({super.key});
//
//   @override
//   State<Common_Map> createState() => _Common_MapState();
// }
//
// class _Common_MapState extends State<Common_Map> {
//   Position? currentPosition;
//   String currentAddress = "";
//   var isLoading = false;
//   String? CurrentLocation;
//   final Completer<GoogleMapController> _controller = Completer();
//
//   Future<Position> getPosition() async {
//     LocationPermission? Permision;
//     Permision = await Geolocator.checkPermission();
//     if (Permision == LocationPermission.denied) {
//       Permision = await Geolocator.requestPermission();
//       if (Permision == LocationPermission.denied) {
//         return Future.error("Location Permission are Denied");
//       }
//     }
//     return await Geolocator.getCurrentPosition();
//   }
//
// //MAP
//   Future<void> getAddress(double latitude, double longitude) async {
//     try {
//       List<Placemark> placemarks =
//           await placemarkFromCoordinates(latitude, longitude);
//
//       if (placemarks.isNotEmpty) {
//         Placemark place = placemarks[0];
//         String Locality = place.locality ?? "";
//         String Street = place.street ?? "";
//         String District = place.subAdministrativeArea ?? "";
//         String Area = place.thoroughfare ?? "";
//         String SubLocality = place.subLocality ?? "";
//         String PinCode = place.postalCode ?? "";
//         setState(() {
//           SingleTon singleton = SingleTon();
//           currentAddress = "${Street}, ${Area}, ${Locality}, ${PinCode}";
//           singleton.setLocation = currentAddress;
//           singleton.lattidue = latitude.toString();
//           singleton.longitude = longitude.toString();
//         });
//       } else {
//         currentPosition = "Location Not Found" as Position;
//       }
//     } catch (e) {
//       print("ERROR LOCATION ${e}");
//     }
//   }
//
//   Future<void> getCurrentLocation() async {
//     try {
//       isLoading = true;
//       currentPosition = await getPosition();
//       getAddress(currentPosition!.latitude, currentPosition!.longitude);
//
//       isLoading = false;
//       print("FALSE LOADING");
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   Future<Position> getUserCurrentLocation() async {
//     await Geolocator.requestPermission()
//         .then((value) {})
//         .onError((error, stackTrace) {
//       print("Error${error.toString()}");
//     });
//     return await Geolocator.getCurrentPosition();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: white1,
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Row(
//             children: [
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(top: 20, bottom: 10),
//                     child: Container(
//                         alignment: Alignment.topLeft,
//                         child: Text(
//                           "Live Location",
//                           style: mapT1,
//                         )),
//                   ),
//                   Row(
//                     children: [
//                       ImgPathSvg("Pin.svg"),
//                       Container(
//                           width: MediaQuery.of(context).size.width / 1.5,
//                           child: Text(currentAddress == ""
//                               ? "Location not found"
//                               : currentAddress)),
//                     ],
//                   ),
//                 ],
//               ),
//               Spacer(),
//               InkWell(
//                   onTap: () {
//                     getUserCurrentLocation().then((value) {
//                       print(value.latitude.toString() +
//                           ' ' +
//                           value.longitude.toString());
//                       getAddress(value.latitude, value.longitude);
//                     });
//                   },
//                   child: MapFetch()),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   //MAP
//   Widget MapFetch() {
//     return Column(
//       children: [
//         Container(
//           margin: EdgeInsets.only(top: 15),
//           height: 70,
//           width: 70,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             image: DecorationImage(image: AssetImage("lib/assets/map.png")),
//           ),
//         ),
//         Text(
//           "Tap to View",
//           style: mapT3,
//         ),
//       ],
//     );
//   }
// }
//
// class mapScreen extends StatelessWidget {
//   mapScreen({super.key});
//
//   final Completer<GoogleMapController> _controller = Completer();
//
//   static const CameraPosition _googlePlex =
//       CameraPosition(target: LatLng(33.6844, 73.0479), zoom: 14);
//
//   final List<Marker> _markers = const <Marker>[
//     Marker(
//         markerId: MarkerId('1'),
//         position: LatLng(33.6844, 73.0479),
//         infoWindow: InfoWindow(title: "Title Marker"))
//   ];
//
//   Future<Position> getUserCurrentLocation() async {
//     await Geolocator.requestPermission()
//         .then((value) {})
//         .onError((error, stackTrace) {
//       print("Error${error.toString()}");
//     });
//     return await Geolocator.getCurrentPosition();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GoogleMap(
//         initialCameraPosition: _googlePlex,
//         markers: Set<Marker>.of(_markers),
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           getUserCurrentLocation().then((value) {
//             SingleTon singleton = SingleTon();
//             singleton.lattidue = value.latitude.toString();
//             singleton.longitude = value.longitude.toString();
//             print(value.latitude.toString() + ' ' + value.longitude.toString());
//           });
//         },
//         child: Icon(Icons.local_activity),
//       ),
//     );
//   }
// }
