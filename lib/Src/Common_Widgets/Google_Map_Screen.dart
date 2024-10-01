// import 'dart:async';
// import 'package:location/location.dart';
//
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class MapSample extends StatefulWidget {
//   const MapSample({super.key});
//
//   @override
//   State<MapSample> createState() => MapSampleState();
// }
//
// class MapSampleState extends State<MapSample> {
//   final Completer<GoogleMapController> _controller =
//   Completer<GoogleMapController>();
//   LatLng? _latLng;
//
//   static  CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(13.0827, 80.2707),
//     zoom: 14.4746,
//   );
//
//   static const CameraPosition _kLake = CameraPosition(
//       bearing: 192.8334901395799,
//       target: LatLng(13.0827, 80.2707),
//       tilt: 59.440717697143555,
//       zoom: 19.151926040649414);
//
//   Future<void> getCurrentLocation()async{
//     Location location =  Location();
//
//     bool _serviceEnabled;
//     PermissionStatus _permissionGranted;
//     LocationData _locationData;
//
//     _serviceEnabled = await location.serviceEnabled();
//     if (!_serviceEnabled) {
//       _serviceEnabled = await location.requestService();
//       if (!_serviceEnabled) {
//         return;
//       }
//     }
//
//     _permissionGranted = await location.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted = await location.requestPermission();
//       if (_permissionGranted != PermissionStatus.granted) {
//         return;
//       }
//     }
//
//     _locationData = await location.getLocation();
//     _latLng = LatLng(_locationData.latitude ?? 0, _locationData.longitude ?? 0);
//     print('${_latLng}');
//     _kGooglePlex= CameraPosition(
//         target: _latLng!,
//       zoom: 14.4746,
//     );
//
//   }
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//    setState(() {
//      getCurrentLocation();
//    });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GoogleMap(
//         mapType: MapType.normal,
//         initialCameraPosition: _kGooglePlex,
//         markers:Set<Marker>.of([_marker]) ,
//         myLocationButtonEnabled: true,
//         myLocationEnabled: true,
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
//       ),
//       // floatingActionButton: FloatingActionButton.extended(
//       //   onPressed: _goToTheLake,
//       //   label: const Text('To the lake!'),
//       //   icon: const Icon(Icons.directions_boat),
//       // ),
//     );
//   }
//
//   // Future<void> _goToTheLake() async {
//   //   final GoogleMapController controller = await _controller.future;
//   //   await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
//   // }
//   _setMarker(){
//     return Marker(
//       markerId: MarkerId('marker_1'),
//       icon: BitmapDescriptor.defaultMarker,
//       position: LatLng(13.0827, 80.2707),
//     );
//   }
//   final Marker _marker = Marker(
//     markerId: MarkerId('currentLocation'),
//     position: LatLng(13.0827, 80.2707), // Initial marker position
//     draggable: true,
//   );
// }
//
//
//
// class MapScreen extends StatefulWidget {
//   @override
//   _MapScreenState createState() => _MapScreenState();
// }
//
// class _MapScreenState extends State<MapScreen> {
//   GoogleMapController? _controller;
//   LatLng _currentLocation = LatLng(13.0827, 80.2707); // Initial location (Chennai, Tamil Nadu)
//   Set<Marker> _markers = {};
//
//   void _onMapCreated(GoogleMapController controller) {
//     setState(() {
//       _controller = controller;
//       _markers.add(
//         Marker(
//           markerId: MarkerId('currentLocation'),
//           position: _currentLocation,
//           draggable: true,
//           onDragEnd: _onMarkerDragEnd,
//         ),
//       );
//     });
//   }
//
//   void _onMarkerDragEnd(LatLng newLocation) {
//     setState(() {
//       _currentLocation = newLocation;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Move Marker on Map'),
//       ),
//       body: GoogleMap(
//         onMapCreated: _onMapCreated,
//         initialCameraPosition: CameraPosition(
//           target: _currentLocation,
//           zoom: 15.0,
//         ),
//         markers: _markers,
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Move the marker to a new location (e.g., Chennai Marina Beach)
//           final newLocation = LatLng(13.0493, 80.2832);
//           setState(() {
//             _markers.clear();
//             _markers.add(
//               Marker(
//                 markerId: MarkerId('currentLocation'),
//                 position: newLocation,
//                 draggable: true,
//                 onDragEnd: _onMarkerDragEnd,
//               ),
//             );
//             _currentLocation = newLocation;
//           });
//         },
//         child: Icon(Icons.update),
//       ),
//     );
//   }
// }
//
//
//
//
