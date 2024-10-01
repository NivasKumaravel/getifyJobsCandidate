import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Generic.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  String _isLoggedIn = "false";

  @override
  void initState() {
    super.initState();
    initialize();
    _loadUserInfo();
  }

  void initialize() async {
    await Future.delayed(Duration(seconds: 1));
    // FlutterNativeSplash.remove();
  }

  _loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getBool('first_run') ?? true) {
      FlutterSecureStorage storage = FlutterSecureStorage();

      await storage.deleteAll();

      prefs.setBool('first_run', false);
    }

    final routesData = await getRoutes();
    final candidateType = await getcandidateType();

    routesData != null ? _isLoggedIn = routesData : _isLoggedIn = "false";
    if (_isLoggedIn == "true") {
      if (candidateType == "Student") {
        Navigator.pushNamedAndRemoveUntil(
            context, '/home', ModalRoute.withName('/home'));
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, '/candidate', ModalRoute.withName('/candidate'));
      }
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, '/login', ModalRoute.withName('/login'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
