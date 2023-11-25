import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:manifest/Models/user.dart';
import 'package:manifest/Provider/provider.dart';
import 'package:manifest/screens/detailsScreen.dart';
import 'package:provider/provider.dart';

import '../Models/userTrips.dart';
import '../Models/waymodel.dart';
import '../Shared/shared.dart';

class DashuserScreen extends StatefulWidget {
  final String userId;
  const DashuserScreen({
    super.key, required this.userId,
  });

  @override
  State<DashuserScreen> createState() => _DashuserScreenState();
}

class _DashuserScreenState extends State<DashuserScreen> {
  late UserModel user;
  List<UserTrip> userTrips = [];
  List<WayTrip> wayTrips = [];
    Future<void> loadUserTrips() async{
    List<UserTrip> trips = await getUserTripsFromSharedPreferences(widget.userId);
    setState(() {
      userTrips = trips;
    });
  }

  Future<void> loadUserWay() async {
    List<WayTrip> waybills = await getUserWaybillFromSharedPreferences(widget.userId);
    setState(() {
      wayTrips = waybills;
    });
  }
  @override
  void initState() {
    super.initState();
    // fetchData();
    user = UserModel(
      name: '',
      phoneNumber: '',
      email:'',
      tripCount: 0,
      waybillCount: 0,
      reportCount: 0,
      waybillsHistory: [],
      tripsHistory: [],
    );

    loadUserTrips();
    loadUserWay();
    
  }
Future<UserModel> fetchData(String userId) async {
  try {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get();

    if (userDoc.exists) {
      UserModel user = UserModel(
        name: userDoc['name'],
        phoneNumber: userDoc['phone_number'],
        email: userDoc['email'],
        // Add other necessary fields
      );
      return user;
    } else {
      // If the document doesn't exist or user data is missing, handle accordingly
      throw Exception('User data not found');
    }
  } catch (e) {
    // Handle errors such as Firestore exceptions or any other error during data fetching
    throw Exception('Failed to fetch user data: $e');
  }
}
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
      return FutureBuilder<UserModel>(
     future: fetchData(user as String), // Replace fetchData with your method to fetch user data
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else {
          UserModel user = snapshot.data!;
    return Consumer<UserProvider>(builder: (context, userProvider, child) {
      userProvider.updateUser(user); 

      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text('Welcome ${user.name}',
                style: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'Inter',
                )),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 6.0),
              child: IconButton(
                  icon: const Icon(Icons.notifications_active),
                  onPressed: () {}),
            )
          ],
          backgroundColor: const Color(0xFFf6fafd),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: size.height,
            width: size.width,
            decoration: const BoxDecoration(
              color: Color(
                  0xFFf6fafd), // Set the background color using a BoxDecoration
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    color: const Color(0xFF2062ff),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      height: 200,
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/img/intro.png',
                            height: 500,
                            width: 100,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Manifest',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'inter',
                                            fontStyle: FontStyle.italic,
                                            fontSize: 16)),
                                    Text(
                                      'Add a level of security for your loved ones on board with the Manifest app, Keep track, in real time of who and what is important to you.',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'inter',
                                          fontSize: 10),
                                      softWrap: true,
                                    ),
                                  ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 215.0),
                  child: Text('Overview',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'inter',
                          fontSize: 20)),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Card(
                        color: const Color(0xFFfec104),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                          height: 100,
                          width: 100,
                          child: Center(
                              child: Column(
                            children: [
                              Text(
                                '${user.tripCount}',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 35,
                                    fontFamily: 'inter'),
                              ),
                              const Text(
                                'Trips',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0XFF9c7822),
                                    fontFamily: 'inter'),
                              )
                            ],
                          )),
                        ),
                      ),
                      Card(
                        color: const Color(0xFFdf07d6),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                          height: 100,
                          width: 100,
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  '${user.waybillCount}',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 35,
                                      fontFamily: 'inter'),
                                ),
                                const Text(
                                  'Waybills',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color(0XFF892184),
                                      fontFamily: 'inter'),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        color: const Color(0xFF07d4e7),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                          height: 100,
                          width: 100,
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  '${user.reportCount}',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 35,
                                      fontFamily: 'inter'),
                                ),
                                const Text(
                                  'Reports',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color(0XFF22848e),
                                      fontFamily: 'inter'),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 250.0),
                  child: Text('History',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'inter',
                          fontSize: 20)),
                ),
                     SizedBox(
                      height:200,
                       child: Padding(
                         padding: const EdgeInsets.only(left:8.0, right: 8.0),
                         child: ListView.builder(
                            itemCount:
                                user.waybillsHistory.length + user.tripsHistory.length,
                            itemBuilder: (context, index) {
                              if (index < user.waybillsHistory.length) {
                                // Build a card for waybill
                                WayTrip waybill = user.waybillsHistory[index];
                                return buildWaybillCard(context, waybill);
                              } else {
                                // Build a card for trip
                                int tripIndex = index - user.waybillsHistory.length;
                                UserTrip trip = user.tripsHistory[tripIndex];
                                return buildTripCard(context, trip);
                              }
                            },
                          ),
                       ),
                     ),
              ],
            ),
          ),
        ),
      );
      
    });
        
  }}});    
  }
}

Widget buildWaybillCard(BuildContext context, WayTrip waybill) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>  DetailScreen(
             origination: waybill.origination,
            destination: waybill.destination,
            dateTime: waybill.dateTime.toString(),
            waybillNumber: waybill.wayNumber,
          ),
        ),
      );
    },
    child: Card(
      color: const Color(0xFF9db0da),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: const Icon(Icons.local_shipping), // Waybill icon
        title: Text(
          'From: ${waybill.origination} to: ${waybill.destination}',
          style: const TextStyle(
              color: Color(0xFFd4dced), fontSize: 15, fontFamily: 'inter'),
        ),
        subtitle: const Text(
          'Description: Waybill',
          style: TextStyle(
              color: Color(0xFFd4dced), fontSize: 10, fontFamily: 'inter'),
        ),
      ),
    ),
  );
}

Widget buildTripCard(BuildContext context, UserTrip trip) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>  DetailScreen(
            origination: trip.origination,
            destination: trip.destination,
            dateTime: trip.dateTime.toString(), 
            waybillNumber: null,
          ),
        ),
      );
    },
    child: Card(
      color: const Color(0xFF9db0da),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: const Icon(Icons.directions_car), // Trip icon
        title: Text(
          'From: ${trip.origination} to: ${trip.destination}',
          style: const TextStyle(
              color: Color(0xFFd4dced), fontSize: 15, fontFamily: 'inter'),
        ),
        subtitle: Text(
          'Date: ${trip.dateTime}',
          style: const TextStyle(
              color: Color(0xFFd4dced), fontSize: 10, fontFamily: 'inter'),
        ),
      ),
    ),
  );
}
