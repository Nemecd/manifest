
import 'package:flutter/material.dart';
import 'package:manifest/Models/user.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
//import 'package:share_plus/share_plus.dart';

import '../../Provider/provider.dart';

class CodeGenScreen extends StatefulWidget {
  const CodeGenScreen({super.key});

  @override
  State<CodeGenScreen> createState() => _CodeGenScreenState();
}

class _CodeGenScreenState extends State<CodeGenScreen> {
  Future<String> generateQRCode() async {
    // Fetch user data
    UserModel? user = Provider.of<UserProvider>(context).user;
      if (user != null) {
    // Create a string with user information
    String userDataString = 'Driver\'s Name: ${user.name}\nDriver\'s PhoneNumber: ${user.email}';

    return userDataString;
  } else {
    // Handle the case where user data is not available
    return ''; // Or any other appropriate action
  }
  }

  //   void _shareQRCode() async {
  //   String qrData = await generateQRCode();
  //   if (qrData.isNotEmpty) {
  //     final ByteData? qrImage = await QrPainter(
  //       data: qrData,
  //       version: QrVersions.auto,
  //       size: 200.0,
  //     ).toImageData(200);

  //     // Share the QR code image using share_plus package
  //     await Share.shareXFiles(
  //       ['data:image/png;base64,${base64Encode(qrImage)}'],
  //       text: 'Scan this code',
  //     );
  //   }
  // }

  bool loading = false;
  @override
  void initState() {
    super.initState();
    // user = UserModel( name: '', phoneNumber: '');
    // getUsersdata();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            );
          }),
          title: const Center(
              child: Padding(
            padding: EdgeInsets.only(right: 50.0),
            child: Text('Generate QR Code'),
          )),
          backgroundColor: const Color(0xFFf6fafd),
        ),
        body: Container(
          height: size.height,
          width: size.width,
          decoration: const BoxDecoration(
            color: Color(
                0xFFf6fafd), // Set the background color using a BoxDecoration
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 160.0),
                  child: FutureBuilder<String>(
                    future: generateQRCode(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return QrImageView(
                          data: snapshot.data ?? '',
                          version: QrVersions.auto,
                          size: 200.0,
                        );
                      }
                    },
                  ),
                ),
                //const SizedBox(height: 30),
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all<Size>(
                          const Size(double.infinity, 48.0),
                        ),
                        backgroundColor: const MaterialStatePropertyAll<Color>(
                            Color(0XFF1e65ff)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // Reduce the border radius
                          ),
                        ),
                      ),
                      child: loading
                          ? Container(
                              width: 24,
                              height: 24,
                              child: const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Colors
                                    .white), // Set the color of the stroke
                              ),
                            )
                          : const Text(
                              'Download Image',
                              style: TextStyle(
                                fontFamily: 'futura',
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            )),
                )
              ],
            ),
          ),
        ));
  }
}
