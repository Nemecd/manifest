import 'dart:async';

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:manifest/screens/qrResultScreen.dart';
import 'package:manifest/screens/toastMsg.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  String scannedData = '';
  bool scanSuccess = false;

  Future<void> startScan() async {
    try {
      var result = await BarcodeScanner.scan();
      setState(() {
        scannedData = result.rawContent;
      });

      if (scannedData.isNotEmpty) {
        showToast(message: 'Scan Complete !');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DisplayScannedDataScreen(
              scannedData: scannedData,
            ),
          ),
        );
      } else {
        showToast(message: 'Invalid QR code format');
        print('Invalid QR code format');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          color: Color(0xFFf6fafd),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Text(
                    "Scan Driver's Code",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        letterSpacing: 1),
                  ),
                ])),
            Image.asset('assets/img/qr.png', width: 500, height: 500),
            ElevatedButton(
              onPressed: () {
                startScan();
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Start Scan',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // White background
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
              ),
            ),

            const SizedBox(height: 20),
           
          ],
        ),
      ),
    );
  }
}
