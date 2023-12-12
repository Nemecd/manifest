import 'dart:io';

// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:manifest/screens/bottomNav.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../Models/report.dart';
import '../Provider/Report.dart';
import 'Models/notification.dart';

import 'Provider/notifyProvider.dart';

import 'screens/toastMsg.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  // UserProvider userProvider = UserProvider();
  // FirestoreProvider firestoreProvider = FirestoreProvider(userProvider);
  //   late UserProvider userProvider;
  // late FirestoreProvider firestoreProvider;

  bool checkboxValue1 = false;
  bool checkboxValue2 = false;
  bool checkboxValue3 = false;
  bool checkboxValue4 = false;
  bool checkboxValue5 = false;
  bool checkboxValue6 = false;
  bool checkboxValue7 = false;
  bool checkboxValue8 = false;
  bool checkboxValue9 = false;
  bool checkboxValue10 = false;
  bool checkboxValue11 = false;
  bool checkboxValue12 = false;
  bool checkboxValue13 = false;
  bool checkboxValue14 = false;
  bool checkboxValue15 = false;
  // bool checkboxValue16 = false;
  // bool checkboxValue17 = false;
  final otherCtrl = TextEditingController();

  File? _image;
  final picker = ImagePicker();

  Future<List<String>> uploadImages(List<File> imageFiles) async {
    List<String> downloadURLs = [];

    try {
      for (var imageFile in imageFiles) {
        final firebase_storage.Reference ref = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');

        await ref.putFile(imageFile);
        String downloadURL = await ref.getDownloadURL();
        downloadURLs.add(downloadURL);
      }
      return downloadURLs;
    } catch (e) {
      print('Error uploading images: $e');
      return [];
    }
  }

  List<File> _images = []; // List to store multiple images

  Future<void> pickImages() async {
    final pickedFiles = await picker.pickMultiImage();
    setState(() {
      _images.clear(); // Clear previous images if needed
      for (var pickedFile in pickedFiles) {
        _images.add(File(pickedFile.path)); // Add selected images to the list
      }
    });

    if (_images.isNotEmpty) {
      List<String> downloadURLs = await uploadImages(_images);
      // Process download URLs as needed (e.g., store in Firestore, display, etc.)
      print('Download URLs: $downloadURLs');
    }
  }

  @override
  void initState() {
    super.initState();
    // userProvider = UserProvider();
    // firestoreProvider = FirestoreProvider(userProvider);
  }

  @override
  Widget build(BuildContext context) {
    const outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    );
    return ChangeNotifierProvider<ReportProvider>(
        create: (context) => ReportProvider(),
        builder: (context, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Report',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 20,
                  )),
              backgroundColor: const Color(0xFFf6fafd),
            ),
            body: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFf6fafd),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                              flex: 4,
                              child: const Text('Over Speeding',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 16,
                                  ))),
                          // const SizedBox(width: 115.0),
                          Expanded(
                              flex: 1,
                              child: const Text('Yes',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 14,
                                  ))),
                          Checkbox(
                            checkColor:
                                Colors.white, // Change tick color to blue
                            activeColor: Colors.blue,
                            value: checkboxValue1,
                            onChanged: (value) {
                              setState(() {
                                checkboxValue1 = value!;
                                if (checkboxValue1) {
                                  checkboxValue2 = !checkboxValue1;
                                }
                              });
                            },
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                              flex: 1,
                              child: const Text('No',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 14,
                                  ))),
                          Checkbox(
                            checkColor:
                                Colors.white, // Change tick color to blue
                            activeColor: Colors.blue,
                            value: checkboxValue2,
                            onChanged: (value) {
                              setState(() {
                                checkboxValue2 = value!;
                                if (checkboxValue2) {
                                  checkboxValue1 = !checkboxValue2;
                                }
                              });
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 4,
                              child: const Text('Reckless Driving',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 16,
                                  ))),
                          // const SizedBox(width: 103.0),
                          Expanded(
                              flex: 1,
                              child: const Text('Yes',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 14,
                                  ))),
                          Checkbox(
                            checkColor:
                                Colors.white, // Change tick color to blue
                            activeColor: Colors.blue,
                            value: checkboxValue10,
                            onChanged: (value) {
                              setState(() {
                                checkboxValue10 = value!;
                                if (checkboxValue10) {
                                  checkboxValue11 = !checkboxValue10;
                                }
                              });
                            },
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                              flex: 1,
                              child: const Text('No',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 14,
                                  ))),
                          Checkbox(
                            checkColor:
                                Colors.white, // Change tick color to blue
                            activeColor: Colors.blue,
                            value: checkboxValue11,
                            onChanged: (value) {
                              setState(() {
                                checkboxValue11 = value!;
                                if (checkboxValue11) {
                                  checkboxValue10 = !checkboxValue11;
                                }
                              });
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 4,
                              child: const Text('MisUnderstood the route',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 16,
                                  ))),
                          // const SizedBox(width: 50.0),
                          const Text('Yes',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14,
                              )),
                          Checkbox(
                            checkColor:
                                Colors.white, // Change tick color to blue
                            activeColor: Colors.blue,
                            value: checkboxValue3,
                            onChanged: (value) {
                              setState(() {
                                checkboxValue3 = value!;
                                if (checkboxValue3) {
                                  checkboxValue4 = !checkboxValue3;
                                }
                              });
                            },
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                              flex: 1,
                              child: const Text('No',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 14,
                                  ))),
                          Checkbox(
                            checkColor:
                                Colors.white, // Change tick color to blue
                            activeColor: Colors.blue,
                            value: checkboxValue4,
                            onChanged: (value) {
                              setState(() {
                                checkboxValue4 = value!;
                                if (checkboxValue4) {
                                  checkboxValue3 = !checkboxValue4;
                                }
                              });
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 4,
                              child: const Text('Answering calls while driving',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 16,
                                  ))),
                          // const SizedBox(width: 108.0),
                          Expanded(
                              flex: 1,
                              child: const Text('Yes',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 14,
                                  ))),
                          Checkbox(
                            checkColor:
                                Colors.white, // Change tick color to blue
                            activeColor: Colors.blue,
                            value: checkboxValue5,
                            onChanged: (value) {
                              setState(() {
                                checkboxValue5 = value!;
                                if (checkboxValue5) {
                                  checkboxValue6 = !checkboxValue5;
                                }
                              });
                            },
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                              flex: 1,
                              child: const Text('No',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 14,
                                  ))),
                          Checkbox(
                            checkColor:
                                Colors.white, // Change tick color to blue
                            activeColor: Colors.blue,
                            value: checkboxValue6,
                            onChanged: (value) {
                              setState(() {
                                checkboxValue6 = value!;
                                if (checkboxValue6) {
                                  checkboxValue5 = !checkboxValue6;
                                }
                              });
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 4,
                              child: const Text('Time Wasting',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 16,
                                  ))),
                          // const SizedBox(width: 120.0),
                          Expanded(
                              flex: 1,
                              child: const Text('Yes',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 14,
                                  ))),
                          Checkbox(
                            checkColor:
                                Colors.white, // Change tick color to blue
                            activeColor: Colors.blue,
                            value: checkboxValue7,
                            onChanged: (value) {
                              setState(() {
                                checkboxValue7 = value!;
                                if (checkboxValue7) {
                                  checkboxValue8 = !checkboxValue7;
                                }
                              });
                            },
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                              flex: 1,
                              child: const Text('No',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 14,
                                  ))),
                          Checkbox(
                            checkColor:
                                Colors.white, // Change tick color to blue
                            activeColor: Colors.blue,
                            value: checkboxValue8,
                            onChanged: (value) {
                              setState(() {
                                checkboxValue8 = value!;
                                if (checkboxValue8) {
                                  checkboxValue7 = !checkboxValue8;
                                }
                              });
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 4,
                              child: const Text('Parked for Eating',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 16,
                                  ))),
                          // const SizedBox(width: 98.0),
                          Expanded(
                              flex: 1,
                              child: const Text('Yes',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 14,
                                  ))),
                          Checkbox(
                            checkColor:
                                Colors.white, // Change tick color to blue
                            activeColor: Colors.blue,
                            value: checkboxValue12,
                            onChanged: (value) {
                              setState(() {
                                checkboxValue12 = value!;
                                if (checkboxValue12) {
                                  checkboxValue13 = !checkboxValue12;
                                }
                              });
                            },
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                              flex: 1,
                              child: const Text('No',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 14,
                                  ))),
                          Checkbox(
                            checkColor:
                                Colors.white, // Change tick color to blue
                            activeColor: Colors.blue,
                            value: checkboxValue13,
                            onChanged: (value) {
                              setState(() {
                                checkboxValue13 = value!;
                                if (checkboxValue13) {
                                  checkboxValue12 = !checkboxValue13;
                                }
                              });
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 4,
                              child: const Text('Car Breakdown',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 16,
                                  ))),
                          // const SizedBox(width: 111.0),
                          Expanded(
                              flex: 1,
                              child: const Text('Yes',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 14,
                                  ))),
                          Checkbox(
                            checkColor:
                                Colors.white, // Change tick color to blue
                            activeColor: Colors.blue,
                            value: checkboxValue14,
                            onChanged: (value) {
                              setState(() {
                                checkboxValue14 = value!;
                                if (checkboxValue14) {
                                  checkboxValue15 = !checkboxValue14;
                                }
                              });
                            },
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                              flex: 1,
                              child: const Text('No',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 14,
                                  ))),
                          Checkbox(
                            checkColor:
                                Colors.white, // Change tick color to blue
                            activeColor: Colors.blue,
                            value: checkboxValue15,
                            onChanged: (value) {
                              setState(() {
                                checkboxValue15 = value!;
                                if (checkboxValue15) {
                                  checkboxValue14 = !checkboxValue15;
                                }
                              });
                            },
                          ),
                        ],
                      ),
                      if (_image != null) Image.file(_image!),
                      SizedBox(
                        width: 300,
                        child: Row(
                          children: [
                            Expanded(
                                flex: 3,
                                child: const Text('Eye Witnness Report',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 16,
                                    ))),
                            Expanded(
                              flex: 3,
                              // padding: const EdgeInsets.only(right: 12.0),
                              child: ElevatedButton(
                                onPressed: pickImages,
                                style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all<Size>(
                                    const Size(double.infinity, 48.0),
                                  ),
                                  backgroundColor:
                                      const MaterialStatePropertyAll<Color>(
                                          Colors.white),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10.0), // Reduce the border radius
                                    ),
                                  ),
                                ),
                                child: const Text(
                                  'Pick Image',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 16,
                                    color: Color(0XFF1e65ff),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        child: Container(
                          height: _images.isNotEmpty
                              ? null
                              : 0, // Set height to null if images are present
                          child: ListView.builder(
                            shrinkWrap:
                                true, // Allow the ListView to wrap its content
                            itemCount: _images.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                title: Text(_images[index]
                                    .path
                                    .split('/')
                                    .last), // Display file name
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: TextFormField(
                          controller: otherCtrl,
                          decoration: InputDecoration(
                            hintText: 'Enter other concerns and observation',
                            hintStyle: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 16,
                            ),
                          border: outlineInputBorder,
                        enabledBorder:
                            outlineInputBorder, // Border when unfocused
                        focusedBorder: outlineInputBorder.copyWith(
                          borderSide: const BorderSide(
                              color: Colors.black), // Border when focused
                        ),
                          ),
                          maxLines: 3,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            String imageUrl = '';
                            if (_image != null) {
                              imageUrl =
                                  (await uploadImages(_image! as List<File>))
                                      as String;
                            }
                            String enteredText = otherCtrl.text;

                            final checkboxData = CheckboxData(
                              checkboxValue1: checkboxValue1,
                              checkboxValue2: checkboxValue2,
                              checkboxValue3: checkboxValue3,
                              checkboxValue4: checkboxValue4,
                              checkboxValue5: checkboxValue5,
                              checkboxValue6: checkboxValue6,
                              checkboxValue7: checkboxValue7,
                              checkboxValue8: checkboxValue8,
                              checkboxValue9: checkboxValue9,
                              checkboxValue10: checkboxValue10,
                              checkboxValue11: checkboxValue11,
                              checkboxValue12: checkboxValue12,
                              checkboxValue13: checkboxValue13,
                              checkboxValue14: checkboxValue14,
                              checkboxValue15: checkboxValue15,
                              others: enteredText,
                              imgUrl: imageUrl,
                            );
                            await Provider.of<ReportProvider>(context,
                                    listen: false)
                                .saveReport(context, checkboxData);
                            // saveUserTripsToSharedPreferences(
                            //     widget.userId, [trip]);
                            // print('Trip data saved: $trip');

                            Provider.of<NotificationProvider>(context,
                                    listen: false)
                                .addNotification(
                              NotificationModel(
                                id: UniqueKey().toString(),
                                title: 'New Trip Added',
                                description:
                                    'Your report has been sent. please do well to send in more observations and concerns.',
                                timestamp: DateTime.now(),
                              ),
                            );

                            var route = MaterialPageRoute(
                              builder: (context) => const bottomNav(
                                userId: '',
                              ),
                            );
                            Navigator.push(context, route);
                            showToast(message: 'Report Recorded !!');
                            print('Report Recorded !!');
                          },
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all<Size>(
                              const Size(double.infinity, 48.0),
                            ),
                            backgroundColor:
                                const MaterialStatePropertyAll<Color>(
                                    Color(0XFF1e65ff)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10.0), // Reduce the border radius
                              ),
                            ),
                          ),
                          child: const Text(
                            'Submit',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
