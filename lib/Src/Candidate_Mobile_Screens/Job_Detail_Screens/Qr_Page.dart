import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QRCodePage(),
    );
  }
}

class QRCodePage extends StatefulWidget {
  @override
  _QRCodePageState createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
  bool showQRCode = false;

  void _showQRCode() {
    setState(() {
      showQRCode = true;
    });
  }

  void _hideQRCode() {
    setState(() {
      showQRCode = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (!showQRCode)
              Column(
                children: [
                  ElevatedButton(
                    onPressed: _showQRCode,
                    child: Text('Yes'),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: _hideQRCode,
                    child: Text('No'),
                  ),
                ],
              ),
            if (showQRCode)
              QrImageView(
                data: 'Your QR Code Data Here', // Replace with your QR code data
                version: QrVersions.auto,
                size: 200.0,
              ),
          ],
        ),
      ),
    );
  }
}
