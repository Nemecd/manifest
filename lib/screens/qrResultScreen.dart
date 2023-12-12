import 'package:flutter/material.dart';
import 'package:manifest/Models/waymodel.dart';
import 'package:manifest/Provider/userTripPovider.dart';
import 'package:manifest/screens/bottomNav.dart';
import 'package:manifest/screens/toastMsg.dart';
import 'package:provider/provider.dart';
import '../Models/notification.dart';
import '../Models/userTrips.dart';
import '../Provider/notifyProvider.dart';
import '../Provider/provider.dart';
import '../Provider/wayProvider.dart';

class DisplayScannedDataScreen extends StatefulWidget {
  final String scannedData;

  DisplayScannedDataScreen({required this.scannedData});

  @override
  _DisplayScannedDataScreenState createState() =>
      _DisplayScannedDataScreenState();
}

class _DisplayScannedDataScreenState extends State<DisplayScannedDataScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  final TextEditingController passengerController = TextEditingController();
  final TextEditingController waybillController = TextEditingController();

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        return Scaffold(
          appBar: AppBar(
            // title: const Text('Scanned Data'),
            backgroundColor: const Color(0xFFf6fafd),
          ),
          body: Container(
            decoration: const BoxDecoration(
              color: Color(
                  0xFFf6fafd), // Set the background color using a BoxDecoration
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      widget.scannedData,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold, // Make the text bold
                      ),
                    ),
                  ),
                ),
                Center(
                  child: TabBar(
                    indicatorColor: const Color(0XFF1e65ff),
                    controller: tabController,
                    labelColor: Colors.black87,
                    labelStyle:
                        const TextStyle(fontSize: 18, fontFamily: 'Inter'),
                    tabs: const [
                      Tab(text: 'Passenger'),
                      Tab(text: 'Waybill'),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      PassengerForm(
                        passengerController,
                        userId: '',
                      ),
                      WaybillForm(
                        waybillController,
                        userId: '',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}

class WaybillForm extends StatefulWidget {
  final TextEditingController controller;
  final String userId;
  const WaybillForm(this.controller, {Key? key, required this.userId})
      : super(key: key);

  @override
  State<WaybillForm> createState() => _WaybillFormState();
}

class _WaybillFormState extends State<WaybillForm> {
  final _formKey = GlobalKey<FormState>();

  final waynumCtrl = TextEditingController();

  final sendnameCtrl = TextEditingController();

  final sendphoneCtrl = TextEditingController();

  final recevernameCtrl = TextEditingController();

  final receverphoneCtrl = TextEditingController();

  final waydestinyCtrl = TextEditingController();
  final wayoriginCtrl = TextEditingController();
  // final NotificationService notificationService = NotificationService();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WayProvider>(
        create: (context) => WayProvider(),
        builder: (context, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const Center(
                    //     child: Text('Waybill Form',
                    //         style:
                    //             TextStyle(fontSize: 18, fontFamily: 'Inter'))),
                    TextFormField(
                      controller: waynumCtrl,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Waybill Number',
                        labelStyle: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'Inter',
                            fontSize: 16),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.black), // Change the color here
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please fill in all empty fieids';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: sendnameCtrl,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Senders Name',
                        labelStyle: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'Inter',
                            fontSize: 16),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.black), // Change the color here
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please fill in all empty fieids';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: sendphoneCtrl,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Senders Phone Number',
                        labelStyle: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'Inter',
                            fontSize: 16),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.black), // Change the color here
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please fill in all empty fieids';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: recevernameCtrl,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Receivers Name',
                        labelStyle: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'Inter',
                            fontSize: 16),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.black), // Change the color here
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please fill in all empty fieids';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: receverphoneCtrl,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Receviers Phone Number',
                        labelStyle: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'Inter',
                            fontSize: 16),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.black), // Change the color here
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please fill in all empty fieids';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: wayoriginCtrl,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Origination',
                        labelStyle: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'Inter',
                            fontSize: 16),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.black), // Change the color here
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please fill in your destination';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: waydestinyCtrl,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        labelText: 'Destination',
                        labelStyle: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'Inter',
                            fontSize: 16),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.black), // Change the color here
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please fill in your destination';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: SizedBox(
                        width: 300,
                        child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  loading = true;
                                });

                                // Get values from text controllers
                                String wayNumber = waynumCtrl.text;
                                String senderName = sendnameCtrl.text;
                                String senderPhone = sendphoneCtrl.text;
                                String receiverName = recevernameCtrl.text;
                                String receiverPhone = receverphoneCtrl.text;
                                String destination = waydestinyCtrl.text;
                                String origination = wayoriginCtrl.text;

                                // Create a UserTrip object
                                WayTrip waybill = WayTrip(
                                  wayNumber: wayNumber,
                                  senderName: senderName,
                                  senderPhone: senderPhone,
                                  receiverName: receiverName,
                                  receiverPhone: receiverPhone,
                                  origination: origination,
                                  destination: destination,
                                  dateTime:
                                      DateTime.now(), // Current date and time
                                );

                                // Call your TripProvider to save trip information
                                await Provider.of<WayProvider>(context,
                                        listen: false)
                                    .saveWaybillInfo(context, waybill);
                                // await saveUserWaybillToSharedPreferences(
                                //     widget.userId, [waybill]);
                                Provider.of<NotificationProvider>(context,
                                        listen: false)
                                    .addNotification(
                                  NotificationModel(
                                    id: UniqueKey().toString(),
                                    title: 'New Item Recorded',
                                    description:
                                        'Your Waybill has been Recorded. Do well to report any abnormalities.',
                                    timestamp: DateTime.now(),
                                  ),
                                );

                                setState(() {
                                  loading = false;
                                });
                                showToast(
                                    message: 'Waybill added successfully');
                                // ignore: use_build_context_synchronously
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const bottomNav(
                                      userId: '',
                                    ),
                                  ),
                                );
                              } else {
                                showToast(message: 'Error adding waybill item');
                              }
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
                            child: loading
                                ? Container(
                                    width: 24,
                                    height: 24,
                                    child: const CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors
                                              .white), // Set the color of the stroke
                                    ),
                                  )
                                : const Text(
                                    'Submit',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  )),
                      ),
                    ) // Add more form fields for waybill details
                  ],
                ),
              ),
            ),
          );
        });
  }
}

enum Gender { Male, Female, Other }

class PassengerForm extends StatefulWidget {
  final TextEditingController controller;
  final String userId;

  const PassengerForm(this.controller, {Key? key, required this.userId})
      : super(key: key);

  @override
  State<PassengerForm> createState() => _PassengerFormState();
}

class _PassengerFormState extends State<PassengerForm> {
  final _formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final emergContactnameCtrl = TextEditingController();
  final emergContactphoneCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final originationCtrl = TextEditingController();
  final destinationCtrl = TextEditingController();
  // final NotificationService notificationService = NotificationService();

  Gender? selectedGender;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TripProvider>(
        create: (context) => TripProvider(),
        builder: (context, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const Center(
                    //     child: Text('Passenger Form',
                    //         style:
                    //             TextStyle(fontSize: 18, fontFamily: 'Inter'))),
                    TextFormField(
                      controller: nameCtrl,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'Inter',
                            fontSize: 16),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.black), // Change the color here
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please fill in your name';
                        }
                        return null;
                      },
                    ),
                    DropdownButtonFormField<Gender>(
                      value: selectedGender,
                      onChanged: (value) {
                        setState(() {
                          selectedGender = value;
                        });
                      },
                      items: [
                        DropdownMenuItem(
                          value: Gender.Male,
                          child: Text(
                            'Male',
                            style: TextStyle(
                              color: Colors.black54,
                              fontFamily: 'Inter',
                              fontSize: 14,
                            ),
                          ),
                        ),
                        DropdownMenuItem(
                          value: Gender.Female,
                          child: Text(
                            'Female',
                            style: TextStyle(
                              color: Colors.black54,
                              fontFamily: 'Inter',
                              fontSize: 14,
                            ),
                          ),
                        ),
                        DropdownMenuItem(
                          value: Gender.Other,
                          child: Text(
                            'Other',
                            style: TextStyle(
                              color: Colors.black54,
                              fontFamily: 'Inter',
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                      decoration: const InputDecoration(
                        labelText: 'Gender',
                        labelStyle: TextStyle(
                          color: Colors.black54,
                          fontFamily: 'Inter',
                          fontSize: 16,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black, // Change the color here
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a gender';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: emergContactnameCtrl,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Emergency Contact (Name)',
                        labelStyle: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'Inter',
                            fontSize: 16),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.black), // Change the color here
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please fill in your emergency contact';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: emergContactphoneCtrl,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Emergency Contact(Phone Number)',
                        labelStyle: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'Inter',
                            fontSize: 16),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.black), // Change the color here
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please fill in your emergency contact';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: addressCtrl,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Address',
                        labelStyle: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'Inter',
                            fontSize: 16),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.black), // Change the color here
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please fill in your emergency contact';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: originationCtrl,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Origination',
                        labelStyle: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'Inter',
                            fontSize: 16),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.black), // Change the color here
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please fill in your emergency contact';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: destinationCtrl,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        labelText: 'Destination',
                        labelStyle: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'Inter',
                            fontSize: 16),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.black), // Change the color here
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please fill in your destination';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: SizedBox(
                          width: 300,
                          child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    loading = true;
                                  });

                                  // Get values from text controllers
                                  String name = nameCtrl.text;
                                  String emergencyNameContact =
                                      emergContactnameCtrl.text;
                                  String emergencyPhoneContact =
                                      emergContactphoneCtrl.text;
                                  String address = addressCtrl.text;
                                  String origination = originationCtrl.text;
                                  String destination = destinationCtrl.text;

                                  // Create a UserTrip object
                                  UserTrip trip = UserTrip(
                                    name: name,
                                    emergencyNameContact: emergencyNameContact,
                                    gender: selectedGender.toString(),
                                    emergencyPhoneContact:
                                        emergencyPhoneContact,
                                    address: address,
                                    origination: origination,
                                    destination: destination,
                                    dateTime:
                                        DateTime.now(), // Current date and time
                                  );

                                  // Call your TripProvider to save trip information
                                  await Provider.of<TripProvider>(context,
                                          listen: false)
                                      .saveTripInfo(context, trip);
                                  // saveUserTripsToSharedPreferences(
                                  //     widget.userId, [trip]);
                                  print('Trip data saved: $trip');

                                  Provider.of<NotificationProvider>(context,
                                          listen: false)
                                      .addNotification(
                                    NotificationModel(
                                      id: UniqueKey().toString(),
                                      title: 'New Trip Added',
                                      description:
                                          'Your trip has been Recorded do have a safe trip and do well to report any abnormalities.',
                                      timestamp: DateTime.now(),
                                    ),
                                  );

                                  setState(() {
                                    loading = false;
                                  });
                                  showToast(message: 'Trip added sucessfully');
                                  // ignore: use_build_context_synchronously
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const bottomNav(
                                        userId: '',
                                      ),
                                    ),
                                  );
                                } else {
                                  showToast(message: 'Error adding trip!');
                                }
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
                              child: loading
                                  ? Container(
                                      width: 24,
                                      height: 24,
                                      child: const CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(Colors
                                                .white), // Set the color of the stroke
                                      ),
                                    )
                                  : const Text(
                                      'Submit',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ))),
                    ) // Add more form fields for passenger details
                  ],
                ),
              ),
            ),
          );
        });
  }
}
